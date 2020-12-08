.. _otu_delim:

=======================================================
OTU Delimitation
=======================================================

------------------------------------------
Introduction
------------------------------------------

Now that we have our filtered reads, the next step is to find the Operational Taxonomic Units. The principle here is that the reads we have found are all the true biological sequences (aka haplotypes) present in our samples, however these encompass both intra- and inter-specific variation and we want data that is comparable to species-level ecological data. Therefore, we must try to collapse the intra-specific variation while maintaining inter-specific variation. We will try several different methods for doing this, and compare them.

.. toctree:: 
	otudelim/3pc
	otudelim/linkage_based
	otudelim/bayesian










