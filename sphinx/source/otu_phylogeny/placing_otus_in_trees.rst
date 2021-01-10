.. _phylogenetic_placement:

.. role:: var

======================
Phylogenetic placement
======================

Introduction
============

In the previous section we built a *de novo* phylogenetic tree from our OTU sequences, but this is a short fragment of DNA and not highly accurate. Lots of researchers put a lot of effort into building increasingly accurate phylogenies with much more comprehensive datasets. Wouldn't it be much easier if we could just use those existing phylogenies, rather than building a phylogeny from scratch, and reduce our effort down to simply figuring out where our new sequences fit into those trees? Well, we can. In this tutorial, we will use a reference phylogeny of the Coleoptera, built with complete mitochondrial genomes, and place our OTUs onto this tree. The more comprehensive reference phylogeny allows us better resolution for figuring out the deep-level relationships between our OTUs than with the marker region alone. The reference phylogeny forms a 'backbone', to which we add the OTUs. The backbone tree is fixed, and new branches are added for the OTUs. This is often called a "constraint tree".

The most important point to remember here is that we must have genetic data for all of the terminals of the existing tree, and at least some of that genetic data should cover the same region of the genome as our metabarcoding marker. Ideally, all of the terminals of the existing tree would have sequence data for our metabarcoding region, but often we have incomplete datasets. This is not the end of the world: the phylogenetic algorithm is able to take account of this missing data and estimate the placement of a new sequence based on its similarity to the sequences with data, and given that incomplete sequences will correspond to other parts of other reference sequences, pairwise distances can be inferred anyway.

.. admonition:: Data and software
	:class: green
	
	
	The input data for this tutorial is a FASTA file comprising the sequences you want to place on a phylogeny, and data for the phylogeny itself. The phylogeny data should comprise of 1. the final alignment/supermatrix in FASTA format, 2. the tree in newick format and 3. a table of taxonomy for the sequences on the tree.
	
	If you're following along step-by-step, for the sequences to place you can use one of your OTU outputs from :ref:`the OTU delimitation tutorials<otu_delim>`, or your ASVs produced in :ref:`the filtering section<filtering>`. Alternatively, the file ``otus_greedy_0.97.fasta`` within the :ref:`sectionD archive<sectionDdata>` can be used as example data. For the phylogeny, you should use the following files within the :ref:`sectionD archive<sectionDdata>`:
	
	1. ``supermatrix_GB_CCCP.fasta``
	2. ``phylogeny_GB_CCCP.tre``
	3. ``taxonomy_GB_CCCP.csv``
	
	If you're using your own data, you would need to acquire a published phylogeny, or build one yourself. You can review how to do the latter in the :ref:`Building a mitogenome reference tree<trees>`, although we'd suggest you try this tutorial with the example data first to understand the context.
	
	This tutorial uses the :ref:`MAFFT <mafft>` and :ref:`FastTree <fasttree>` software, as well as the :ref:`phylabel.R<phylostuff>` script. You should also have an alignment viewer, such as **Aliview**, and a tree viewer, such as **FigTree** or **Dendroscope**, installed on your personal computer.
	

Getting started
===============

Make sure you have the four files you need for this tutorial (see the Data and software box above) copied into your working directory.

Alignment
=========

The first step is to align our OTUs to our reference mitogenome dataset. Run the following command, using your OTU FASTA and the supermatrix FASTA.

.. parsed-literal::

	mafft --thread 1 --addfragments :var:`otus.fasta` --6merpair :var:`supermatrix.fasta` > :var:`output.fasta`

Here we use **MAFFT**'s ``--addfragments`` argument, which you can read about `here <https://mafft.cbrc.jp/alignment/software/addsequences.html>`_. There are several different algorithms we could use to do this, but ``--6merpair`` works well in our experience.

.. admonition:: Exercise
	
	* Download this alignment and have a look at it using your alignment viewer.
	* How well have the OTUs aligned?

Setting up the constraint
=========================

We want to build a tree with this combined alignment, but instead of building it from scratch we want to use our reference mitogenome tree as a constraint tree.

For **FastTree**, we must convert our existing tree into a constraint alignment, as detailed in the `documentation <http://www.microbesonline.org/fasttree/constrained.html>`_ ​. You'll notice that they supply a handy script for this conversion. 

.. admonition:: Exercise
	
	* Download this script to your working directory
	* See if you can figure out how to run this script from the documentation, then use it convert the reference tree.

.. admonition:: Solution
	:class: toggle
	
	.. parsed-literal::
		
		wget \http://www.microbesonline.org/fasttree/TreeToConstraints.pl
		perl TreeToConstraints.pl < :var:`reference.tre` ​> :var:`constraints.txt`

Building the tree
=================

Now we can run the new tree building to place the OTUs within the reference. We add the ``​-constraints`` option to **FastTree** to do this. Remember, we're running this using the combined supermatrix you just made with **MAFFT**.

.. parsed-literal::
	
	FastTree -nt -gtr -constraints :var:`constraints.txt` < :var:`combinedsupermatrix.fasta` > :var:`output.tre`

Finally, we just need to add the taxonomy onto the tree for our reference sequences using the **phylabel.R** script, as follows:

.. parsed-literal::
	
	phylabel.R -p :var:`input.tre` -r -y :var:`taxonomy.csv`  -o :var:`output.tre`
	

.. admonition:: Exercise
	
	* Download this tree to your computer and view it.
	* Is the tree correctly rooted? I.e. is the most basal clade (Araneae, spiders) correctly oriented? You might need to re-root the tree (see :ref:`here <tree_viewing>` if you don't know how to do this). You should make sure to reroot both the renamed and the un-renamed trees.
	* Use your tree viewer's search function to highlight the OTUs. Has their topology changed compared with the OTU-only tree? Is it improved?
	* Are OTUs distributed across taxonomic clades, or are they clustered within clades? What might be the reasons for these patterns?
	* Have any OTUs been placed very close to any of our novel references? What might this mean?
	

Next steps
==========

You now have a phylogeny that you can use for downstream analyses. Of course, there are a lot of sequences on this tree that aren't your OTUs, but it would be completely valid to remove the non-OTU sequences and retain only the OTU phylogeny for analysis. You could do this in **R** using commands from the `ape <https://cran.r-project.org/web/packages/ape/>`_ package, for example.

If you want to learn how to build a reference tree, like the one we used here, from scratch, check out the :ref:`Building a mitogenome tree <trees>` tutorials.

If you want to learn how to identify your OTUs, you can see the :ref:`Identifying OTU sequences <otuid>` section, where we will look at several methods for taxonomic identification and/or classification of OTUs. One of these methods draws directly from the tree you've produced here, using the taxonomy of the reference sequences in the backbone tree to infer taxonomy of the OTUs: see the :ref:`Phylogenetic classification <phylogenetic_classification>` tutorial.
