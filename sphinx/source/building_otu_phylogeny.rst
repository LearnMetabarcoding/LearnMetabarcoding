.. _phylogeny:

=====================================
D: Building OTU phylogeny
=====================================

.. toctree::
    :hidden:

    otu_phylogeny/otu_trees
    otu_phylogeny/placing_otus_in_trees
    otu_phylogeny/trees

.. admonition:: Note
	:class: green
	
	In this section we will talk only about OTUs, but if you wanted to work at the ASV level you could simply use ASV sequences in place of OTU sequences. So whenever you see OTU in this section, you can simply replace this with ASV for equivalent results.

Introduction
============

One of the major benefits of metabarcoding over traditional methods of elucidating ecological community structure is that as part of identifying taxonomic units, we automatically acquire DNA sequences for each of our taxonomic units. This allows us to use these OTU sequences to construct phylogenetic trees for our meta-community, paving the way for analyses that go beyond just community composition into phylodiversity and phylogeography. As well as providing more detailed information about the relationships among our OTUs, phylogeny can help to better understand what our OTUs are in terms of taxonomy and evolutionary placement, potentially informing us about traits and other evolutionary properties.

.. admonition:: Data
	
	The starting point for this section is a FASTA file of sequences from which you want to build a phylogeny, i.e. ASVs or OTUs. If you worked through the previous sections, these data were produced during :ref:`filtering<filtering>` or :ref:`OTU delimitation<otu_delim>`. Alternatively, you can find some example data in the zip archive linked below.
	
	If you follow through the tutorials in this section using the example data, you will also need some reference data. You can download a zip archive of the data for all of the tutorials in this section `here <sectionDdata>`. Unzip this to a convenient location.
	

Building a phylogeny
====================

In this section, we will look at two ways to build a phylogeny with your OTUs. We would like to stress here that the focus is on exploring the possibilities and potentialities of phylogenetic metabarcoding, but a detailed exploration of phylogenetic methodologies and analysis is beyond the scope of these resources. The broad methodologies presented here cover a general outline of methods for building phylogenies, but the specific alignment and tree-building software employed has been chosen for speed and ease of use, rather than necessarily for optimal phylogenetic reconstruction. 

First, we will look at direct phylogenetic reconstruction based solely on your OTU sequences in the :ref:`Making a Barcode Tree <otu_tree>` subsection. 

Second, we will look at how you can add your OTUs to an existing phylogeny based on full mitochondrial genomes to greatly improve accuracy of your resulting tree in the :ref:`Phylogenetic Placement <phylogenetic_placement>` subsection.

The third section takes a small detour to work through a pipeline for building a mitochondrial genome tree from freely available data for cases where you don't necessarily have this data already to hand. See the :ref:`Building a Mitogenome Tree <trees>` subsection.

Next Steps
==========

We suggest you start with the :ref:`Making a Barcode Tree <otu_tree>` subsection and follow the subsections in order, although each is standalone and does not require the outputs from a previous step.

If you have your own data, we suggest nonetheless following these subsections with the available example data first, as it is small enough to rapidly produce outputs and get you familiar with the steps. Then, you may wish to build your own mitogenome tree with reference data suitable for your project (following :ref:`Building a Mitogenome Reference Tree <trees>`) then place your OTUs on this tree (following :ref:`Phylogenetic Placement <phylogenetic_placement>`)
