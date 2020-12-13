.. _otu_delim:

=======================================================
OTU Delimitation
=======================================================

.. toctree:: 
	:hidden:
	
	otudelim/3pc
	otudelim/linkage_based
	otudelim/bayesian


Introduction
============

Now that we have our filtered ASVs, we may choose to group these into Operational Taxonomic Units. The principle here is that the reads we have found are all the true biological sequences (aka haplotypes) present in our samples, however these encompass both intra- and inter-specific variation and we want data that is comparable to species-level ecological data. Therefore, we can try to collapse the intra-specific variation while maintaining inter-specific variation. We will try several different methods for doing this, and compare them.

As well as generating approximately species-level taxonomic units, grouping ASVs into OTUs is also a method for removing errors. While we hope that our filtering has been stringent enough to remove all erroneous sequences, the chances are that it is not. However, as you will see as we begin to understand some delimitation methods, small variations from true haplotypes will generally get grouped in with the true haplotype, thus slight errors will not be found in the OTU sequences. The downside of course is that we also remove a large proportion of the *real* variation among our ASVs, the true intra-specific variation in our dataset.

Delimitation methods
====================

We will look at three methods for OTU delimitation. By far the most common method for OTU delimitation is greedy clustering, generally at the 3% similarity level, which we will look at first in :ref:`Greedy Clustering <greedy_clustering>`. Next, we will look at a method of delimitation that builds OTUs from linkage graphs in :ref:`Linkage Delimitation <linkage_delimitation>`. Finally, we will see a bayesian similarity approach in :ref:`Bayesian Clustering <bayesian_clustering>`.

The input to all of these methods should be a FASTA file containing filtered ASVs. If you followed the core steps in the :ref:`Filtering Section <filtering>`, this would be the output from the :ref:`chimera filtering <chimera>` step.












