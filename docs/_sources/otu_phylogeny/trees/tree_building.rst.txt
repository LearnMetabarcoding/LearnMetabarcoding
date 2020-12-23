.. _tree_building:

================
5. Tree building
================

Introduction
============

We can now use our supermatrix to build a phylogeny. Here we will be using FastTree to quickly generate a tree, since this is (unsurprisingly) fast. This is an "approximately maximum likelihood" phylogenetic tree building method, broadly similar in method to PhyML, RAxML or IQtree.

Running FastTree
================

Use the following command, using the supermatrix output from the previous step as the input and choosing an appropriate name for your tree. The ``-gtr`` option tells FastTree to use the GTR+CAT model, and the ``-nt`` option specifies that this is DNA data.

.. code-block:: bash 

	$ FastTree -gtr -nt < ​supermatrix.fasta​ > ​tree.nwk

The algorithm generates a newick file, which is the most common format for phylogenetic trees. This is a plain text format, you can view the file using the ``head`` command. Each terminal in the tree has the ID of the sequence used to generate it. 

Adding Taxonomy
===============

The terminals of the tree are named only with the code names for their respective source sequences. We would like to add in the taxonomy so that the terminals are meaningful. There are lots of ways to do this, but our usual method is to use a custom script which takes as input the tree and a table that records the taxonomy of all of the sequences. Happily enough, we happen to have that table handy. Download this file to your working directory and run the following command:

TODO

Assessing Trees
===============

You can download the renamed tree to your computer and open it using a tree viewer such as Figtree or Dendroscope. If you're completely new to viewing phylogenetic trees, you may want to read the page on :ref:`viewing trees <tree-viewing>`.

.. admonition:: Exercise
	
	Whenever we build a phylogenetic tree, we must closely inspect it to determine how well the tree building performed. Have a look at your tree for features that aren't quite right:
	
	* Check to see whether, in general, the taxonomy of your terminals matches the clade structure of the tree
	
	* Check to see whether there are any very long branches. Why might these occur?
	

Next Steps
==========

If you've been following through these steps with your own data, we would suggest also trying out a more thorough tree building program such as RAxML, IQtree, PhyML, MrBayes or BEAST. These are much slower to run with mitogenome-scale data, but are much more accurate and appropriate for building a tree for a real analysis. Once you have your tree, you can go back to the subsection on :ref:`Phylogenetic Placement <phylogenetic_placement>` to place your OTUs within your tree.
