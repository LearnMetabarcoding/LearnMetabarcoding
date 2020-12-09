==================================
Identifying contigs 
==================================

.. toctree::
	:hidden:

	extensions/annotation_extension

You should by now have assembled some decent-length contigs - perhaps not complete, but near. However, we have no idea what morphospecies these genomes actually are!

The process of identifying these contigs is called baiting. We use short known sequences, in this case COX1 barcodes of our morphospecies, to identify the much larger complete mitogenomes. We can do this quite simply using BLAST.

The COX1 barcodes are in the /AMM/references/ directory. This is a relatively small dataset so there’s no need to bother copying it over and making an indexed BLAST database. Instead, we just BLAST against the file directly. Pick one of your assembly outputs and run BLAST:

.. code-block:: bash 

	$ blastn -query ​contigs.fa​ -subject /AMM/references/canopy_Coleop_COX1_sI.fa -outfmt 6 -perc_identity 95

You should very rapidly get a BLAST output table, which we can interrogate to see which contigs matched. We are looking for very high-identity matches here - these should be the exact same individuals. So >99%, over the entire length of the barcode.


Run the same BLAST command on all of your contigs files from the different assemblies. See if you can identify a good length contig for each of the five barcodes.

The next step would be annotating the mitochondrial genes. This is beyond the scope of this course but you can view some resources :ref:`here<annotation_resources>`.
The next practical we will be :ref:`building phylogenetic trees<trees>`