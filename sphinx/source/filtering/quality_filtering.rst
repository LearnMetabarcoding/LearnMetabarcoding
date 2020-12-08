.. _quality_filtering:

==========================
1) Quality Filtering
==========================

.. toctree::
	:hidden:

	fundamentals/phred_scores

Quality filtering aims to remove sequences that contain sequencing errors. If you are unfamiliar with what phred scores are, have a look :ref:`here <phred_scores>` first.

As you can imagine, there are many ways that Phred scores can be used to filter sequences. The three common ones are:

* Excluding reads with any scores below a threshold

* Trimming ends from reads based on a threshold

* Excluding reads based on number or rate of expected errors 

All three are commonly used in amplicon filtering.

With paired amplicons, we know that the end of the read is likely to be lower quality; but we have already merged our pairs. The quality scores in the middle of our reads have been adjusted to take account of the duplicate data, so in general it’s unlikely we have any specific poor regions of our reads. Excluding reads entirely based on quality is a more conservative approach and is generally suggested here.

For basic fastq filtering based on minimum score, we will use fastq_quality_filter from the fastx_toolkit package. This is a great little package of handy tools available `here <http://hannonlab.cshl.edu/fastx_toolkit/index.html>`_ 

We will use the fastx_filter function from the VSEARCH software for filtering by expected error and expected error rate. VSEARCH is a software package specifically designed for metabarcoding, based on the USEARCH package but completely free and open source. We’ll see other tools from this useful package later; you can read the documentation `here. <https://github.com/torognes/vsearch>`_

Let’s try doing some different sorts of quality filtering. Here are some commands.

Exclude any reads with quality score lower than 13 (probability of error ≈ 0.05):

.. code-block:: bash 

	$ fastq_quality_filter -q 13 -p 100 -i ​in.fastq​ -o ​out.fastq

Exclude any reads with fewer than 60% of bases with a quality score equal to or greater than 30 (p =
0.001):

.. code-block:: bash 
	
	$ fastq_quality_filter -q 30 -p 60 -i ​in.fastq​ -o ​out.fastq

Exclude any reads with more than 1 expected errors over the entire read:


.. code-block:: bash 

	$ vsearch --fastx_filter ​in.fastq​ --fastq_maxee 1 --fastaout ​out.fasta

Exclude any reads with more than 0.1 expected errors per base: 

.. code-block:: bash 

	$ vsearch --fastx_filter ​in.fastq​ --fastq_maxee_rate 0.1 --fastaout ​out.fasta

* Compare the number of reads returned with different filters using ``​grep​``. Note that ``fastq_quality_filter`` returns fastq files, but vsearch returns fastas. The regex for fastas should be "^>".

* Can you adjust the filters to get roughly the same number of reads filtered out using the different methods?

* Do you think these are the same reads that are being filtered each time?

Which quality filtering parameter to pick? Well, it depends partly on the nature of the data, partly on the aim of your filtering, and partly on what feels right to you.

*In my opinion, filtering based on the number of expected errors makes sense: there is a logical basis for the selection of the threshold, the removal of reads based on their overall likelihood of error, not some relatively arbitrary threshold of minimum quality score. While obviously this value increases with the length of the read, so could be argued isn’t a comparable value between different fragment lengths, my argument would be that it’s a reflection of the reality of sequencing, and that no matter how long my fragment is, I don’t want any errors. So I generally filter using* ``​--fastq_maxee 1`` ​. *If I suspect from later examination that I still have a lot of sequencing errors, I’ll reduce this to* ``--fastq_maxee 0.5`` . *If in the very rare case I’m simply not getting enough sequences returned, I might loosen this to* ``-​-fastq_maxee 1.5`` *or even* ``2`` *,​ but generally this data isn’t really trustworthy.* 

* Keep whichever one of your filtered fastas you like best. Delete the rest. This file will be the file used for the next step.

If you pick the output of ``fastq_quality_filter`` , you will need to convert this output to fasta using:

.. code-block:: bash 

	$ fastq_to_fasta -i ​in.fastq​ -o ​out.fasta

You can now move onto the next section on :ref:`dereplication<dereplication>`.