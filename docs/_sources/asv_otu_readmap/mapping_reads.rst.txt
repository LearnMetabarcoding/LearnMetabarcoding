.. _mapping_reads:

=============
Mapping reads
=============

.. toctree::
    :hidden:

    mapping_reads/mapping_reads_asvs
    mapping_reads/mapping_reads_otus
    mapping_reads/analysing_read_tables

Introduction
============

To understand a population or community, we need information about the members of a specific population or community sample. Until now, we've largely focused on uncovering all of the members of our meta-community, i.e. our entire dataset. Our dataset is (presumably) made up of more than one sample, however, so now that we have our set of unique members, i.e. ASVs or OTUs, we need to go back to our samples and look at which samples these members actually occur within.

As our ASVs represent unique sequences in our dataset, we will first map all of our by-sample reads to our ASVs. If you are only working at the ASV level, this is sufficient to generate a table of ASV occurence by sample. If you have grouped your ASVs into OTUs, we then need to similarly group parts of this table, and we do this based upon the file you generated during OTU delimitation that records which OTU each ASV was grouped into.

.. admonition:: Data
	:class: green
	
	The starting point for this section will depend on whether you're working at the OTU or ASV level.
	
	If working with ASVs only, you will need a FASTA file of unique ASV sequences and a FASTA file of all reads in your dataset. If you worked through :ref:`the previous section<filtering>`, these data were produced by the :ref:`chimera filtering<chimera>` and :ref:`quality filtering<quality_filtering>` tutorials respectively. 
	
	If you are working with OTUs, then you will need both of the above files, and also a FASTA file of your OTU sequence and a file recording the assignment of ASVs to OTUs as produced by your OTU delimitation method of choice in the :ref:`previous subsection <otudelim>`.
	
	If you didn't work through the previous section, you can download a zip archive of the data for all of the tutorials in this section :ref:`here <sectionCdata>`. Unzip this to a convenient location.

Next steps
==========

Whether using ASVs or OTUs, you should first head to the :ref:`Mapping reads to ASVs <mapping_reads_asvs>` tutorial. You will need your FASTA of ASVs and your FASTA of reads. If you are using OTUs, you should then progress to the :ref:`mapping reads to OTUs <mapping_reads_otus>` tutorial, which uses the data produced by the ASV subsection. Finally, the :ref:`analysing read maps <analysis>` tutorial discusses questions around filtering the outputs from read mapping.
