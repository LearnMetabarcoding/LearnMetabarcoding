.. _quality_settings: 

================================
Extension: Quality Settings
================================

Because primers are a region on our sequence that we have some ​*a priori*​ knowledge about, this is a good opportunity for filtering sequences with errors.

.. admonition:: Exercise
	Try running primer trimming with the strictest settings, a 100% match in length and bases - is this sensible?

Many metabarcoding pipelines trim primers by just trimming a number of bases equal to the primer length off the beginning of each read. You can do this in cutadapt using the ​``-u`` ​option, which you would need to do for each direction separately (replacing ``N`` with the correct primer length:

.. code-block:: bash 

	$ cutadapt -u ​N -o ​out.fastq​ -i ​in.fastq

.. admonition:: Exercise
	Try running this command for the forward and reverse reads of sample. If you look at the number of reads, this clearly retains more. What might be the downsides of doing it this way?
