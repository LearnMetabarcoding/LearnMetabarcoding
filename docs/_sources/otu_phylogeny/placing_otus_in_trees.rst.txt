.. _phylogenetic_placement:

======================
Phylogenetic Placement
======================

Introduction
============

In the previous section we built a *de novo* phylogenetic tree from our OTU sequences, but this is a short fragment of DNA and not highly accurate. Lots of researchers put a lot of effort into building increasingly accurate phylogenies with much more comprehensive datasets. Wouldn't it be much easier if we could just use those existing phylogenies, rather than building a phylogeny from scratch, and reduce our effort down to simply figuring out where our new sequences fit into those trees? Well, we can. In this subsection, we will use a reference phylogeny of the Coleoptera, built with complete mitochondrial genomes, and place our OTUs onto this tree. The more comprehensive reference phylogeny allows us better resolution for figuring out the deep-level relationships between our OTUs than with the marker region alone. The reference phylogeny forms a 'backbone', to which we add the OTUs. The backbone tree is fixed, and new branches are added for the OTUs. This is often called a "constraint tree".

The most important point to remember here is that we must have genetic data for all of the terminals of the existing tree, and at least some of that genetic data should cover the same region of the genome as our metabarcoding marker. Ideally, all of the terminals of the existing tree would have sequence data for our metabarcoding region, but often we have incomplete datasets. This is not the end of the world: the phylogenetic algorithm is able to take account of this missing data and estimate the placement of a new sequence based on its similarity to the sequences with data, and given that incomplete sequences will correspond to other parts of other reference sequences, pairwise distances can be inferred anyway.

Getting Started
===============

To run this section with the toy dataset, you will need to copy over the reference tree and reference supermatrix FASTA to your working directory. You will also need a FASTA file of your OTU sequences. If you're doing this with your own data, you will need to have a reference tree and set of sequences for those references. If you're not sure how to get these, try this out with our toy data first, then see the :ref:`Building a Mitogenome Tree <trees>` subsection on how to go about building a reference mitogenome tree to use with your own data.

Alignment
=========

The first step is to align our OTUs to our reference mitogenome dataset. Run the following command, using your OTU FASTA and the supermatrix FASTA.

.. code-block:: bash 

	$ mafft --thread 1 --addfragments ​otus.fasta​ --6merpair ​supermatrix.fasta​ > ​out.fasta

Here we use mafft’s ​--addfragments argument, which you can read about `here <https://mafft.cbrc.jp/alignment/software/addsequences.html>`_. Again, we’re using some options which make this alignment very very fast, but the accuracy might not be great.

.. admonition:: Exercise
	
	Download this alignment and have a look at it using your alignment viewer.
	
	How well have the OTUs aligned?

Setting up the Constraint
=========================

We want to build a tree with this combined alignment, but instead of building it from scratch we want to use our reference mitogenome tree as a constraint tree.

For FastTree, we must convert our existing tree into a constraint alignment, as detailed in the `documentation <http://www.microbesonline.org/fasttree/constrained.html>`_ ​. You’ll notice that they supply a handy script for this conversion - we've already downloaded this for you, so go ahead and copy it from ``/AMM/resources/phylogenetics/TreeToConstraints.pl`` to your directory.

.. admonition:: Exercise
	
	See if you can figure out how to run this script from the documentation, then use it convert the reference tree.

.. admonition:: Solution
	:class: toggle
	
	.. code-block:: bash
		
		perl TreeToConstraints.pl < ​reference.tre ​> ​constraints.txt

Building the Tree
=================

Now we can run the new tree building to place the OTUs within the reference. We add the ``​-constraints`` option to FastTree to do this. Remember, we're running this using the combined supermatrix you just made with MAFFT.

.. code-block:: bash 

	$ FastTree -nt -gtr -constraints ​constraints.txt < ​combinedsupermatrix.fasta >​ tree.tre

.. admonition:: Exercise
	
	Download this tree to your computer and view it.
	
	Use your tree viewer's search function to highlight the OTUs. Has their topology changed compared with the OTU-only tree? Is it improved?
	
	Are OTUs distributed across taxonomic clades, or are they clustered within clades? What might be the reasons for these patterns?
	
	Have any OTUs been placed very close to any of our novel references? What might this mean?
	

Next Steps
==========

You now have a phylogeny that you can use for downstream analyses. Of course, there are a lot of sequences on this tree that aren't your OTUs, but it would be completely valid to remove the non-OTU sequences and retain only the OTU phylogeny for analysis. You could do this in R using commands from the `ape <https://cran.r-project.org/web/packages/ape/>`_ package, for example.

If you want to learn how to build a reference tree like we used here from scratch, check out the :ref:`Building a Mitogenome Tree <trees>` subsection.

If you want to learn how to identify your OTUs, you can see the :ref:`Identifying OTU Sequences <otuid>` section, where we will look at several methods for taxonomic identification and/or classification of OTUs. One of these methods draws directly from the tree you've produced here, using the taxonomy of the reference sequences in the backbone tree to infer taxonomy of the OTUs: see the :ref:`Phylogenetic Classification <phylogenetic_classification>` subsection.
