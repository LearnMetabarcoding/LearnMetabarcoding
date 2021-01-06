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

.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is one or more genbank-format files containing mitogenome sequences from which you want to build a phylogeny. See details below for how you might acquire these.
	
	The files ``references_CCCPmitogenomes.gb``, ``references_GBcoleoptera.gb`` and ``references_GBarthropods.gb`` within the :ref:`sectionD archive<sectionDdata>` can be used as example data.
	

Novel Reference Mitogenomes
===========================

We have generated novel mitogenome assemblies through sequencing of a set of reference specimens collected as part of same project as our example metabarcoding dataset. These mitogenomes were produced using the mitochondrial metagenomics (MMG) methodology, which you can read more about `here <ref to alex paper>`_

These mitogenomes are stored in the ``references_CCCPmitogenomes.gb`` file (see the Data and software box above).

Mitogenomes from GenBank
========================

We want to supplement these mitogenomes with some good data from GenBank in order to generate a more comprehensive tree.

While we will obviously want to acquire some Coleoptera data, we should also include representatives from other taxa. Most importantly, we want to be able to ensure that any OTUs that are not from Coleoptera will not be assigned to Coleoptera simply because there is nowhere else in the tree for them to go. While we focused on Coleoptera, it's perfectly feasible that DNA from other taxa were present (see the :ref:`OTU identification section<otuid>` for more information). Given that CO1 is a fast-evolving gene, and we are just using a short, highly variable region, we should not expect that deep-level (i.e. order-level) relationships will be properly resolved on a tree based solely on this data. In other words, we shouldn’t necessarily assume that the beetles and non-beetles will form separate monophyletic clades on a tree if only the metabarcode region is used to separate them. So, we will also use data for a set of other Arthropod orders. 

If you’ve not previously acquired data from GenBank, or aren’t familiar with the GenBank file format, see this refresher on :ref:`how to download data from GenBank<genbank>`. You'll see that if we search for all Coleoptera or all Arthropods on GenBank, that we'll return a dataset of many thousands of mitogenomes. Not only will building trees with this many sequences be very time-consuming, but it’ll make our trees very complicated to view and understand. 

We have already searched GenBank and downloaded data for the Coleoptera and selected other Arthropods (Blattodea, Hemiptera, Lepidoptera, Diptera, Araneae, and Collembola), then filtered these down to three sequences per order for the other Arthropods and a subset of sequences for the Coleoptera, to give a broad overview without having too much data. We have also checked and verified the annotations are accurate.

Next Steps
==========

Now we should have three genbank-format files. The next step is to :ref:`2. Extract Protein Coding Genes <extract_genes>`.
