.. _filtering:

.. role:: var

======================
B: Filtering amplicons
======================

.. toctree::
	:hidden:
	
	filtering/quality_filtering
	filtering/not_filtering_dereplication
	filtering/freq_filtering_and_denoising
	filtering/indel_filtering
	filtering/point_error
	filtering/chimera_filtering
	filtering/metamate


Introduction
============

As part of the read processing we excluded possibly erroneous sequences, based on missing index or primer sequences or an inability to merge. However there likely remain many further erroneous sequences in our dataset, and the purpose of this section is to remove as many of these as possible in order to isolate only the biologically meaningful sequences.

.. admonition:: Data
	:class: green
	
	The starting point for this section is a FASTQ file comprising all of the reads in your dataset, with the source sample for each read noted in the read's header.
	
	If you worked through :ref:`the previous section<read_processing>`, this was produced during the :ref:`concatenation<data_concat>` tutorial.
	
	If you didn't work through the previous section, you can download a zip archive of the data for all of the tutorials in this section :ref:`here <sectionBdata>`. Unzip this to a convenient location.

Sources of error
================

Erroneous sequences may arise through many processes, but these can generally be organised into several main sources:

PCR errors
----------

It is likely that the numerical majority of errors arise during PCR, either through errors in transcription or by the formation of chimeric fragments. The latter term is used to describe cases where DNA from different source organisms incorrectly binds together to form a DNA molecule that no longer accurately reflects the genome of any real organism. PCR errors are so frequent because of the high chance of stochastic errors in the biochemical reactions and because the exponential amplification of sequences can cause errors to propogate into many individual fragments.

Sequencing errors
-----------------

Next generation sequencers are great at getting lots of data, but they are nowhere near perfect at accurately reading sequences, as you probably know. Sequencing errors occur when the sequencer incorrectly reads a base position, misses a base or reads a base that doesn't exist. This could be a single isolated error in a sequence, happen repeatedly throughout a sequence or tend to happen more in some areas of a sequence than another. For example, Illumina sequencers tend to be less accurate towards the end of reads. Usefully, there are methods sequencers can use to assess how certain they are about a base call (i.e. deciding whether a single base is ``A``, ``T``, ``C`` or ``G``, and these probabilities can be used for filtering. However, missing bases or incorrectly adding bases (which tends to happen when there are regions of a single repeated base) is harder to know about.

Bioinformatic errors
--------------------

Depending on the bioinformatic processes performed, it may be that incorrect or inappropriate application of software or parameters could cause errors to arise. For example, lax settings for pair merging may cause the merging of putative mate pairs that are not truly from the same fragment, or inappropriate adapter, index or primer trimming could over-trim or under-trim bases from reads.

Non-target sequences
--------------------

The use of highly degenerate primers can cause the co-amplification of DNA that is not the target of the metabarcoding research project. One source of this non-target DNA is material that has contaminated our samples. Another major source are non-target pseudogenes or NUMTs. These are analogues of the target locus that are present elsewhere in the genome of the target organism, having arisen through erroneous transposition or another method.

Removing errors
===============

There are many ways that we can try to remove these errors, with different levels of certainty about the approach. This section will cover several methods: these are illustrated in the table below, alongside indications of what types of errors these methods target.

+-----------------------+-------+------------+---------------+----------------------+
|                       | Errors|            |               |                      |
|                       +-------+------------+---------------+----------------------+   
| Approach              | PCR   | Sequencing | Bioinformatic | Non-target sequences |
+=======================+=======+============+===============+======================+
| Quality filtering     |       | **✓**      |               |                      |
+-----------------------+-------+------------+---------------+----------------------+
| Indel filtering       | **✓** | **✓**      | **✓**         |  **✓**               |
+-----------------------+-------+------------+---------------+----------------------+
| Frequency filtering   | **✓** | **✓**      | **✓**         |  **✓**               |
+-----------------------+-------+------------+---------------+----------------------+
| Denoising             | **✓** | **✓**      | **✓**         |                      |
+-----------------------+-------+------------+---------------+----------------------+
| Point error filtering | **✓** | **✓**      | **✓**         |  **✓**               |
+-----------------------+-------+------------+---------------+----------------------+
| Chimera filtering     | **✓** |            | **✓**         |                      |
+-----------------------+-------+------------+---------------+----------------------+

Next Steps
==========

If you want to follow through the course step-by-step, you should work through the tutorials in this section as follows:

1. :ref:`Quality filtering<quality_filtering>`: the removal of reads with low quality bases
2. :ref:`Dereplication<dereplication>`: the removal of duplicate sequences
3. :ref:`Denoising<denoising>`: the removal of putative "noise" error sequences
4. :ref:`Indel filtering<indel_filtering>`: the removal of remaining insertion or deletion errors leading to length variants
5. :ref:`Point error filtering<point_error>`: the removal of remaining point errors leading to translation variants
6. :ref:`Chimera filtering<chimera>`: the removal of chimeric sequences

.. admonition:: Note
	:class: green
	
	As in the previous section, we present each of these filtering steps separately, with separate commands, in a linear order. In practice, some of these commands could be combined together, as some software can perform multiple types of filtering at once. However we present them separately for instructional purposes, to better isolate and understand each step.
	
	Given we start with FASTQ files, it is necessary we perform quality filtering first, as this also strips out the quality data and outputs FASTA files, the required format for all of the other filtering tools. Many of the other filtering methods could be performed in any order, but denoising is most effective when performed on data that has *only* been quality filtered. This is explained in more detail on the denoising page.


