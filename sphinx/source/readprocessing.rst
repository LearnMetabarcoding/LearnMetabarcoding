.. _read_processing:

==========================================
Read processing
==========================================

.. toctree::
	:hidden:
	
        processing/fastq
        processing/demultiplexing
        processing/primer_removal
        processing/pair_merging
        processing/data_concat

------------------------------------------
Introduction
------------------------------------------

Read processing is our name for the low-level steps required to process raw sequence reads as they would be recieved from a sequencer. You can think of these steps as like the compilation of data from field notes into a spreadsheet: we use contextual information to organise the data, remove extraneous information, bring together data that belongs in the same place and correct or remove any errors. We call this low-level because many of these steps are conceptually simple and not necessarily exclusively metabarcoding-focused. Nonetheless, these processes are crucial to successful metabarcoding, as inappropriate choice of software or parameters here may have substantial impacts on the later results.

-------------------------------------------
Getting the data
-------------------------------------------

You should already have downloaded the data and placed it on the machine you are using (see here), and that you are in a fresh, empty directory ready to get started. We will start by copying over the ``0_rawsequences/`` directory which contains raw sequence files as recieved from the sequencer.

.. code-block:: bash
	
	$ cp -r /LMB/resources/metabarcoding/0_rawsequences ~/

-------------------------------------------
Next steps
-------------------------------------------

If you are completely new to sequence data, you might want to review the FASTQ format. Otherwise, you should work through the subpages in this section, as follows:

1. Demultiplexing: the separation of data from different samples that was sequenced together
2. Primer removal: trimming these sequences from our reads
3. Pair merging: the joining of overlapping paired end sequences (see also pair concatenation if paired end sequences don't overlap)
4. Quality filtering: removing reads with errors

.. note::

The first three steps in this pipeline could be performed in any order. We structure them in this order for a few reasons. Firstly, pair merging is a computationally intensive task, so by employing this last of the three we get a small speedup by not having to process any reads rejected in the previous steps. Secondly, demultiplexing separates out samples that may belong to different projects and may not need to be processed together, so it makes sense to do this first.

