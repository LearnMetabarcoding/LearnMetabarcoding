.. _phylogenetic_classification:

===========================
Phylogenetic Classification
===========================

Introduction
============

As we saw in the previous section (:ref:`Building OTU Phylogeny <phylogeny>`), we can place OTUs onto phylogenetic trees constructed from reference sequences. If we then annotate the tree with the taxonomy of these reference sequences, we often observe OTUs placed within clades that correspond to a taxonomic group. Thus it follows that we should be able to use this tree to assign taxonomy to OTUs based on their placement.

The upside of using phylogeny for taxonomic classification is that the process of phylogenetic placement, if performed accurately, is much more thorough than similarity or local alignment used in the database-searching approaches. Since phylogenetic reconstruction takes account of all sequences in the dataset at the same time, the placement of an OTU in a phylogeny is much more accurate in showing the degree of relation between an OTU and references than a database search.

The downside of using phylogeny is that the size of the reference set is much more limited, by necessity of the increased computational requirements. Rather than using all possible sequences available on public databases, we are forced to select a limited taxonomic range and generally then only a subset of sequences within that range. This means that the application of phylogenetic placement to taxonomic classification is limited to a specific taxon, such as the Coleoptera, and the depth of classifications achieved is likely to be less than that of database classification. 

The optimal classification may then be best achieved through a combination of broad scale database classification on the entire OTU set, then detailed phylogenetic placement for taxa of interest. Phylogenetic placement is best applied when you want certainty about the membership (or not) of a set of OTUs within a particular taxon, and accurate group-level placement within that taxon. For example, here we will place our OTUs onto a Coleoptera tree, which will provide us with clear evidence of which OTUs are Coleoptera or not. Then we will see which families the OTUs are placed within, giving us largely-accurate family-level assignment. However, genus or species assignments largely won't be possible, as we simply don't have the depth of coverage for this.

Data and software
=================

You will need a phylogenetic tree with OTUs placed among a set of references with known taxonomy. If you have completed the :ref:`Phylogenetic Placement <phylogenetic_placement>` subsection, you will have generated this tree. You will also need a table recording taxonomy for the references.

You will also need two R scripts TODO

Approaches
==========

This task has two main steps. First we must place OTUs onto a phylogenetic tree. We cover one way of doing this in the :ref:`Phylogenetic Placement <phylogenetic_placement>` subsection. The second step involves parsing the taxonomy of the references and inferring the taxonomy of the OTUs. We do this with some custom R scripts, because we find this option is the most flexible. Here we will use these R scripts as standalone tools, but if you're familiar with R we suggest you open up the scripts and see what they're doing. The key function within these scripts is the ``nodelabel.phylo`` function from geiger `<https://www.rdocumentation.org/packages/geiger/versions/2.0.7/topics/nodelabel.phylo>`_, which does the work of assigning taxonomy to the internal nodes of the tree based on the tips.


Taxonomising the tree
=====================

First, we must assign taxonomy to the tree. We do this with the XXXX script. This script takes as input the tree and the taxonomy, and outputs a tree with taxonomic names assigned to some of the internal nodes. Assuming you have the script in your working directory, you would run it like this:

.. parsed-literal::
	
	Rscript
	

.. admonition:: Exercise
	
	Download this tree and open it in your tree viewer. Have a look at the internal nodes, looking particularly for those to which the script has assigned taxonomy.
	Do the nodes correspond with the tips?
	Are the taxonomic groups always monophyletic?
	Do most of the OTUs look like they'll have taxonomy assigned?
	
	
	Run the script again with strict on. Look at your new version of the tree. Have fewer nodes been assigned taxonomy? How will this affect the OTUs?
	

Inferring OTU classification
============================

Now that we have our taxonomised tree, we can infer the OTU classification. This is performed with another Rscript, and the logic here is very straightforward: the script looks at the parent nodes of each OTU, and assigns the OTU the taxonomy of the most recent parent node with any taxonomy.

Run the script as follows, assuming you have the script in your working directory. We suggest you use the first taxonomised tree you generated, without strict taxonomisation.

.. parsed-literal::
	
	Rscript
	

.. admonition:: Exercise
	
	Download and open the taxonomy classification table. Check a few of the OTUs against the tree. Do they fit?
	
	Have all the OTUs recieved the same depth of classification? Why might some have fewer or more taxonomic levels? 
	
	Compare the classification of some of the OTUs against the classification achieved by the database approaches. Can you see any discrepancies? Which do you think is more accurate?
	
