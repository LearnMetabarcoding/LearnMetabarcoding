.. _placing_OTUs_in_ref_trees:

================================================
Placing OTUs in reference trees
================================================

The more comprehensive mitochondrial genome dataset allows us better resolution for figuring out the deep-level relationships between our species than with the OTU data. We can use this data and tree to form a ‘backbone’, to which we add the OTUs. The backbone tree is fixed, and branches are added for the OTUs. This is often called a “constraint tree”.

The first step in doing this is to align our OTUs to our mitogenome dataset. Run the following command, using the OTUs and the supermatrix of the mitochondrial genomes from the previous section.

.. code-block:: bash 

	$ mafft --thread 1 --addfragments ​otus.fasta​ --6merpair ​supermatrix.fasta​ > ​out.fasta

Here we use mafft’s ​--addfragments argument, which you can read about `here <https://mafft.cbrc.jp/alignment/software/addsequences.html>`_. Again, we’re using some options which make this alignment very very fast, but the accuracy might not be great.

Download this alignment and have a look at it using your alignment viewer.

* How well have the OTUs aligned?

We now build a tree using this new data, but with our existing mitogenome tree as a constraint tree. We will do this again in FastTree.

First, we must convert our existing tree into a constraint alignment, as detailed in the `documentation <http://www.microbesonline.org/fasttree/constrained.html>`_ ​. You’ll notice that they supply a handy script for this conversion - we’ve already downloaded this for you, so go ahead and copy it from ``/AMM/resources/phylogenetics/TreeToConstraints.pl`` to your directory.

You can now run the script as instructed in the documentation to convert the mitogenome tree from the previous section.

.. admonition:: Solution
	:class: toggle

	``$ perl TreeToConstraints.pl < ​mtgenometree.nwk ​> ​constraints.txt``

Now we can run the new tree building to place the OTUs within this tree. We add the ​-constraints option to FastTree to do this. Remember, we’re running this using the combined supermatrix you just made with mafft.

.. code-block:: bash 

	$ FastTree -nt -gtr -constraints ​constraints.txt < ​combinedsupermatrix.fasta >​ tree.nwk

Use both of the renaming scripts we’ve previously used to rename this tree with the genbank metadata and with the OTU classifier data. The order you use these scripts in doesn’t matter, but you should make sure to output to a new file each time - don’t try to overwrite any files.

Download this tree to your computer and view it.

* Use your tree viewer’s search function to highlight the OTUs. Has their topology changed compared with the OTU-only tree? Is it improved?

* Do the classification of OTUs by MEGAN/RDP/SINTAX match with the clades they have been placed in? Are there any disagreements?

* Are OTUs distributed across taxonomic clades, or are they clustered within clades? What might be the reasons for these patterns?

* Have any OTUs been placed close to any of our novel references? Do these correspond to the matches when we BLASTed our OTUs against our barcodes?

* You selected your references at random from the pool available. Compare your tree with your neighbours. Have the references used affected the conclusions you draw?
