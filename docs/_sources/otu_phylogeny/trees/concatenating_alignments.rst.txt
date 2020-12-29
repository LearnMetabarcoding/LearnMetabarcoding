.. _concat_alignments:

===========================
4. Concatenating alignments
===========================

Introduction
============

For phylogeny we need to consolidate our genetic data into one file with all of the data for each original sequence. We concatenate the 13 gene files to form a superalignment comprising all of our sequences. This is also known as a supermatrix, since every sequence is now the same length and thus each base is a cell in a very large table, where the rows are different source specimens and the columns are base positions. It is this data that phylogenetic reconstruction will work on.

.. admonition:: Software and data
	:class: green

	This section uses the catfasta2phyml.pl script. Instructions on how to install this can be found :ref:`here. <catfasta2phyml>`

Performing Concatenation
========================

We use the ``catfasta2phyml.pl`` command to concatenate the aligned files into a supermatrix. 

.. admonition:: Exercise
	
	As always, check out the helpfile before running. We want to force concatenation of all files even when number of taxa differ, and we want to output a fasta. 
	
	See if you can figure out the command, then run it.

.. admonition:: Solution
	:class: toggle
	
	.. code-block:: bash
		
		$ catfasta2phyml.pl -c -fasta genes_aligned/* > supermatrix.fasta
	
	This will print the partitions to the terminal. If we want to save them as a file, we can run the below code. Note that we subsequently print them to the terminal: this is because if we have any errors, they will also be printed to the ``partitions.txt`` file so we want to check that out to ensure our command ran OK.
	
	.. code-block:: bash
		
		$ catfasta2phyml.pl -c -fasta genes_aligned/* > supermatrix.fasta 2> partitions.txt
		$ cat partitions.txt
	

Next Steps
==========

Now that we have a supermatrix, we can finally move onto :ref:`5 Tree Building<tree_building>`

