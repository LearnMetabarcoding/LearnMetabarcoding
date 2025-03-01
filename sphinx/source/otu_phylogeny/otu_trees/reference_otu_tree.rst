.. _reference_otu_tree:

=======================================
Extension: Barcode tree with references
=======================================

Introduction
============

Another way to assess accuracy of a tree is to add in some sequences with known taxonomy, to see if the phylogeny matches this taxonomy. If you had a reference set of barcodes for some of the species in your study, and/or you downloaded some barcodes for taxa of interest in your study, you could align these together with your OTUs and then build the tree. This would also allow you to root the tree properly.

.. admonition:: Data and software
	:class: green
	
	The input data for this extension is a FASTA file of sequences, such as the OTU sequences you used for :ref:`the previous tutorial<otu_tree>`. 
	
	You will also need a set of reference barcode sequences and a taxonomy table corresponding to those reference sequences. If you're using the example dataset, the files ``references_CCCPbarcodes.fasta`` and ``taxonomy_CCCPbarcodes.csv`` within the :ref:`sectionD archive<sectionDdata>` can be used as example data. If using your own data, you would need to generate this yourself, although you might find these files useful to see what format you need.
	
	This extension uses the :ref:`MAFFT<mafft>` and :ref:`FastTree<fasttree>` software, as well as the :ref:`phylabel.R<phylostuff>` script.
	

.. admonition:: Exercise
	
	* Make sure you have the reference barcodes in your working directory. Concatenate the reference barcodes to your OTU sequences using ``cat``.
	* These barcodes vary in length, so we have no choice but to perform alignment. Run **MAFFT** on your concatenated OTUs and references, using the command in :ref:`the previous tutorial<otu_tree>`.
	* Build a tree with your alignment using FastTree, as shown in the previous tutorial
	* Use the following command to add the taxonomy from your taxonomy table onto your tree:
	
	.. parsed-literal::
		:class: codebg
		
		phylabel.R -p :var:`input.tre` -r -y :var:`taxonomy.csv` -o :var:`output.tre`
		
	
	* Download this renamed tree to your personal computer and view it. 
	* Does the taxonomy of the reference sequences match with the tree topology? I.e. are reference sequences from the same family grouped together?
	* If we are able to identify some clades of the tree as containing reference sequences only from the same taxonomic group, what does that enable us to conclude about the anonymous OTU sequences in that clade?

Next steps
==========

In the next tutorial, :ref:`Phylogenetic placement <phylogenetic_placement>`, we will similarly use a reference, but a reference *tree* rather than a set of reference sequences.

