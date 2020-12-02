.. _prep_mitogenome_data:

=================================
Preparing mitogenome data 
=================================

.. toctree::
	:hidden:

	fundamentals/genbank

First, copy the set of novel Coleoptera mitogenomes from the canopy project to your directory (``/AMM/references/canopy_ColeopMT.gb``). This is the complete version of what you assembled in the last section.

We want to supplement these mitogenomes with some good data from GenBank in order to generate a more comprehensive tree. We will use mitogenome data from the NCBI RefSeq database. This database holds the set of best-curated sequences on GenBank.

While we will obviously want to acquire some Coleoptera data, we should also include representatives from other taxa. Most importantly, we want to be able to validate the assignment of OTUs to other Insect orders that we observed using our taxonomic assignment methods. Given that CO1 is a fast-evolving gene, and we are just using a short, highly variable region, we should not expect that deep-level (i.e. order-level) relationships will be properly resolved on a tree based solely on this data. In other words, we shouldn’t necessarily assume that the beetles and non-beetles will form separate monophyletic clades on a tree if only the metabarcode region is used to separate them. So, we will also use data for a set of other Arthropod orders. ​This data is all already downloaded to the server.

If you’ve not previously acquired data from GenBank, or aren’t familiar with the GenBank file format, look at this page go over :ref:`how we retrieved the Coleoptera data<genbank>`. 

Copy to your directory the two files for the Coleoptera and selected other Arthropods (Blattodea, Hemiptera, Lepidoptera, Diptera, Araneae, and Collembola):

.. code-block:: bash 

	$ cp /AMM/references/GBdl_RefSeq_ColeopMT_2019-09-20.gb ./
	$ cp /AMM/references/GBdl_RefSeq_OtherArthMT_2019-09-20.gb ./

For speed, we’re just assuming this data is perfect and completely suitable for our purposes. If approaching this comprehensively, we would check through the sequences to ensure that:

* All of the sequences come from species within the group we’re interested in

* All of the annotations are accurate


We are going to remove some redundancy in these datasets, since in total we now have over 1,400 references. Not only will building trees with this many sequences be very time-consuming, but it’ll make our trees very complicated to view and understand. We are going to reduce our dataset by taking representatives from each family in our references - three per family for the Coleoptera, one per family for everything else.

We’ll run a custom script that loads the entries, sorts them by a specified taxonomic level, and outputs a specified number of entries from each group. It is imaginatively named “subset_gb_by_taxonomy.pl”. Check out the helpfile if you wish, the commands we need are:

.. code-block:: bash 

	$ subset_gb_by_taxonomy.pl -g GBdl_RefSeq_OtherArthMT_2019-09-20.gb -t family -n 1 -random -o GBdl_RefSeq_OtherArthMT_1pfamily
	$ subset_gb_by_taxonomy.pl -g GBdl_RefSeq_ColeopMT_2019-09-20.gb -t family -i -n 3 -random -o GBdl_RefSeq_ColeopMT_3pfamily

Note the ``-i`` in the second command - this ensures we include families that have fewer than three representatives. You may get some messages about “trouble dissecting...” - you can ignore these. For each command you should get 2-4 files - the one we want is the one with _subset in the name. Concatenate the two _subset files into a single file.

The next step is to :ref:`extract protein coding genes<extract_coding>`.