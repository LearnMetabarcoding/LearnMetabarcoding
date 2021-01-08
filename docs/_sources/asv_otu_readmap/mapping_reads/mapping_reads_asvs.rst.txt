.. _mapping_reads_asvs:

.. role:: var

=================================
Mapping reads to ASVs
=================================

Introduction
============

Finding all exact copies of a single ASV in a dataset of reads is relatively straightforward, and there are tools available to automatically count up the copies and generate a nice table. However, as we discarded a lot of unique sequences as likely erroneous through our :ref:`filtering <filtering>` pipeline, a lot of reads will not be assigned to an ASV. If we are being strict, this is absolutely fine, as these reads are after all probably erroneous. However, these errors likely represent an erroneous version of a true ASV, and thus their presence in a sample may be meaningful as long as we can accurately assign them to the correct ASV - of course, therein likes the problem. In this subsection, we will first perform a strict assignment of reads to our ASVs, generating a tabular record of ASV occurence by sample. We will then review a slightly less strict alternative.

.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is two FASTA files, one containing all reads in your dataset and one comprising just filtered unique sequences (ASVs). If you're following along step-by-step, these were produced in the :ref:`quality filtering <quality_filtering>` and at the end of the :ref:`filtering <filtering>` section respectively. Alternatively, the files ``4_mbc_concat.fasta`` (reads) and ``9_mbc_final.fasta`` (ASVs) within the :ref:`sectionC archive<sectionCdata>` can be used as example data.
	
	This tutorial uses the :ref:`VSEARCH <vsearch>` software.

Reads data
==========

It is very important that the FASTA of read sequences contains a record of which sample each read came from, in the form of a ``;sample=XXX`` tag in the header lines of the FASTA. For example:

.. parsed-literal::
	
	>readsequence1;sample=sample1
	ATAGCATGACGCCGATAGCGATGA
	>readsequence2;sample=sample1
	CGATGACCCCGACCGATACTAGCG
	>readsequence3;sample=sample2
	ACGCCACGCAGTAGCAGACGACGA

The read names themselves (``readsequenceN`` in the example) are irrelevant, and the sample names can be any string as long as it doesn't contain ``;`` or ``=`` and is unique for each unique sample. Note that there can be a ``;`` after the sample name. See the :ref:`Data concatenation <data_concat>` tutorial for more information.

Strict mapping
==============

This process is conceptually straightforward: we search the reads FASTA against the ASVs looking for exact matches, and then for each exact match check the sample that read came from and tally the number of reads for each sample for each ASV. This is all done in a single step using a specific output format within the VSEARCH ``--search_exact`` command, as follows. Make sure you use your real file names!

.. parsed-literal::
	
	vsearch --search_exact :var:`reads.fasta` -db :var:`asvs.fasta` -otutabout :var:`output.tsv`
	

**VSEARCH** will print a record of how many reads found a match. The ``.tsv`` file extension just reminds you that the output is a Tab Separated Variables file, but this is just a specific layout of plain text so like all of our other files we can view it on the command line using ``cat`` or ``more``. However, it may have very long rows and thus be too messy to make sense. You can view a subset of it using the following command:

.. parsed-literal::
	
	head -10 :var:`input.tsv` | cut -f1-10
	

This command shows the first 10 lines of the file, and then the first ten tab-separated columns (of course, these include the row and column headings so it's only 9 rows/columns of data). Note that tab is the default delimiter for ``cut`` - if we had a Comma Separated Variables, or ``.csv`` file, we'd need to use ``cut -d,``

Note that the file will say ``OTU ID:`` in the first cell, obviously here we actually have ASVs but it doesn't know this.

.. admonition:: exercise
	
	* Use ``wc -l`` to print the number of rows of this file. Does this match the number of ASVs you expect? Obviously there'll be a difference of 1 to account for the column header row.
	* Download this file to your computer and open it in spreadsheet software or R.
	* Sum up the number of reads mapped for some different samples. Is it consistent?
	

You will have observed that a substantial proportion of all of your reads were not mapped at all, as expected. If we want to try and assign these reads to ASVs, we can try to map less strictly.

Less strict mapping
===================

The process here is almost identical to the above, except we allow matches of less than 100%. We are using **VSEARCH** again, because we know that when multiple matches are found for a query (read) in our database (ASVs), it will select the closest match (by similarity). You could do a similar process using **BLAST** or any other sequence matching algorithm, but now that we permit non-exact matches, there will be cases where a read matches multiple ASVs and you must be very very confident that the program you use selects 1. one and only one match for each read and 2. the best match for each read. For example, BLAST using ``-max_target_seqs`` does not necessarily select the best match, just the first one (TODO FOOTNOTE).

.. warning::

	If you choose to use this method you should be aware that while it will give you more reads per ASV overall, using non-exact matches has a higher probability of generating incorrect matches, i.e. reporting a read for an ASV in a sample that is not correct. If this is the first step of read mapping for OTUs, this is less of an issue because two very similar ASVs are likely to be grouped into the same OTU anyway, but when working with ASVs only, then these errors could impact the validity of later analyses.

The following command matches reads to ASVs with 99.5% similarity. Over a 418 bp amplicon as we are using in our example dataset, this allows for 2 differences between read and ASV. Remember that our reads aren't length-filtered, so these differences could be insertions or deletions as well as point differences.

.. parsed-literal::
	
	vsearch --usearch_global :var:`reads.fasta` -db :var:`asvs.fasta` -id 0.995 -otutabout :var:`output.tsv`
	

You should see an increase in the number of reads mapped using this method compared with the strict mapping above.

.. admonition:: Exercise
	
	* Try varying the ``-id`` value. What level do you need to go to to map all of your reads? Is this at all sensible? Why not?
	* If you want to understand more about how this search is being performed, replace ``--otutabout output.tsv`` with ``--uc output.uc``.
	* Examine the ``.uc`` file using ``more``. This is a report of all of all of the matches.

We would not recommend using this for studies looking at ASVs only, and if it must be employed then use a similarity value of at least 99% if not more. If working with OTUs, then you may be a little more relaxed, but the similarity value should never exceed approximately equivalent to the similarity value used in OTU clustering, and as a rough rule of thumb should probably be less than half of this value. I.e. if you performed 97% greedy clustering, the similarity value for your read mapping should probably be 98.5% or above. 

Next steps
==========

For working at the ASV level, the ``.tsv`` table you have produced is ready to be used in downstream analyses, although we would recommend some further filtering which we discuss in the :ref:`Analysing read tables <analysis>` tutorial. You may want to learn about building a phylogeny of your ASVs in the :ref:`Building OTU phylogeny <phylogeny>` section, or taxonomically identifying and/or classifying your ASVs in the :ref:`Identifying OTU sequences <otuid>` section.

For working at the OTU level, we cover how to reduce this ASV-level table you've produce to OTU level in the next subsection: :ref:`Mapping reads to OTUs <mapping_reads_otus>`.
