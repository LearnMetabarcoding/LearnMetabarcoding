.. _denoise_by_sample:

.. role:: var

==============================
Extension: Denoising by sample
==============================

Introduction
============

Here we will denoise by each individual sample, rather than on the entire dataset. This requires us to go back to the data generated in an earlier tutorial. We strongly recommend making a separate directory to perform this experimentation in, and using clear file names so you don't get the data mixed up!

.. admonition:: Data and software
	
	The input data for this tutorial is a directory containing one FASTQ or FASTA file per sample. If you've been following along step-by-step, this is the data produced in the :ref:`pair merging<pair_merging>` tutorial in the previous section. Alternatively, the ``3_merged`` directory within the :ref:`sectionA archive<sectionAdata>` can be used as example data.
	
	This extension uses the :ref:`**VSEARCH**<vsearch>` software.

Denoising by sample
===================

.. admonition:: Exercise

	1. If your input data is FASTQ files, quality filter each FASTA file using the ``vsearch --fastx_filter...`` command from the :ref:`quality filtering<quality_filtering>` tutorial, but running individually on each sample one at a time using a bash loop (hint: there's a loop command at the end of that tutorial).
	
	2. Run the dereplication command (``vsearch --derep_fulllength...``) from the :ref:`dereplication<dereplication>` tutorial on each sample individually using a bash loop
	
	3. Run the denoising command (``vsearch --cluster_unoise...``) from the :ref:`denoising<denoising>` tutorial on each sample individually using a bash loop
	
	4. Concatenate the result files using ``sed`` in the same way as in the :ref:`data concatenation<data_concat>` tutorial.
	
	5. Re-dereplicate the output file using the following command:
	
	.. parsed-literal::
		
		vsearch --derep_fulllength ​:var:`input.fasta` --sizein --sizeout --relabel uniq --output :var:`output.fasta`
	
	6. Compare the total unique read numbers and size distributions of your output to the version produced by whole-dataset denoising

