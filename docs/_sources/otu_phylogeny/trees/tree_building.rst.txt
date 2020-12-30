.. _tree_building:

================
5. Tree building
================

Introduction
============

We can now use our supermatrix to build a phylogeny. Here we will be using FastTree to quickly generate a tree, since this is (unsurprisingly) fast. This is an "approximately maximum likelihood" phylogenetic tree building method, broadly similar in method to **PhyML**, **RAxML** or **IQtree**.

.. admonition:: Data and software
	:class: green 
	
	The input data for this tutorial is a supermatrix of a set of sequences for which you want to build a phylogeny, and a table of taxonomy for those sequences. If you're following along step-by-step, the supermatrix was produced in :ref:`the previous tutorial<concat_alignments>`. The file ``taxonomy_GB_CCCP.csv`` within the :ref:`sectionD archive` is the corresponding taxonomy table.
	
	This tutorial uses the :ref:`FastTree <fasttree>` software, as well as the :ref:`phylabel.R<phylostuff>` script. You should also have a tree viewer, such as **FigTree** or **Dendroscope**, installed on your personal computer.

Running FastTree
================

Use the following command, using the supermatrix output from the previous step as the input and choosing an appropriate name for your tree. The ``-gtr`` option tells FastTree to use the GTR+CAT model, and the ``-nt`` option specifies that this is DNA data.

.. parsed-literal::

	FastTree -gtr -nt < ​:var:`input.fasta​` > :var:`​tree.nwk`

The algorithm generates a newick file, which is the most common format for phylogenetic trees. This is a plain text format, you can view the file using the ``head`` command. Each terminal in the tree has the ID of the sequence used to generate it. 

Adding Taxonomy
===============

The terminals of the tree are named only with the code names for their respective source sequences. We would like to add in the taxonomy so that the terminals are meaningful. There are lots of ways to do this, but our usual method is to use a custom script which takes as input the tree and a table that records the taxonomy of all of the sequences. Happily enough, we happen to have that table handy. :guilabel:`Run the following command to rename the tree tips with taxonomy:`

.. parsed-literal::
	
	phylabel.R -p :var:`input.tre` -r -t :var:`taxonomy.csv`  -o :var:`output.tre`
	

Assessing Trees
===============

You can download the renamed tree to your computer and open it using a tree viewer such as **Figtree** or **Dendroscope**. If you're completely new to viewing phylogenetic trees, you may want to read the page on :ref:`viewing trees <tree_viewing>`.

.. admonition:: Exercise
	
	Whenever we build a phylogenetic tree, we must closely inspect it to determine how well the tree building performed. Have a look at your tree for features that aren't quite right:
	
	* Check to see whether, in general, the taxonomy of your terminals matches the clade structure of the tree
	* Check to see whether there are any very long branches. Why might these occur?
	

Next Steps
==========

If you've been following through these steps with your own data, we would suggest also trying out a more thorough tree building program such as **RAxML**, **IQtree**, **PhyML**, **MrBayes** or **BEAST**. These are much slower to run with mitogenome-scale data, but are much more accurate and appropriate for building a tree for a real analysis. Once you have your tree, you can go back to the tutorial on :ref:`phylogenetic placement <phylogenetic_placement>` to place your OTUs within your tree.
