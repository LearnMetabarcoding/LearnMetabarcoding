.. _prep_mitogenome_data:

============================
1. Preparing mitogenome data
============================

.. toctree::
	:hidden:

	fundamentals/genbank

Introduction
============

In this subsection, we will collect and consolidate our mitogenome data from multiple sources. 

Novel Reference Mitogenomes
===========================

We have generated a novel mitogenomes assemblies through sequencing of a set of reference specimens collected as part of same project as our example metabarcoding dataset. These mitogenomes were produced using the mitochondrial metagenomics (MMG) methodology, which you can read more about `here <ref to alex paper>`_

Download this set of mitogenomes to your working directory. TODO

Mitogenomes from GenBank
========================

We want to supplement these mitogenomes with some good data from GenBank in order to generate a more comprehensive tree. We will use mitogenome data from the NCBI RefSeq database, which holds the set of best-curated sequences on GenBank.

While we will obviously want to acquire some Coleoptera data, we should also include representatives from other taxa. Most importantly, we want to be able to validate the assignment of OTUs to other Insect orders that we observed using our taxonomic assignment methods. Given that CO1 is a fast-evolving gene, and we are just using a short, highly variable region, we should not expect that deep-level (i.e. order-level) relationships will be properly resolved on a tree based solely on this data. In other words, we shouldn’t necessarily assume that the beetles and non-beetles will form separate monophyletic clades on a tree if only the metabarcode region is used to separate them. So, we will also use data for a set of other Arthropod orders. 

If you’ve not previously acquired data from GenBank, or aren’t familiar with the GenBank file format, see this refresher on :ref:`how to download data from GenBank<genbank>`. You'll see that if we search for all Coleoptera or all Arthropods on GenBank, that we'll return a dataset of many thousands of mitogenomes. Not only will building trees with this many sequences be very time-consuming, but it’ll make our trees very complicated to view and understand. 

We have already searched GenBank and downloaded data for the Coleoptera and selected other Arthropods (Blattodea, Hemiptera, Lepidoptera, Diptera, Araneae, and Collembola), then filtered these down to one sequence per family for the Arthropods and no more than three sequences per family for the Coleoptera, to give a broad overview without having too much data. We have also checked and verified the annotations are accurate.

You can download these two files to your working directory. TODO

Next Steps
==========

Now we should have three genbank-format files. The next step is to :ref:`2. Extract Protein Coding Genes <extract_coding>`.
