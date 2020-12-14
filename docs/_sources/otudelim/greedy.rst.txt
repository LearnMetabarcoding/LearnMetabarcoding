.. _greedy_clustering:

=================
Greedy Clustering
=================

Introduction
============

Greedy clustering is the conceptually most simple method of OTU delimitation we will see. In this method, each ASV is examined one-by-one, starting from the most common ASV (based on the frequency of reads of that ASV stored in the ``;size=`` tag in the sequence headers). The first ASV always forms the centroid sequence of the first OTU; each successive ASV is compared against the current set of centroids, with the ASV joining an OTU cluster if it sufficiently similar to one of the existing centroids, or forming a new centroid if not sufficiently similar to any existing centroids. This method is called "greedy" clustering because in general it tends towards uneven clusters, with the addition of sequences to the largest cluster is preferred when there might be any ambiguity. 

The similarity threshold determines how large the clusters are and how many OTUs form. The most common similarity threshold is 97% similarity, where new ASVs join a cluster if they are no more than 3% different from the centroid. This *difference* is often known as the cluster radius, and this value is often used as much as the similarity value to specify the OTUs. Note that any two ASVs within a cluster may be as much as 6% dissimilar: the key measurement is between the *centroid* and any ASV, not among ASVs, hence the use of the term "radius".

Performing greedy clustering
============================

While the USEARCH "UPARSE" pipeline is probably the most commonly used tool for greedy clustering, we will instead once again use VSEARCH. VSEARCH both implements exactly the same clustering algorithm as USEARCH, but also allows greater flexibility in outputs and in similarity algorithms available.

The following is the basic command for 97% clustering of our ASVs, using the USEARCH algorithm:

.. code-block:: bash 

	$ vsearch --cluster_size ​in.fasta​ --id 0.97 --centroids ​otus_3pc.fasta​ --sizein --relabel otu

The ``--cluster_size`` command specifies that we want to cluster based on the ``size=`` tags in our input FASTA. The ``--centroids`` argument tells VSEARCH where to output the centroid sequences, ``--relabel``\led as ``otu001`` etc. 

.. admonition:: Exercise
	
	What happens if you modify the ``--id`` threshold value? Try increasing it and decreasing it.
	Can we know what is the most appropriate threshold, or is it somewhat arbitrary based loosely on our understanding of genetic variation in our taxon of interest and what seems to give the right values?

If you’re familiar with CD-HIT-EST, this is very similar. CD-HIT-EST uses a slightly different calculation of dissimilarity, which can be used by including the parameter ``iddef 0`` 

Tracking our ASVs
=================

One common question after performing clustering like this is to ask "which ASVs formed which OTUs?". VSEARCH allows you to find this out by outputting a table recording the matches of each ASV to each cluster.

.. admonition:: Exercise
	
	Run the above command, adding ``--uc asv_otu.uc`` to the end.
	Run ``more asv_otu.uc`` to view this table, checking the VSEARCH documentation (page 11) to see what each column means. Note that it labels the centroids (col. 2) as 0, 1, 2, etc. rather than otu1, otu2, otu3, etc.
	We can correct this a little by doing the following in bash:
	
	.. code-block:: bash
		
		$ grep -v "^C" asv_otu.uc > asv_otu_edit.uc						# Remove the cluster lines
		$ cut -f2 asv_otu_edit.uc | while read l; do echo "otu$(($l + 1))"; done > otus.temp	#convert to the correct names
		$ cut -f3-9 asv_otu_edit.uc > rest.temp							# extract the rest of the table
		$ paste otus.temp rest.temp > asv_otu_edit.uc						# join together
		$ rm *.temp										# clean up
	

Next Steps
==========

We've generated a set of OTUs using one method. If you haven't already, try out the other two types of OTU clustering: :ref:`Linkage Delimitation <linkage_delimitation>` and :ref:`Bayesian Clustering <bayesian_clustering>`.

Alternatively, if you've tried these already, select your favourite set of OTUs and proceed with them to the :ref:`Generating Data <generating_data>` section to learn about mapping your reads to your OTUs and doing taxonomic classification. Later on, we'll use these same OTUs and try to place them onto a phylogenetic tree in the :ref:`Phylogenetic Placement <phylogenetic_placement>` section.
