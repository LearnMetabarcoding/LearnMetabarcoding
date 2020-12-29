.. _quality_filtering:

==========================
1. Quality filtering
==========================

.. toctree::
	:hidden:
	
	fundamentals/phred_scores

Introduction
============

Quality filtering aims to remove sequences that contain sequencing errors, as determined by the sequencer's own quality scoring method. These scores are stored in the FASTQ file using phred scores. If you are unfamiliar with what phred scores are, have a look :ref:`here <phred_scores>` first.

As you can imagine, there are many ways that phred scores can be used to filter sequences. The three common ones are:

* Excluding reads with any scores below a threshold
* Trimming ends from reads based on a threshold
* Excluding reads based on number or rate of expected errors 

All three are commonly used in amplicon filtering.

With paired amplicons, we know that the end of the read is likely to be lower quality; however, we have already merged our pairs with the result that if our reads have any low-quality portions, it's the *middle* of the read, so selective trimming at this point is not a viable strategy. Excluding reads entirely based on quality is a more conservative approach and is generally suggested here.

.. admonition:: Data and software
	:class: green 
	
	The input data for this tutorial is a FASTQ file comprising all of the reads in your dataset, with the source sample for each read noted in the read's header. If you worked through :ref:`the previous section<read_processing>`, this was produced during the :ref:`concatenation<data_concat>` tutorial. Alternatively, the file ``4_mbc_concat.fastq`` file within the :ref:`sectionB archive<sectionBdata>` can be used as example data.
	
	This tutorial uses the :ref:`**fastx_toolkit**<fastx_toolkit` and :ref:`**VSEARCH**<vsearch>` software.

Quality threshold filtering
===========================

For basic fastq filtering based on minimum score, we will use **fastq_quality_filter** from the :ref:`**fastx_toolkit**<fastx_toolkit>` package.

This simple tool alows us to remove any reads that contain any bases with a quality score lower than the threshold we set. For example, let's keep only reads where 100% of the bases have a quality score greater than or equal to 13 (the equivalent of a 0.05 probability that that base is incorrect). The ``-v`` option reports the results to terminal for us. As always, replace ``input.fastq`` with the name of the file you're filtering (see the Data and software box above) and ``output.fasta`` with a sensible name to call the output.

.. parsed-literal::

	fastq_quality_filter -v -q 13 -p 100 -i ​:var:`input.fastq​` -o :var:`​output.fastq`

We can additionally specify a proportion of the bases that must meet our threshold using ``-p``. Following is another command that will keep only reads where 60% or more of the bases have a quality score equal to or greater than 30 (p = 0.001):

.. parsed-literal::
	
	fastq_quality_filter -v -q 30 -p 60 -i ​:var:`input.fastq​` -o :var:`​output.fastq`

.. admonition:: Exercise
	
	* Make a note of your filtering thresholds and the number of reads they returned.
	* Try out some different thresholds, keeping notes on the numbers that were rejected or retained.
	* Is there a way to select these thresholds without just making an arbitrary choice?

Quality rate filtering
======================

Rather than setting per-base quality thresholds, another approach is to analyse all of the error probabilities for a read and calculate the overall probability of the read having errors. For this, we will use the **fastx_filter** function from the :ref:`**VSEARCH**<vsearch>` package for filtering by expected error and expected error rate. 

Given that the quality scores are just a set of probabilities, we can calculate the expected number of errors in the read as a whole. The following command will exclude any reads that have one or more expected errors. Note the difference with the previous section: we don't necessarily ascertain if any particular base is incorrect, we simply calculate how many bases would, on average, be incorrect on a read with this set of quality scores.

.. parsed-literal::
	
	vsearch --fastx_filter :var:`​input.fastq​` --fastq_maxee 1 --fastaout ​:var:`output.fasta`

As you can imagine, the longer the read, the higher the chance that there is at least one error, simply by chance alone. So instead of basing our threshold on the total number of expected errors, we could base our threshold on the rate of errors. The following command will exclude any reads with more than 0.1 expected errors per base: 

.. parsed-literal::
	
	vsearch --fastx_filter ​:var:`input.fastq​` --fastq_maxee_rate 0.1 --fastaout ​:var:`output.fasta`

Choosing quality filtering thresholds
=====================================

.. admonition:: Exercise
	
	* Compare the number of reads returned with different filters. If you use ``​grep​`` for this, note that ``fastq_quality_filter`` returns fastq files, but vsearch returns fastas. The regex for fastas should be ``"^>"``
	* Can you adjust the filters to get roughly the same number of reads filtered out using the different methods? Is this meaningful?
	* Do you think these are the same reads that are being filtered each time?

Which quality filtering parameter to pick? Well, it depends partly on the nature of the data, partly on the aim of your filtering, and partly on what feels right to you.

.. admonition:: Our opinion
	:class: green
	
	In our opinion, filtering based on the number of expected errors makes sense: there is a logical basis for the selection of the threshold, the removal of reads based on their overall likelihood of error, not some relatively arbitrary threshold of minimum quality score. While obviously this value increases with the length of the read, so could be argued isn't a comparable value between different fragment lengths, my argument would be that it’s a reflection of the reality of sequencing, and that no matter how long my fragment is, we don’t want any errors. So we generally filter using ``​--fastq_maxee 1`` . If we suspect from later examination that we still have a lot of sequencing errors, we’ll reduce this to ``--fastq_maxee 0.5``. If in the very rare case we're simply not getting enough sequences returned, we might loosen this to ``-​-fastq_maxee 1.5`` or even ``2``,​ but generally this data isn't really trustworthy.

Next steps
==========

.. admonition:: Exercise
	
	* Based on your comparison of different filtering outputs, select whichever method you feel is most appropriate. Delete the rest. 
	* The selected output file will be the file used for the next step.
	
	If you pick the output of ``fastq_quality_filter`` , you will need to convert this output to fasta using:
	
	.. parsed-literal::
		
		fastq_to_fasta -i ​:var:`input.fastq​` -o :var:`​output.fasta`

We now have a FASTA file of all of our reads. This is an important file to retain, so make sure you keep a note of it. These reads will later be mapped to our final biological sequences to assess their occurence. Now that we have removed the quality data, we can now undertake dereplication in the next section: :ref:`2. Dereplication<dereplication>`.


.. admonition:: Note
	
	Here we present quality filtering after :ref:`concatenation<data_concat>` because it allows us to separate two distinct themes: the processing of raw sequence reads into samples, in section A, and the filtering of processed sequence reads to remove errors, in the section B. 
	
	However, when performing metabarcoding bioinformatics it may be more efficient to perform this quality filtering earlier, as it substantially reduces the data size. If you wanted to do this, you'd need to run quality filtering in a loop on all of your individual sample files. For example, if you wanted to quality filter your :ref:`primer-trimmed<primer_removal>` using vsearch, you'd run the following, replacing ``input`` with the name of the directory containing the files you want to quality filter, and ``output`` with the sensible name of a directory to place the filtered files in.
	
	.. parsed-literal::
		
		mkdir :var:`output`
		samples=$(ls :var:`input`/ | cut -d_ -f1 | sort | uniq)
		for s in $samples;
		do
			vsearch --fastx_filter :var:`input`/$s.fastq --fastq_maxee 1 --fastaout :var:`output`/$s.fasta;
		done
	
	You would then perform concatenation on the FASTA files as described in :ref:`that tutorial<data_concat>`
