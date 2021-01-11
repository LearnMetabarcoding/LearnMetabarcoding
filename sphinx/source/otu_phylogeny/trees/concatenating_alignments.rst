.. _concat_alignments:

.. role:: var

===========================
4. Concatenating alignments
===========================

Introduction
============

For phylogeny we need to consolidate our genetic data into one file with all of the data for each original sequence. We concatenate the 13 gene files to form a superalignment comprising all of our sequences. This is also known as a supermatrix, since every sequence is now the same length and thus each base is a cell in a very large table, where the rows are different source specimens and the columns are base positions. It is this data that phylogenetic reconstruction will work on.

.. admonition:: Software and data
	:class: green
	
	The input data for this tutorial is a directory of gene alignments in FASTA format, as produced in the :ref:`previous tutorial<aligning>`.
	
	This section uses the :ref:`catfasta2phyml.pl <catfasta2phyml>` script.

Performing concatenation
========================

We use the ``catfasta2phyml.pl`` command to concatenate the aligned files into a supermatrix. 

.. admonition:: Exercise
	
	* As always, check out the helpfile before running. We want to force concatenation of all files even when number of taxa differ, and we want to output a fasta. 
	* See if you can figure out the command, then run it.

.. admonition:: Solution
	:class: toggle
	
	``dir`` should of course be replaced with the name of the directory containing your alignments, and ``supermatrix.fasta`` with a sensible name.
	
	.. parsed-literal::
		:class: codebg
		
		catfasta2phyml.pl -c -fasta :var:`dir`/* > :var:`supermatrix.fasta`
	

The standard ``catfasta2phyml.pl`` command will print the partitions to the terminal. If we want to save them as a file, we can run the below code. 

.. admonition:: Solution
	
	Note that we print the partitions to the terminal after saving them; this is because if we have any errors, they will also be printed to the ``partitions.txt`` file so we want to check that out to ensure our command ran OK.
	
	.. parsed-literal::
		:class: codebg
		
		catfasta2phyml.pl -c -fasta :var:`dir`/* > :var:`supermatrix.fasta` 2> :var:`partitions.txt`
		cat :var:`partitions.txt`
	

Next steps
==========

Now that we have a supermatrix, we can finally move onto :ref:`5 Tree Building<tree_building>`

