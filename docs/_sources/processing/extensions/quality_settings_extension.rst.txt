.. _quality_settings: 

================================
Quality Settings Extension 
================================

Because primers are a region on our sequence that we have some ​*a priori*​ knowledge about, this is a good opportunity for filtering sequences with errors.

* Try running primer trimming with the strictest settings, a 100% match in length and bases - is this sensible?

Many metabarcoding pipelines trim primers by just trimming a number of bases equal to the primer length off the beginning of each read. You can do this in cutadapt using the ​-u ​option, which you would need to do for each direction separately:

.. code-block:: bash 

	$ cutadapt -u ​n​ -o ​out.fastq​ -i ​in.fastq

* Try running this for the forward and reverse reads. If you look at the number of reads, this clearly retains more. What might be the downsides of doing it this way?