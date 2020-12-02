=====================================
Identification using local database 
=====================================

It’s clear that global and curated databases are very useful for assigning broad taxonomy, but don’t do great identifying our OTUs to lower taxonomic levels for these sorts of samples. Usefully, we picked out some morphospecies and sequenced them separately using Sanger sequencing.

These sequences are in ``/AMM/references/canopy_Coleop_COX1_sI.fa``.

Let’s use BLAST to search our OTUs against this fasta of references. There’s no need to copy it to our directory. Run the following BLAST command:

.. code-block:: bash 

	$blastn-query​otus.fasta-​subject/AMM/references/canopy_Coleop_COX1_sI.fa-outfmt 6 -out ​out.txt -​ num_threads 1 -evalue 0.001 -perc_identity 97

Because we know that both our OTUs and our reference set are likely to all be closely related, we’re setting a strict ``-evalue`` and a threshold percentage identity so that we don’t simply get every OTU matching against every reference.

Use ``cat`` to view the output file. We’re using the standard blast tabulated output (``-​ outfmt 6``); you can find out what the columns refer to `here <https://www.ncbi.nlm.nih.gov/books/NBK279684/>`_. Rather obviously, the first refers to the query sequence, the second the subject, and the third the percent identity. You can see we’ve got some clear hits for some of our OTUs!

* Do any of our OTUs hit multiple different references? Why might this be?

* Do the OTUs matching Coleoptera references correspond to those assigned to Coleoptera using MEGAN?

* Does this give us more information about any of our OTUs compared with the global database search?
