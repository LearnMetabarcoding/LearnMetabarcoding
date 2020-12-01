.. _extract_coding:

===================================
Extracting protein coding genes
===================================

We are going to focus solely on protein coding genes, rather than using the full mitochondrial DNA sequence of all of our records. GenBank-format files contains data that tells us the location of all of the genes present on the DNA sequence for each entry. If you’re not familiar with this concept already, see above, because otherwise what we’re doing here will not make any sense to you.

We will use a custom script to extract the 13 mitochondrial protein coding genes from our subsetted genbank file, because it’s quick and easy. You can see the help file of this script as follows:

.. code-block:: bash

	$ extract_genes.pl -h

Replace the italics parts in the following command with the appropriate file and directory names and run it. Make sure you match up the arguments with the help file and understand what you’re doing here! The *outdir* will hold a file for each gene. You don’t need to create this, the script will

..code-block:: bash

	$ extract_genes.pl -g ​novelmt.gb genbankmt.gb ​-o ​outdir/​ -minregion 10

You may get some errors about some of the GenBank genes not having enough CDS features. Don’t worry, it’s because these files for some reason don’t have proper feature tags. We can forget about these sequences - we have plenty!

Once complete, you should see thirteen files in your output folder, one for each gene. Check the number of sequences in each.

* Is it the same?

* Why might it not be the same?

I should note that this script is a very rigid solution. There is no standard format for gene names in GenBank, so our sequences use many different variants for the same gene: e.g. cox1, co1, coi, etc. The script is hardcoded to recognise as many variants as I have seen, but if you were to use this script on your own data, it might miss a gene if it had a different name. The more common approach to this task is to manually extract the sequences using a GUI tool such as Geneious, but we have not done this for several reasons:

* It’s slow and boring, we prefer automated tools

* Geneious is not free

* Manual processes frequently introduce errors into sequence naming
