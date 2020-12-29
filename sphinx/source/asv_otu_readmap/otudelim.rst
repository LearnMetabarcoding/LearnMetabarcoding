.. _otu_delim:

.. role:: var

================
OTU Delimitation
================

.. toctree:: 
	:hidden:
	
	otudelim/greedy
	otudelim/linkage
	otudelim/bayesian
	otudelim/bptp
	otudelim/comparing_otus

Introduction
============

We have our filtered ASVs, ideally representing all of the true biological sequences (aka haplotypes) present in our samples. However, these encompass both intra- and inter-specific variation and we want data that is comparable to species-level ecological data. Therefore, we can try to collapse the intra-specific variation while maintaining inter-specific variation. We will try several different methods for doing this, and compare them.

As well as generating approximately species-level taxonomic units, grouping ASVs into OTUs is also a method for removing errors. While we hope that our filtering has been stringent enough to remove all erroneous sequences, the chances are that it is not. However, small variations from true haplotypes will generally get grouped in with the true haplotype, thus slight errors will not be found in the OTU sequences. The downside of course is that we also remove a large proportion of the *real* variation among our ASVs, the true intra-specific variation in our dataset.

.. admonition:: Data
	
	The starting point for this section is a FASTA file comprising ASVs, that is to say unique sequences with errors removed. These sequences must have ``;size=`` tags in the sequence headers to denote the abundance of each sequence in the dataset.
	
	If you worked through :ref:`the previous section <filtering>`, these data were produced by the :ref:`chimera filtering <chimera>` tutorial.
	
	If you didn't work through the previous section, you can download a zip archive of the data for all of the tutorials in this section `here <sectionCdata>`. Unzip this to a convenient location.
	


Delimitation methods
====================

Delimiting OTUs is analagous to grouping individuals or morphotypes into species, but perhaps even harder as we have to apply some sort of standard grouping protocol to all of our ASVs. As our ASVs are completely anonymous at this stage, we can't necessarily apply different protocols to different taxonomic or phylogenetic subsets of our data (while theoretically possible, there is no known implementation of this...). The only information we have is knowledge about our metabarcoding locus of choice, and the extent to which it diverges within and between species. We want to try and select a method and its parameters to consistently lump together ASVs belonging to the same species, while splitting ASVs belonging to different species. We can never be 100% confident that we have correctly grouped into species, so we don't call the resulting groups "species", instead using the term "OTU".

Due to the challenge of certainty in OTU grouping, many methods have been developed. We will look at three methods that use quite different theoretical underpinnings, and explore the key parameters and the effect of changing these parameters on the output.

OTU delimitation vs species delimitation
========================================

One thing to remember is that while OTU delimitation methods were built with the broad aim of finding species-like units, they must be suitable for handling large amplicon datasets. In barcoding, researchers often also want to group sequences into species, but usually have smaller datasets and a greater need for high fidelity. As such, analagous "species" delimitation methods have been developed that are based on our understanding of the evolutionary processes and patterns that form species. These methods are usually quite computationally intensive for the size of datasets usually encountered in metabarcoding, hence why they are rarely if ever used for metabarcoding. However, sometimes it may be useful as a sanity check to test a subset of our dataset using these methods.


Next Steps
==========

We will look at three methods of OTU delimitation commonly used in metabarcoding, and one method of species delimitation commonly used in barcoding studies as an extension. You can work through these tutorials in any order.

1. :ref:`Greedy clustering<greedy_clustering>` is by far the most common method for OTU delimitation, generally at the 3% similarity level.
2. :ref:`Linkage delimitation<linkage_delimitation>` works by building a linkage graph of ASVs and breaking this into OTUs
3. :ref:`Bayesian clustering<bayesian_clustering>` uses a bayesian similarity approach to group ASVs into OTUs
4. :ref:`Phylogenetic delimitation<bptp_delim>` borrows from species delimitation methods in barcoding and uses a phylogenetics-based approach to group ASVs.

For each step, we will generate OTU sequences and a record of which ASVs were grouped into which OTUs. Once you've learned about some different methods, you may want to read about how to :ref:`Compare OTU delimitation methods <comparing_otus>`. This is largely an exercise in exploring data, and doesn't have any specific outputs aside from helping you choose which set of OTUs to accept.

Once you have a final set of OTUs, and the associated record of ASVs within each OTU, you can move on to the :ref:`Mapping Reads <mapping_reads>` subsection.
