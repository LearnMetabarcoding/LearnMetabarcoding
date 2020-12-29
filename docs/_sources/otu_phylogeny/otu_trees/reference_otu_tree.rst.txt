.. _reference_otu_tree:

=======================================
Extension: Barcode Tree with References
=======================================

Introduction
============

Another way to assess accuracy of a tree is to add in some sequences with known taxonomy, to see if the phylogeny matches this taxonomy. If you had a reference set of barcodes for some of the species in your study, and/or you downloaded some barcodes for taxa of interest in your study, you could align these together with your OTUs and then build the tree. This would also allow you to root the tree properly.

.. admonition:: Data and software
	
	The input data for this extension is a FASTA file of sequences, such as the OTU sequences you used for :ref:`the previous tutorial<otu_tree>`. 
	
	You will also need a set of reference barcode sequences and a taxonomy table corresponding to those sequences. If you're using the example dataset, the files XXXXX and XXXXX within the :ref:`sectionD archive<sectionDdata>` can be used as example data. If using your own data, you would need to generate this yourself, although you might find these files useful to see what format you need.
	
	This extension uses the :ref:`**MAFFT**<mafft>` and :ref:`**FastTree**<software>`, as well as the XXXX script. TODO
	

.. admonition:: Exercise
	
	* Make sure you have the reference barcodes in your working directory. Concatenate the reference barcodes to your OTU sequences using ``cat``.
	* These barcodes vary in length, so we have no choice but to perform alignment. Run MAFFT on your concatenate OTUs and references, using the command in :ref:`the previous tutorial<otu_tree>`.
	* Build a tree with your alignment using FastTree, as shown in the previous tutorial
	* Use the following command to add the taxonomy from your taxonomy table onto your tree:
	TODO
	.. parsed-literal::
		
		Rscript
	
	* Download this taxonomised tree to your personal computer and view it. 
	* Does the taxonomy of the reference sequences match with the tree topology? I.e. are reference sequences from the same family grouped together?
	* If we are able to identify some clades of the tree as containing reference sequences only from the same taxonomic group, what does that enable us to conclude about the anonymous OTU sequences in that clade?

Next Steps
==========

In the next tutorial, :ref:`Phylogenetic Placement <phylogenetic_placement>`, we will similarly use a reference, but a reference *tree* rather than a set of reference sequences.

