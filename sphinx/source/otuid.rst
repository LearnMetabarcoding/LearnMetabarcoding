.. _generating_data:

==========================
Identifying OTU Sequences
==========================

Introduction
============

In this section, we finally bring everything together to generate the main output data from metabarcoding bioinformatics that can be analysed to answer your research questions. Now that we have a set of sequences that represent our biological units, namely OTUs, we need to answer two crucial questions:

1. Which samples contain which OTUs?
2. What are the OTUs?

This section requires data from previous sections: a unique set of OTU sequences (or ASV sequences), and a set of reads that contain information about the sample from which each read was drawn.



Now we have some OTUs in hand, we have two final tasks. We need to get some idea of what OTUs are present in which sample, and we want to try and identify our OTUs to some degree. Firstly, we’ll map our individual reads against the OTUs. Secondly, we’ll try and identify them against a global database using a very broad approach, then against a local database.




.. toctree::
	:hidden:
	
	otuid/database
	otuid/id_local
	otuid/phylogeny_based


