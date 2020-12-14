.. _filtering:

=======================
Filtering Amplicon Data
=======================

.. toctree::
	:hidden:

	filtering/quality_filtering
	filtering/not_filtering_dereplication
	filtering/freq_filtering_and_denoising
	filtering/indel_filtering
	filtering/point_error
	filtering/chimera_filtering


Introduction
============

In the previous section we went from raw sequence data to processed complete amplicons of our target locus. This section assumes that you've processed the raw data as described in the four parts of the :ref:`Read Processing section<read_processing>`: if you haven't done this, you can head to that section to work through those exercises.

As part of the read processing we excluded possibly erroneous sequences, based on missing index or primer sequences or an inability to merge. However there likely remain many further erroneous sequences in our dataset, and the purpose of this section is to remove as many of these as possible in order to isolate only the biologically meaningful sequences

Getting the data
================

If you've worked through the previous section, you should have a file named ``mbc_concat.fastq``. This single :ref:`FASTQ<fastq>` file contains amplicon reads and quality scores sorted by sample, with indices and primers trimmed and mate pairs merged.

We don't recommend it, but if you want to skip over the Read Processing section you can copy this file from the project data folder to your current working directory with the following command.

.. code-block:: bash
	
	$ cp /AMM/resources/metabarcoding/mbc_concat.fasta

Sources of error
================

Erroneous sequences may arise through many processes, but these can generally be organised into several main sources:

.. topic:: PCR errors

	It is likely that the numerical majority of errors arise during PCR, either through errors in transcription or by the formation of chimeric fragments. The latter term is used to describe cases where DNA from different source organisms incorrectly binds together to form a DNA molecule that no longer accurately reflects the genome of any real organism. PCR errors are so frequent because of the high chance of stochastic errors in the biochemical reactions and because the exponential amplification of sequences can cause errors to propogate into many individual fragments

.. topic:: Sequencing errors

	Sequencing errors occur when the sequencer incorrectly reads a base position.

.. topic:: Bioinformatic errors

	Depending on the bioinformatic processes performed, it may be that incorrect or inappropriate application of software or parameters could cause errors to arise. For example, lax settings for pair merging may cause the merging of putative mate pairs that are not truly from the same fragment, or inappropriate adapter, index or primer trimming could over-trim or under-trim bases from reads.

.. topic:: Non-target sequences

	The use of highly degenerate primers can cause the co-amplification of DNA that is not the target of the metabarcoding research project. One source of this non-target DNA is material that has contaminated our samples. Another major source are non-target pseudogenes or NUMTs. These are analogues of the target locus that are present elsewhere in the genome of the target organism, having arisen through erroneous transposition or another method.

There are many ways that we can try to remove these errors, with different levels of certainty about the approach. This section will cover several methods: these are illustrated in the table below, alongside indications of what types of errors these methods target.

+-----------------------+------------+-------------------+----------------------+----------------------+
| Approach              | PCR errors | Sequencing errors | Bioinformatic errors | Non-target sequences |
+=======================+============+===================+======================+======================+
| Quality Filtering     |            | **✓**             |                      |                      |
+-----------------------+------------+-------------------+----------------------+----------------------+
| Indel Filtering       |  **✓**     |  **✓**            |  **✓**               |  **✓**               |
+-----------------------+------------+-------------------+----------------------+----------------------+
| Frequency Filtering   |  **✓**     |  **✓**            |  **✓**               |  **✓**               |
+-----------------------+------------+-------------------+----------------------+----------------------+
| Denoising             |  **✓**     |  **✓**            |  **✓**               |                      |
+-----------------------+------------+-------------------+----------------------+----------------------+
| Point Error Filtering | **✓**      |  **✓**            |  **✓**               |  **✓**               |
+-----------------------+------------+-------------------+----------------------+----------------------+
| Chimera Filtering     | **✓**      |                   |  **✓**               |                      |
+-----------------------+------------+-------------------+----------------------+----------------------+

Next Steps
==========

Once you've made sure you have the data (see above), you should work through the subpages in this section in order, as follows:

1. Quality Filtering
2. Not Filtering: Dereplication
3. Denoising
4.
5.
6.

.. admonition:: Note
	:class: green
	
	As in the previous section, we present each of these filtering steps separately, with separate commands, in a linear order. In practice, some of these commands could be combined together, as some software can perform multiple types of filtering at once. However we present them separately for instructional purposes, to better isolate and understand each step.
	
	Given we start with FASTQ files, it is necessary we perform quality filtering first, as this also strips out the quality data and outputs FASTA files, the required format for all of the other filtering tools. Many of the other filtering methods could be performed in any order, but denoising is most effective when performed on data that has *only* been quality filtered. This is explained in more detail on the denoising page.
	

