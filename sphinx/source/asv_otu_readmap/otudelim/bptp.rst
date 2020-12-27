.. _bptp_delim:

====================================
Extension: Phylogenetic delimitation
====================================

Introduction
============



.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is a FASTA file comprising unique sequences (ASVs). If you're following along step-by-step, this was produced at the end of :ref:`the previous section<chimera_filtering>`. Alternatively, the file ``9_mbc_final.fasta`` within the :ref:`sectionC archive<sectionCdata>` can be used as example data.
	
	This tutorial uses the :ref:`**FastTree**<fasttree>` and :ref:`**bPTP**<bptp>` software.

Real datasets
=============

Software for species delimitation of sequences is much more resource-intensive than the methods for OTU delimitation we've already seen. Our example dataset is small enough that we can run this on the whole dataset, but many real life datasets might be too large. The best way to utilise phylogenetic delimitation in your pipeline may be to use it as validation for choosing another OTU delimitation method and threshold. In this case, we would suggest the following process:

1. Run OTU delimitation
2. Build a phylogenetic tree of your OTUs (see :ref:`section D: OTU phylogeny<phylogeny>`)
3. Identify one or more clades on the tree with around 20-50 OTUs
4. For each clade, find the ASVs that form these OTUs.
5. For each set of ASVs, build a phylogenetic tree and run phylogenetic delimitation
6. :ref:`Compare the OTU delimitations between the methods<comparing_otus>`

Here we will just do step 5.

Building a tree
===============

The first thing to do is build a phylogenetic tree of our ASVs. We do this using the **FastTree**, using the below command. This is a quick and dirty approach, we'll revisit building OTU phylogeneny in more detail in the :ref:`Building OTU phylogeny<phylogeny>` section.

:guilabel:`Run the following command, replacing ``input.fasta`` with the name of your ASV file`.

.. parsed-literal::
	
	FastTree -gtr -nt < :var:`input.fasta` > :var:`output.tre`
	

Running bPTP
============




Tracking our ASVs
=================





Next Steps
==========

We've generated a set of OTUs using one method. If you haven't already, try out other types of OTU clustering: :ref:`greedy clustering <greedy_clustering>`, :ref:`linkage delimitation <linkage_delimitation>` or :ref:`bayesian clustering <bayesian_clustering>`.

.. include:: conclusion.rst
