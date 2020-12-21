.. _reference_otu_tree:

=======================================
Extension: Barcode Tree with References
=======================================

Introduction
============

Another way to assess accuracy of a tree is to add in some sequences with known taxonomy, to see if the phylogeny matches this taxonomy. If you had a reference set of barcodes for some of the species in your study, and/or you downloaded some barcodes for taxa of interest in your study, you could align these together with your OTUs and then build the tree. This would also allow you to root the tree properly.

.. admonition:: Exercise
	
	We have a set of reference barcodes with known taxonomy for the toy dataset project. Copy these over to your working directory.
	
	Concatenate the reference barcodes to your OTU sequences. 
	
	These barcodes vary in length, so we have no choice but to perform alignment. Run MAFFT on your concatenate OTUs and references.
	
	Build a tree with your alignment, then download it to your computer to view it.
	
	Does the taxonomy of the reference sequences match with the tree topology? I.e. are reference sequences from the same family grouped together?
	
	If we are able to identify some clades of the tree as containing reference sequences only from the same taxonomic group, what does that enable us to conclude about the anonymous OTU sequences in that clade?

Next Steps
==========

In the next subsection, :ref:`Phylogenetic Placement <phylogenetic_placement>`, we will similarly use a reference, but a reference *tree* rather than a set of reference sequences.

