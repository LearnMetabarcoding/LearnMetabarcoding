.. _otu_tree:

=================================
Making a barcode tree
=================================

Before we look at this mitogenome tree, let’s quickly build a tree for the OTUs as well, and then we can compare the two. Unlike with the references, we’re not going to align our OTUs since they’re all the same length anyway - essentially an alignment.

Take your OTUs and build a tree with them using FastTree. 

.. admonition:: Solution
	:class: toggle

	``FastTree -gtr -nt < otus_3pc.fasta > otu_tree.nwk``

A tree with anonymous “otuXXX” labels isn’t very easy to interrogate. It would be useful if we could rename the terminals with data from our classifiers to see how the classifications line up with the topology of the tree. We have prepared a custom script to do just that. Run the following command, as always replacing the parts in italics with the appropriate files.

.. code-block:: bash 

	$ rename_newick_with_classifiers.pl -tree ​tree.nwk​ -out ​out.nwk ​\ 
	> -taxa order family -stringpos 9 20 \
	> -sintax ​sintax.txt​ -rdp ​rdp.txt​ -megan ​megan.txt

If you’re interested in what these terms mean, check out the helpfile, but this another very rigid tool that we’re just using to get past some boring steps quickly.

Now we have built some trees, lets see how we :ref:`view them!<tree_viewing>`

