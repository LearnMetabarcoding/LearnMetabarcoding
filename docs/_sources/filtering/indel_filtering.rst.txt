.. _indel_filtering:

====================================
3) Indel Filtering
====================================

.. toctree::
	:hidden:

	extensions/more_variable_region

In this case, I use the term indel to mean insertions or deletions from PCR or sequencing errors rather than natural mutations. The fundamental assumption here is that the sequenced region is sufficiently conserved that there will not be any naturally-occuring indels sequenced, because these would have been deleterious and the organism would not have survived to have been sampled.

Thus, you should think carefully about how to apply this type of filtering to your own data depending on the barcode region used. Insertions or deletions are easy to spot because they will change the length of the sequence from what is expected based on the primers. While filtering based on length primarily removes indels, it can also be used to remove other reads that are clearly erroneous for other reasons.

Before we start, let’s double-check the length distribution of our reads. We can do this using a command we used before, having adapted the command for fastas (where the sequences are every other line, rather than every 4 lines):

.. code-block:: bash 

	$ sed -n '2~2p' ​file​ | while read l; do echo ${#l} ; done | sort | uniq -c

Oh dear, what’s happened to our reads? Check the first 10 lines of the fasta:

.. code-block:: bash 

	$ head -n 10 ​file

VSEARCH, although it’s great in many respects, outputs files in wrapped format, which means it starts a new line after 80 sequence characters. While this is nicer to look at, this is a pain for using quick-and-easy tools to summarise data on the linux command line. So we must run a quick command first to unwrap this data:

.. code-block:: bash 

	$ perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' ​infile​ > ​outfile

Use the output from this in the sed command above.

If we have a very variable region, we might not want to do any filtering at all, or we may know a reasonable range of lengths within which we expect our reads to fall. There are lots of tools for length filtering; we’ll use VSEARCH again - in fact, the ``​--fastx_filter`` command again. Let’s try filtering with quite a wide range:

.. code-block:: bash 

	$ vsearch --fastx_filter ​in.fasta --fastq_minlen 400 --fastq_maxlen 440 --fastaout out.fasta​

In this case, the region of CO1 we use is sufficiently conserved that, on balance of probabilities, any insertions or deletions are due to PCR and/or sequencing errors, and/or maybe errors with the pair merging we did, rather than natural mutations. So, if you have a strict length expectation for your reads, you can exclude any reads longer or shorter than this value.

* Run the filtering again, this time allowing no variants from our target length of 418bp

If you want to learn about coding regions that expect no single-base indels but is overall more variable and could have established whole codon changes then go to this :ref:`extension task<more_variable>`. 
Alternatively, go on to the :ref:`Frequency filtering / denoising section<denoising>`.