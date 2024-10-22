.. _id_curated:

.. role:: var

========================================
2. Classification with curated databases
========================================

Introduction
============

**BLAST** is not designed as a taxonomic assignment tool, and **MEGAN** is forced to work with **BLAST**'s alignment and matching summary outputs to assign taxonomy. There are other tools out there that are specifically designed for the assignment of taxonomy to anonymous sequences. Rather than comparing a sequence against a database one-by-one, these methods use k-mer approaches to place a sequence within the whole set of references. Then, they use an approach broadly analogous to **MEGAN**'s LCA method to probabilistically assign taxonomy, generally assigning confidence scores to different taxonomic levels. Such methods include **PROTAX**, **SINTAX**, **SPINGO** and **RDPclassifier**. It should be noted that like much of the software available for metabarcoding, these tools are often written for use on 16S. It should always be considered whether other loci may not be treated as expected by such tools.

The other downside to the prior method is that GenBank is not necessarily authoritative - it is well known that many sequences available on GenBank are misidentified, or only identified to order or family. This would not be an issue if we were working with a well-known taxon, but when our survey lineages are likely to be poorly covered in GenBank, yet we require a relatively detailed identification, searching against all of GenBank is likely to be less successful. Some researchers have taken sections of GenBank and curated the sequences, removing sequences that do not have species-level identification, are poor quality or unlikely to be correct. Remember though - just because a dataset has been curated, doesn't mean it's perfect!

.. admonition:: Data and software
	:class: green
	
	The input data to this tutorial is a FASTA file of sequences that you want to classify. If you've been following along step-by-step, you can use ASVs or OTUs you produced in previous sections. Alternatively, the file ``otus_greedy_0.97.fasta`` within the :ref:`sectionE archive <sectionEdata>` can be used as example data.
	
	The last part of this tutorial assumes you have the output from taxonomic classification using BLAST and MEGAN, as produced in :ref:`the previous tutorial<id_using_megan>`. If you have not run this tutorial, the file ``otus_greedy_0.97_MEGAN_default.csv`` within the :ref:`sectionE archive <sectionEdata>` can be used as example data.
	
	This tutorial uses the :ref:`VSEARCH<vsearch>` software.

The MIDORI database
===================

One issue with using these more advanced classification tools is that they often require quite specific reference database structures. Thankfully, many curated database authors have released their databases in these formats. For eukaryotic studies, the MIDORI database (Machida, 2017, doi: 10.1038/sdata.2017.27) has curated databases for 14 different loci, including CO1, and releases versions of their databases for 5 different taxonomic assignment tools. This is quite handy for metazoan metabarcoding. For other taxa, the fungal UNITE database is widely used, and there are many available 16S databases for microbial metabarcoding.

Classification using SINTAX
===========================

We will perform **SINTAX** classification against the MIDORI database ourselves, as this is pretty straightforward to do. The first thing to do is to download the reference dataset you want to use from the MIDORI website. Head to the `download page <http://reference-midori.info/download.php#>`_ and select the :menuselection:`Latest_GenBankRelease`, then select :menuselection:`SINTAX --> uniq`. You can download this file directly to your working directory by using the **example** command below. **Note that** the structure of the download path matches the information shown on the MIDORI page - you would obviously need to modify this to download a file for a different classifier, for a different locus, or for a newer version (240 at the time of writing, but very likely to change!). We then unzip this file and use VSEARCH to convert this to a special database format.

.. parsed-literal::
	:class: codebg
	
	wget \http://reference-midori.info/download/Latest_GenBankRelease240/SINTAX/uniq/MIDORI_UNIQ_GB240_CO1_SINTAX.fasta.zip
	unzip MIDORI_UNIQ_GB240_CO1_SINTAX.fasta.zip
	vsearch --makeudb_usearch MIDORI_UNIQ_GB240_CO1_SINTAX.fasta \\
	--output MIDORI_UNIQ_GB240_CO1_SINTAX.udb

Classifying our OTUs using this database is now very simple. We simply run SINTAX, which is also part of VSEARCH:

.. parsed-literal::
	:class: codebg
	
	vsearch -sintax :var:`input.fasta` -db MIDORI_UNIQ_GB240_CO1_SINTAX.udb \\
	-tabbedout :var:`output.tsv` -strand both -sintax_cutoff 1
	

The ``-strand`` argument controls whether sequences are compared as-is, or whether the reverse complement of the sequences is also checked; we use ``both`` just in case any database sequences are the wrong strand, although this is generally unlikely. The ``-sintax_cutoff`` argument gives the minimum bootstrap value with which to accept taxonomy, ``1`` is the strictest setting (i.e. a sequence must always be placed into this taxon for it to be accepted).

Open up the output table and have a look at it. The second column gives the full predicted taxonomy, with bootstrap support in parentheses. The third column contains the strand and the fourth column gives only the taxonomic ranks with support at or above our ``-sintax_cutoff`` threshold.

Classification using RDP or SPINGO
==================================

We won't run these tools on our own machine because they take a little bit more preliminary work to get the classifier set up. RDP, for example, requires that you train the classifier using the sequences and an associated taxonomy file - MIDORI supplies these, but the format isn't quite correct so they would require some manual fiddling. If you want to figure out how to use **RDP** for your own data with a custom database, `this page <http://john-quensen.com/tutorials/training-the-rdp-classifier/>`_ provides a good starting point, and you should also review the instructions available on the `RDP classifier github page <https://github.com/rdpstaff/classifier>`_.

Instead, we will take advantage of the server made available by the MIDORI team. You can access the server `here <http://reference-midori.info/server.php>`_. You can see that you can select a program, paste or upload your sequences, and select a database and searching parameters. We suggest uploading your OTU sequences and running RDPClassifier against the Unique CO1 database, with default parameters. We use Unique because it's a smaller database so won't take quite as long, we don't want to overload their server. You could run **SPINGO** too, but its outputs require more processing to be comparable. **RDP** outputs two files, the ``hier_outfile`` is a summary and the ``usga_classified`` is the individual OTU taxonomies, you want the latter. Upload it to your machine alongside the **MEGAN** and **SINTAX** classifications.

Comparing classifications
=========================

.. admonition:: Exercise
	
	To quickly get an idea of how many Coleoptera OTUs we have, run the following command on the **SINTAX** output file, the **RDP** classified file, and the MEGAN output you uploaded:
	
	.. parsed-literal::
		:class: codebg
	
		grep -c "Coleoptera" :var:`input`
	
	* Do the different assignment programs agree?
	
	Download these files to your computer using your FTP client and open them up in a text editor or spreadsheet software. The exact format varies, but all they output broadly similar information: the name of the OTU, some taxonomy and a confidence for each taxonomic level. They are fairly intuitive. 
	
	Compare the MEGAN, RDP and SINTAX classifications for some different OTUs.
	
	* Which programs produce identifications to the lowest taxonomic levels (i.e. towards species)?
	* Are species level identifications likely to be accurate?
	* What levels of confidence are given to the order level identifications? Might this be very conservative? Why?
	* What other taxa do we apparently have? 
	
	You will see that we have some obvious non-Coleoptera OTUs, but also some OTUs that have been assigned to other Insect orders. 
	
	* How consistent are these identifications between methods? 
	* Are we confident that these really are not Coleoptera? 
	
	Note that it’s perfectly feasible that there could have been non-Coleoptera Insect DNA in these samples.

Classification is only as good as the database and the method used. We tend to find considerable variation between different methods, and it's hard to decide which is correct. Generally, we would advise treating classifications conservatively, and if using a method that assigns confidence, only accept high confidence classifications. 

Next steps
==========

Of course, the ideal situation would be that you have a reference set of barcode sequences for all possible species in your dataset. In the :ref:`next tutorial<id_local>`, we will look at how to match your OTUs to a reference set.

An alternative approach to classification uses phylogenetics to assign taxonomy based on phylogenetic placement. We look at one method to do this in the :ref:`phylogenetic classification <phylogenetic_classification>` tutorial.
