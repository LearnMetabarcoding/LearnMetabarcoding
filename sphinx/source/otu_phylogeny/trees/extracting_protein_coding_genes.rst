.. _extract_genes:

==================================
2. Extracting Protein Coding Genes
==================================

Introduction
============

We are going to focus solely on protein coding genes, rather than using the full mitochondrial DNA sequence of all of our records. GenBank-format files contains data that tells us the location of all of the genes present on the DNA sequence for each entry. If you’re not familiar with this concept already, see the page on the :ref:`genbank format <genbank>`, because otherwise what we’re doing here will not make any sense to you.

.. admonition:: Software and data
	:class: green

	This section uses a custom script.

Extracting genes
================

We will use a custom script to extract the 13 mitochondrial protein coding genes from our subsetted genbank file, because it’s quick and easy. You can see the help file of this script as follows:

.. code-block:: bash

	$ extract_genes.pl -h

Replace the placeholder names in the following command with the names of the three genbank files containing the novel references, the coleoptera from GenBank and the arthropods from GenBank. Make sure you match up the arguments with the help file and understand what you’re doing here! The ``outdir/`` will be a directory holding a file for each gene, you should of course replace this with a sensible name. You don’t need to create this, the script will.

.. code-block:: bash

	$ extract_genes.pl -g ​input1.gb input2.gb input3.gp ​-o ​outdir/​ -minregion 10

Once complete, you should see thirteen files in your output folder, one for each gene. 

.. admonition:: Exercise
	
	Check the number of sequences in each gene file.
	Is it the same? Why might it not be the same?

I should note that this script is a very rigid solution. There is no standard format for gene names in GenBank, so our sequences use many different variants for the same gene: e.g. cox1, co1, coi, etc. The script is hardcoded to recognise as many variants as I have seen, but if you were to use this script on your own data, it might miss a gene if it had a different name. The more common approach to this task is to manually extract the sequences using a GUI tool such as Geneious, but we have not done this for several reasons:

* It’s slow and boring, we prefer automated tools

* Geneious is not free

* Manual processes frequently introduce errors into sequence naming

Next Steps
==========

Now that we have our folder of genes, we will move on to :ref:`3. Aligning Protein Coding Genes<aligning>`.
