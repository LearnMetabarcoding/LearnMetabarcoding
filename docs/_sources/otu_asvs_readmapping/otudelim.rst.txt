.. _otu_delim:

================
OTU Delimitation
================

.. toctree:: 
	:hidden:
	
	otudelim/greedy
	otudelim/linkage_based
	otudelim/bayesian
	otudelim/comparing_otus


Introduction
============

Now that we have our filtered ASVs, ideally representing all of the true biological sequences (aka haplotypes) present in our samples, however these encompass both intra- and inter-specific variation and we want data that is comparable to species-level ecological data. Therefore, we can try to collapse the intra-specific variation while maintaining inter-specific variation. We will try several different methods for doing this, and compare them.

As well as generating approximately species-level taxonomic units, grouping ASVs into OTUs is also a method for removing errors. While we hope that our filtering has been stringent enough to remove all erroneous sequences, the chances are that it is not. However, small variations from true haplotypes will generally get grouped in with the true haplotype, thus slight errors will not be found in the OTU sequences. The downside of course is that we also remove a large proportion of the *real* variation among our ASVs, the true intra-specific variation in our dataset.

Delimitation methods
====================

Delimiting OTUs is analagous to grouping individuals or morphotypes into species, but perhaps even harder as we have to apply some sort of standard grouping protocol to all of our ASVs. As our ASVs are completely anonymous at this stage, we can't necessarily apply different protocols to different taxonomic or phylogenetic subsets of our data (while theoretically possible, there is no known implementation of this...). The only information we have is knowledge about our metabarcoding locus of choice, and the extent to which it diverges within and between species. We want to try and select a method and its parameters to consistently lump together ASVs belonging to the same species, while splitting ASVs belonging to different species. We can never be 100% confident that we have correctly grouped into species, so we don't call the resulting groups "species", instead using the term "OTU".

Due to the challenge of certainty in OTU grouping, many methods have been developed. We will look at three methods that use quite different theoretical underpinnings, and explore the key parameters and the effect of changing these parameters on the output. 


Next Steps
==========

You should have a FASTA of ASVs, as described :ref:`here <OTU_ASV_read_mapping_nextsteps>`. This is the input for each of the three different methods we will use, which you can try out in any order. By far the most common method for OTU delimitation is greedy clustering, generally at the 3% similarity level, which we will look at first in :ref:`Greedy Clustering <greedy_clustering>`. Next, we will look at a method of delimitation that builds OTUs from linkage graphs in :ref:`Linkage Delimitation <linkage_delimitation>`. Finally, we will see a bayesian similarity approach in :ref:`Bayesian Clustering <bayesian_clustering>`. For each step, we will generate OTU sequences and a record of which ASVs were grouped into which OTUs.

Once you've learned about all three different methods, you may want to read about how to :ref:`Compare OTU delimitation methods <comparing_otus>`. This is largely an exercise in exploring data, and doesn't have any specific outputs aside from helping you choose which set of OTUs to accept.

Once you have a final set of OTUs, and the associated record of ASVs within each OTU, you can move on to the :ref:`Mapping Reads <mapping_reads>` subsection.
