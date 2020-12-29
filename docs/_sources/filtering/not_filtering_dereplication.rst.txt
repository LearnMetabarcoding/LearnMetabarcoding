.. _dereplication:

================================
2. (not filtering) Dereplication
================================

Introduction
============

Our concatenated FASTA file contains all putatively valid reads for our project. Now that we have used and discarded the quality data, we can now go through all of these reads and find all of the different unique sequences that are represented in our project. This stage is called dereplication, because we drop all the replicate reads, although we do keep a record of how many reads each unique sequence has in the dataset.

From now on, the main purpose is to find these unique sequences and filter out those that may be erroneous. For now, we ignore the source of these sequences; the dataset is considered as a whole with (largely) no reference to the individual samples. There is no need for this filtering process to be performed on many thousands of reads if lots of them are identical; better to dereplicate and reduce our data size to speed up what are generally quite computationally intensive tasks.

.. admonition:: Data and software
	:class: green 
	
	The input data for this tutorial is a FASTA file comprising all of the reads in your dataset. If you're following along step-by-step, this was produced :ref:`the previous tutorial<quality_filtering>`. Alternatively, the file ``4_mbc_concat.fasta`` within the :ref:`sectionB archive<sectionBdata>` can be used as example data.
	
	This tutorial uses the :ref:`**VSEARCH**<vsearch>` software.
	

Performing dereplication
========================

Dereplication is a pretty straightforward task - there are very few parameters to worry about. Therefore choosing a tool for dereplication has few considerations, and is often a matter of convenience. We will use the dereplication function within **VSEARCH**, because we probably already **VSEARCH** installed for other steps.

.. parsed-literal::
	
	vsearch --derep_fulllength ​:ref:`input.fasta` --output :ref:`output.fasta` --sizeout --relabel uniq

.. admonition:: Exercise
	
	* Run the above command, remembering to replace ``input.fasta`` with the input file (see the Data and software box above), and ``output.fasta`` with a sensible name.
	* Use ``head`` on the output file to see how the sequence headers are formatted.
	* Use ``grep`` on the output file to count up how many unique sequences we have.

The ``--sizeout`` option is very important here. This records in the header of each unique sequence how many copies it has across the entire dataset. This piece of information is used by several downstream processes. We also relabeled the sequences with ``uniq`` and an arbitrary serial number. This isn't necessary, and the name we are using is arbitrary, but in our opinion this is a useful step to distinguish individual reads from the set of unique putatively biological sequences.

What are these sequences?
=========================

At this point, we have a set of unique amplicon sequences recovered from our metabarcoding project. It is not *all* of the unique sequences, we discarded many that lacked indices or primers, wouldn't merge or were poor quality, but we are confident that this set contains all of our real amplicons, although we suspect it probably still contains many errors. This set of sequences is sometimes known as Amplicon Sequence Variants (ASVs) or Exact Sequence Variants (ESVs). These putatively represent all unique variants of the CO1 locus in our project metacommunity, so could be considered to be the set of haplotypes or unique biological variants in our study. We will refer to these as ASVs from now on.

For now, though, we know that there are highly likely to be errors present in our ASVs, so the next steps will try different methods to remove these errors and increase the proportion of our ASVs that are true biological sequences of our locus of interest.

Next Steps
==========

Next we will use the "size" information (counts of occurence of each ASV in the whole dataset) as a basis to filter out possible errors through :ref:`3. Frequency filtering <denoising>`.
