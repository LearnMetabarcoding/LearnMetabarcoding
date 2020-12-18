.. _mapping_reads:

=============
Mapping reads
=============

.. toctree::
    :hidden:

    mapping_reads/mapping_reads_asvs
    mapping_reads/mapping_reads_otus
    mapping_reads/analysing_read_maps

Introduction
============

To understand a population or community, we need information about the members of a specific population or community sample. Until now, we've largely focused on uncovering all of the members of our meta-community, i.e. our entire dataset. Our dataset is (presumably) made up of more than one sample, however, so now that we have our set of unique members, i.e. ASVs or OTUs, we need to go back to our samples and look at which samples these members actually occur within.

As our ASVs represent unique sequences in our dataset, we will first map all of our by-sample reads to our ASVs. If you are only working at the ASV level, this is sufficient to generate a table of ASV occurence by sample. If you have grouped your ASVs into OTUs, we then need to similarly group parts of this table, and we do this based upon the file you generated during OTU delimitation that records which OTU each ASV was grouped into.


Data Required
=============

For this subsection, you will need two to four data files. If working with ASVs only, you will need:
1. A FASTA file of unique ASV sequences, as generated at the end of the :ref:`Filtering <filtering>` section.
2. A FASTA file of all reads in your dataset, with ``;sample=XXX`` tags in the headers, as produced in the :ref:`Quality Filtering <quality_filtering>` subsection.
If you are working with OTUs, then you will also need a FASTA file of your OTU sequences, and a file recording the assignment of ASVs to OTUs as produced by your OTU delimitation software.

If you haven't been through the previous sections and don't have your own data, you can download these files for our toy data from XXXXX.


Next Steps
==========

Whether using ASVs or OTUs, you should first head to the :ref:`Mapping Reads to ASVs <mapping_reads_asvs>` subsection. You will need your FASTA of ASVs and your FASTA of reads. If you are using OTUs, you should then progress to the :ref:`Mapping Reads to OTUs <mapping_reads_otus>` subsection, which uses the data produced by the ASV subsection. Finally, the :ref:`Analysing Read Maps <analysing_maps>` subsection discusses questions around filtering the outputs from read mapping.
