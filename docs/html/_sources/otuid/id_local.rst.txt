.. _id_local:

================================
Identifying OTUs with references
================================

.. toctree::
	:hidden:
	
	mapping_reads_to_refs

Introduction
=============

Global and curated databases are very useful for assigning broad taxonomy, but don't do great identifying our OTUs to lower taxonomic levels for these sorts of samples. Depending on your study, it's often very useful to generate your own set of high-accuracy reference sequences based on a reference set of specimens. Obviously the feasibility of this depends on the richness of your study community and how cryptic your study taxon is. 

.. admonition:: Data and software
	:class: green
	
	The input data to this tutorial is a FASTA file of sequences that you want to classify, and a FASTA file of sequences corresponding to known reference specimens. If you've been following along step-by-step, you can classify the ASVs or OTUs you produced in previous sections. Alternatively, the file ``otus_greedy_0.97.fasta`` within the :ref:`sectionE archive <sectionEdata>` can be used as example data. For reference data, the files ``references_CCCPbarcodes.fasta`` and ``taxonomy_CCCPbarcodes.csv`` from the same archive can be used as example data.
	
	This tutorial uses the :ref:`BLAST <blast>` software.
	

Using BLAST
===========

We will use BLAST to search our OTUs against the FASTA of references. Run the following BLAST command, remembering to replace the ``otus.fasta`` and ``references.fasta`` with paths to the respective files, and ``output.txt`` with a sensible name.

.. parsed-literal::

	blastn -query :var:`otus.fasta` -subject :var:`references.fasta` -outfmt 6 -out :var:`output.txt` \
	-num_threads 1 -evalue 0.001 -perc_identity 97

This is similar to the command we used in the tutorial on :ref:`classification with BLAST<id_using_megan>`. However, we know that both our OTUs and our reference set are likely to all be closely related, so we're setting a strict ``-evalue`` and a threshold percentage identity so that we don’t simply get every OTU matching against every reference.

Use ``cat`` to view the output file. We're using the standard blast tabulated output (``-​ outfmt 6``); you can find out what the columns refer to `here <https://www.ncbi.nlm.nih.gov/books/NBK279684/>`_. The first refers to the query sequence, the second the subject, and the third the percent identity. You can see we’ve got some clear hits for some of our OTUs!

.. admonition:: Exercise
	
	* Do any of our OTUs hit multiple different references? Why might this be?
	* Do the OTUs matching Coleoptera references correspond to those assigned to Coleoptera using MEGAN?
	* Does this give us more information about any of our OTUs compared with the global database search?
	

Next steps
==========

If you have a comprehensive reference set of barcodes for all of the species you expect to find or are interested in finding in your metabarcoding, or at least all of the ones you're interested in, you could actually skip a considerable proportion of the metabarcoding pipeline. This is because there's no need to necessarily filter and delimit OTUs from scratch - you already have your "OTU" sequences and once you've finished processing your reads, you can simply search them against your references. You can read more about this and try it out in the extension: :ref:`mapping reads to references <map_to_ref>`.

A final method for generating taxonomic information will be covered in the next tutorial on :ref:`phylogenetic classification <phylogenetic_classification>`.
