.. _trees:

=============================================
Building Phylogenetic Trees for Metagenetics
=============================================

------------------------------------------
Introduction
------------------------------------------

Mitochondrial genomes allow us to build accurate phylogenetic trees of our references. These trees can be a powerful supplement to metagenomics in many ways:

* Inclusion of phylogenetic relationships for analysing ecological patterns in an evolutionary context

* More detailed identification of anonymous OTUs through placement within an established phylogenetic tree

Phylogenetic trees are more powerful when built with comprehensive data. Here we introduce a rapid and efficient pipeline for building a tree with our data. We supplement our mitogenomes with data from GenBank, then extract genes, align them, concatenate to a supermatrix and perform some fast tree building. This is not going to produce the best phylogeny! This is a general overview of the pipeline we use, the aim is to:

* For those without phylogenetics experience, present an introduction to outline and demystify the process of tree building

* For those with phylogenetics experience, hopefully introduce some novel techniques

.. toctree::
	trees/preparing_mitogenome_data
	trees/extracting_protein_coding_genes
	trees/aligning_protein_coding_genes
	trees/concatenating_alignments
	trees/tree_building
	trees/otu_trees
	trees/tree_viewing