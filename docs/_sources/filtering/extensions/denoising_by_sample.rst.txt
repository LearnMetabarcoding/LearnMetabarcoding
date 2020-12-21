.. _denoise_by_sample:

==============================
Extension: Denoising by sample
==============================

Here we will denoise by each individual sample, rather than on the entire dataset. This requires us to go back to the data generated in an earlier step. We strongly recommend making a separate directory to perform this experimentation in, and using clear file names so you don't get the data mixed up!

We will be using the output data from the Read Merging step. This should be a single directory containing one fastq file per sample. 

.. admonition:: Exercise

	1. Quality filter each fastq file using the ``vsearch --fastx_filter...`` command from the Quality Filtering section, but running individually on each sample one at a time using a bash loop.
	
	2. Run the dereplication command (``vsearch --derep_fulllength...``) from the Dereplication section on each sample individually using a bash loop
	
	3. Run the denoising command (``vsearch --cluster_unoise...``) from the Denoising section on each sample individually using a bash loop
	
	4. Concatenate the result files using ``sed`` in the same way as in the Data Concatenation section.
	
	5. Re-dereplicate the output file using the following command:
	
	.. code-block:: bash 
		
		$ vsearch --derep_fulllength ​in.fasta --sizein --sizeout --relabel uniq --output out.fasta
	
	6. Compare the total unique read numbers and size distributions of your output to the version produced by whole-dataset denoising

.. admonition:: Solution
	:class: toggle
	
	.. code-block:: bash
		
		TODO

