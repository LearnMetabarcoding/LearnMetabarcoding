.. _concat_alignments:

=======================================
4) Concatenating alignments
=======================================

For phylogeny we need to consolidate our genetic data into one file with all of the data for each original sequence. We concatenate the 13 gene files to form a superalignment comprising all of our sequences. This is also known as a supermatrix, since every sequence is now the same length and thus each base is a cell in a very large table, where the rows are different source specimens and the columns are base positions. It is this data that phylogenetic reconstruction will work on.

We use the ​catfasta2phyml.pl command to concatenate the aligned files into a supermatrix. It is available `here <https://github.com/nylander/catfasta2phyml>`_. It’s already on the server, you don’t need to download it. As always, check out the helpfile. We want to force concatenation of all files even when number of taxa differ, and we want to output a fasta. See if you can figure out the command, then run it.

.. admonition:: Solution
	:class: toggle

    ``catfasta2phyml.pl -c -fasta genes_aligned/* > supermatrix.fasta``

We can now move onto :ref:`tree building<tree_building>`

