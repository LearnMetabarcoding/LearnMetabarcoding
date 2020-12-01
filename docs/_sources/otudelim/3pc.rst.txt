=====================================
3% clustering
=====================================

The conceptually most simple method is OTU clustering, whereby clusters of similar species are designated as an OTUs, with the centroid of the cluster, i.e. the OTU sequence, being determined based on read abundance. This sort of OTU delimitation is implemented in VSEARCH

.. code-block:: bash 

	$ vsearch --cluster_size ​in.fasta​ --id 0.97 --centroids ​otus_3pc.fasta​ --sizein --relabel otu

The key parameter here is the ``--id``, which is the minimum distance (pairwise identity) between a sequence and the cluster centroid for that sequence to be part of a cluster. At ``-id 0.97``, this is called i.e. sequences in a cluster are no more than 3% different from the centroid. This is the theoretical threshold of intra-specific diversity being applied. 

* What happens if you modify this threshold? Try increasing it and decreasing it.

If you’re familiar with CD-HIT-EST, this is very similar. CD-HIT-EST uses a slightly different calculation of
dissimilarity, which can be used by including the parameter ``iddef 0`` 
