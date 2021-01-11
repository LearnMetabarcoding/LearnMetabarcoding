.. _read_processing:

==================
A: Read processing
==================

.. toctree::
	:hidden:
	
	processing/fastq
	processing/demultiplexing
	processing/primer_removal
	processing/pair_merging
	processing/data_concat

Introduction
============

Read processing is our name for the low-level steps required to process raw sequence reads as they would be received from a sequencer. You can think of these steps as like the compilation of data from field notes into a spreadsheet: we use contextual information to organise the data, remove extraneous information, bring together data that belongs in the same place and correct or remove any errors in data organisation. We call this low-level because many of these steps are conceptually simple and not necessarily exclusively metabarcoding-focused. Nonetheless, these processes are crucial to successful metabarcoding, as inappropriate choice of software or parameters here may have substantial impacts on the later results.

.. admonition:: Data
	:class: green
	
	The starting point for this section is set of FASTQ files comprising raw sequence reads. If you want to use our example data, you can download a zip archive of the data for all of the tutorials in this section :ref:`here <sectionAdata>`. Unzip this to a convenient location.

Next steps
==========

If you want to follow through the course step-by-step, you should work through the tutorials in this section as follows:

1. :ref:`Demultiplexing <demultiplexing>`: the separation of data from different samples that was sequenced together.
2. :ref:`Primer removal <primer_removal>`: trimming primer sequences from our reads
3. :ref:`Pair merging <pair_merging>`: the joining of overlapping paired end reads (see also :ref:`pair concatenation<pair_concatenation>` if paired end sequences don't overlap)
4. :ref:`Data concatenation <data_concat>`: bringing all the data together

.. admonition:: Note
	:class: green
	
	The first three steps in this section could be performed in any order. We structure them in this order for a few reasons. Firstly, pair merging is a computationally intensive task, so by employing this last of the three we get a small speedup by not having to process any reads rejected in the previous steps. Secondly, demultiplexing separates out samples that may belong to different projects and may not need to be processed together, so it makes sense to do this first.

