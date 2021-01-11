.. _indel_filtering:

.. role:: var

====================================
4. Indel filtering
====================================

.. toctree::
	:hidden:

	extensions/more_variable_region

Introduction
============

In metabarcoding, we amplify a known region of the genome and thus we have an expectation about the length of the resulting amplicons. Insertions or deletions (indels) are changes to the DNA sequence that will affect the number of bases between two known points in the genome. While this term is commonly used to refer to real genetic mutations, we use it here to refer to insertions or deletions caused by PCR or sequencing errors. It is important to note that we cannot necessarily distinguish between true indel mutations and erroneous mutations. However, as in our example data we are operating on a protein coding sequence, we can assume that the vast majority of true indels are likely to be deleterious and therefore we would not observe these in our dataset drawn from living organisms. We can then draw conclusions about the validity of ASVs based on their length relative to the expected amplicon length. 

So, put simply, insertions or deletions are easy to spot because they will change the length of the sequence from what is expected based on the primers. While filtering based on length primarily removes indels, it can also be used to remove other reads that are clearly erroneous for other reasons.

.. admonition:: Important note

	You should think carefully about how to apply this type of filtering to your own data depending on the barcode region used. Protein coding markers will have relatively little length variation, but some may still exist depending on the marker used and the taxonomic breadth of your study. On the other hand, non protein coding markers will be substantially more variable and this must be taken into account to avoid removing substantial portions of your dataset.

.. admonition:: Data and software
	:class: green 
	
	The input data for this tutorial is a FASTA file comprising unique sequences (ASVs). If you're following along step-by-step, this was produced in :ref:`the previous tutorial<denoising>`. Alternatively, the file ``6_mbc_denoise.fasta`` within the :ref:`sectionB archive<sectionBdata>` can be used as example data.
	
	This tutorial uses the :ref:`VSEARCH <vsearch>` software.

Length distributions
====================

Before we start, let’s double-check the length distribution of our reads. Learn more about the ``sed`` command :ref:`here <sed>` - note we've adapted this command for FASTAs where the sequences are every other line, rather than every 4 lines):

.. parsed-literal::

	sed -n '2~2p' ​file​ | while read l; do echo ${#l} ; done | sort | uniq -c

Oh dear, what’s happened to our reads? Check the first 10 lines of the fasta:

.. parsed-literal::

	head -n 10 ​file

**VSEARCH**, although it’s great in many respects, outputs files in wrapped format, which means it starts a new line after 80 sequence characters. While this is nicer to look at, this is a pain for using quick-and-easy tools to summarise data on the Linux command line. So we must run a quick command first to unwrap this data:

.. parsed-literal::

	perl -pe '$. > 1 and /^>/ ? print "\\n" : chomp' :var:`input.fasta` > :var:`output.fasta`

:guilabel:`Use the output from this` in the ``sed`` command above to check the *real* length distribution of our reads.

Length filtering
================

If we have a very variable region, we might not want to do any filtering at all, or we may know a reasonable range of lengths within which we expect our reads to fall. There are lots of tools for length filtering; we’ll use **VSEARCH** again - in fact, the ``​--fastx_filter`` function again. Let’s try filtering with quite a wide range:

.. parsed-literal::

	vsearch --fastx_filter :var:`input.fasta` --fastq_minlen 400 --fastq_maxlen 440 --fastaout :var:`output.fasta​`

In this case, the region of CO1 we use is sufficiently conserved that, on balance of probabilities, any insertions or deletions are due to PCR and/or sequencing errors, and/or maybe errors with the pair merging we did, rather than natural mutations. So, if you have a strict length expectation for your reads, you can exclude any reads longer or shorter than this value.

.. admonition:: Exercise
	
	Run the filtering again, this time allowing no variants from our target length of 418bp

.. admonition:: Solution
	:class: toggle
	
	.. parsed-literal::
	
		vsearch --fastx_filter :var:`input.fasta` --fastq_minlen 418 --fastq_maxlen 418 --fastaout :var:`output.fasta​`

Next steps
==========

In our case, we have a very conserved region so we will use the output from the last command, i.e. only ASVs of 418bp long, for the next steps. Next, we will remove errors by checking the translation: :ref:`5. Point error filtering <point_error>`.

In some cases, we may be metabarcoding a coding locus but our project includes a wide taxonomic breadth or the region is more variable. Where you might expect length variation, but only in terms of whole codons, we have to do something a little more complicated. If you want, you can try this out in this extension: :ref:`Extension: Variable length coding regions <more_variable>`. You can use either output for the next steps.
