.. _otu_tree:

.. role:: var

=====================
Making a Barcode Tree
=====================

.. toctree::
	:hidden:
	
	otu_trees/alignment_viewing
	otu_trees/tree_viewing
	otu_trees/reference_otu_tree
	otu_trees/tree_comparison
	

Introduction
============

Our OTUs can directly be used to make a phylogenetic tree, as they are all sequences of the same locus. This tree may not be very accurate, because there is relatively little data: for example, our example dataset only has 418 bases. On the other hand, building a phylogeny for short sequences is relatively fast for many many sequences, while building a phylogeny of much longer sequences could be much slower.

.. admonition:: Data and software
	
	The input data for this tutorial is a FASTA file comprising the sequences you want to create a phylogeny from. If you're following along step-by-step, you can use one of your OTU outputs from :ref:`the OTU delimitation tutorials<otu_delim>`, or your ASVs produced in :ref:`the filtering section<filtering>`. Alternatively, the file ``otus_greedy_0.97.fasta`` within the :ref:`sectionD archive <sectionDdata>` can be used as example data.
	
	This tutorial uses the :ref:`**MAFFT** <mafft>` and :ref:`**FastTree** <fasttree>` software. You should also have an alignment viewer, such as **Aliview**, and a tree viewer, such as **FigTree** or **Dendroscope**, installed on your personal computer.

Alignment
=========

The first stage of any tree building is to align the sequences so that homologous bases are lined up with one another. There are many alignment programs, perhaps the three most commonly used are **Clustal**, **MUSCLE** and **MAFFT**. We will use **MAFFT** because it is straightforward to use, fast, and generally very accurate. We will perform a global alignment using the accurate INS-i algorithm:

.. parsed-literal::
	
	mafft --thread 1 --globalpair -- maxiterate 1000 :var:`input.fasta` > :var:`output.fasta`
	

Where we have a coding locus with a very strict length expectation, such as in the example data where all sequences are 418bp, we can choose to skip this step, because the sequences are already in some form of alignment.

.. admonition:: Exercise
	
	* Download your input sequences and your alignment to your personal computer.
	* Open each file in the software Aliview, or your preferred alignment viewer. If you're completely new to viewing alignments, you may want to read the page on :ref:`viewing alignments <alignment_viewing>`. 
	* You should see no gaps in your input sequences, but some gaps in your aligned sequences. 
	* How accurate does the alignment appear to be - is it very gappy or only slightly. 
	* In general, are the aligned sequences consistent?

Building a tree
===============

We will build a tree of our OTUs using **FastTree**. We are using **FastTree** because it's fast, not because it's necessarily highly accurate, although it generally does pretty well. The command to use to build this tree is below. The ``-gtr`` option tells FastTree to use the GTR+CAT model, and the ``-nt`` option specifies that this is DNA data.

.. parsed-literal::
	
	FastTree -gtr -nt < :var:`input.fasta` > :var:`output.tre`
	

The algorithm generates a newick file, which is the most common format for phylogenetic trees. This is a plain text format, you can view the file using the ``head`` command. Each terminal in the tree has the ID of the sequence used to generate it.

You can download this tree to your computer and open it using a tree viewer such as **Figtree** or **Dendroscope**. If you're completely new to viewing phylogenetic trees, you may want to read the page on :ref:`viewing trees <tree_viewing>`.

It is hard to assess the accuracy of these trees with anonymous sequences, but we can get some idea by looking at the bootstrap values of the nodes. These tell us how many times this clade was recovered as a monophyletic clade in 100 random permutations of the tree building algorithm. A higher value suggests that a clade is more accurate, while a lower value suggest that a clade may have been grouped together inaccurately.

Another method to assess accuracy is to look at the distribution of branch lengths. If there are many long branches, this suggests that the phylogenetic reconstruction had a poor time trying to place the sequences at the end of these branches. 

.. admonition:: Exercise
	
	* Build a tree using both your unaligned OTU sequences and the aligned OTU sequences. Download the trees to your computer and view them. 
	* How do they compare? Select some monophyletic clades of OTUs from one tree and see if the same sets of OTUs each come out as monophyletic clades in the other tree.
	* How do the bootstrap values of the two trees compare? Overall, does either of the trees appear very accurate.

Next Steps
==========

One way to improve our ability to assess the accuracy of a tree built with anonymous sequences is to add in known sequences of the same barcode region. If you'd like to try this out, see the :ref:`Barcode tree with references <reference_otu_tree>` extension. We can also use trees to compare the OTU sequences generated by different methods. If you like to see how, see the :ref:`OTU comparison tree <otu_comparison_tree>` extension.

Alternatively, you can proceed to the next subsection, :ref:`Phylogenetic placement <phylogenetic_placement>`, where we will use reference trees rather than just reference sequences.

.. admonition:: Note
	:class: green
	
	Remember: when performing these steps on a real dataset, we would strongly advise trying some different alignment algorithms and possibly even manually correcting your alignments to get the best dataset for phylogenetics. If using the **MAFFT** command above, you should probably increase the ``--thread`` argument to better suit your data, otherwise it'll take a long time to run! We would also recommend using alternative phylogenetics software, such as **RAxML**, **IQtree** or **MrBayes** which are generally more accurate, but much slower.

