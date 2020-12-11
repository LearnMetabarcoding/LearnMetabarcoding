.. _denoising:

====================================
4. Frequency filtering / denoising
====================================

Due to the use of PCR to generate metabarcoding datasets, we should generate plenty of copies of the amplicon of interest, and thus many reads - depending on sequencing depth, of course. We can therefore be relatively confident that sequences that occur at very low frequencies in the dataset are more likely to be errors.

These can be filtered out with a simple threshold, although the selection of this threshold is likely to be dataset-dependent.

We can actually do this as part of the dereplication command we just did. Try running the command from the last section again, with the same input and adding the argument ``minuniquesize 1`` ​to get rid of all singleton sequences. **​Use a different output filename​**, we’re not going to keep this output. See the solution below if you get stuck!

.. admonition:: Solution
	:class: toggle

	``$ vsearch --derep_fulllength ​in.fasta​ --output ​out.fasta​ --sizeout --relabel uniq --minuniquesize 1``

A much more sophisticated approach to filtering errors is denoising. Denoising algorithms use read frequency and sequence composition to infer likely sequencing errors. Instead of doing the size filtering as part of dereplication, we will instead do it as part of a denoising command. We will use the unoise3 algorithm, implemented again in VSEARCH. Your input file here should be the output from dereplicating in the last section.

.. code-block:: bash 

	$ vsearch --cluster_unoise ​in.fasta​ --minsize 4 --unoise_alpha 2 --centroids out.fasta

The key parameter here is the alpha parameter, which determines the threshold level of dissimilarity between frequent and infrequent reads for exclusion of infrequent reads. Note that we’re using a less conservative minsize threshold than the default of 8 because of the smaller size of our dataset.

* What is the effect on the number of sequences and size distribution of those sequences of varying the alpha parameter? You can get the size distribution by running

.. code-block:: bash 

	$ grep "^>" ​in.fasta​ | sed -e "s/size=\([^;]\)/\1/" | sort | uniq -c

Some researchers argue that denoising should be run at the level of the individual sample, not the dataset as a whole, because the frequency of reads is only meaningful relative to individual pools of amplicons. What do you think? If you’ve got the time, come back to this section later and do the following:

* Run ``vsearch --fastx_filter`` on each separate sample fastq file using a loop

* Run dereplication on each sample fasta separately using a loop

* Run denoising on each sample fasta separately using a loop

* Concatenate the results using sed and re-run dereplication using the following command: 

.. code-block:: bash 
	
	$ vsearch --derep_fulllength ​in.fasta --sizein --sizeout --relabel uniq --output out.fasta

* Compare the total unique read numbers and size distribution to the version produced earlier

You're now ready to move onto the :ref:`next step.<point_error>`

