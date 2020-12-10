.. _tree_building:

================================
5) Tree building
================================

We can now use our supermatrix to build a phylogeny. Here we will be using FastTree to quickly generate a tree, since this is (unsurprisingly) fast. This is an “approximately maximum likelihood” phylogenetic tree building method, broadly similar in method to PhyML or RAxML.

Use the following command, using the output from the previous step as the input and choosing an appropriate name for your tree. The ``-gtr`` option tells FastTree to use the GTR+CAT model, and the ``-nt`` option specifies that this is DNA data.

.. code-block:: bash 

	$ FastTree -gtr -nt < ​supermatrix.fasta​ > ​tree.nwk

The algorithm generates a newick file, which is the most common format for phylogenetic trees. This is a plain text format, you can view the file using the ``head`` command. Each terminal in the tree has the ID of the sequence used to generate it. These code names are very useful for linking to data about our sequences, but aren’t helpful for examining the tree and interrogating its success.

In this case, we’ll use a script to pull metadata from the GenBank files to do the renaming. Again, this is a custom script used to skip over tedious bits of this pipeline, it’s definitely not a required step.

The script is ``rename_newick_with_gb.pl``, check out the helpfile using ``-h`` and rename the tree with the fields you think would be useful. My suggestion is below.

.. admonition:: Suggestion
	:class: toggle

	``rename_newick_with_gb.pl -g ​novelmt.gb genbankmt.gb​ -t ​tree.nwk​ -o ​tree_RN.nwk​``
	``-fields LOCUS TAXONOMY -ntax 6``
	

The next stage is to :ref:`build a tree for our OTUs<otu_tree>`
