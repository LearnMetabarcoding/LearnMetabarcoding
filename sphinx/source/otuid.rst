.. _otuid:

=========================
Identifying OTU Sequences
=========================


.. toctree::
	:hidden:
	
	otuid/database
	otuid/id_local
	otuid/phylogeny_based




Introduction
============

In previous sections we found how to filter metabarcoding sequences to generate an ASV dataset, and how to group these into OTUs. To that point, the output sequences were anonymous - beyond an arbitrary name, we didn't necessarily know anything about what taxa these OTUs represent, a crucial step for using metabarcoding for ecological analysis.

While we may have got some anecdotal hints from the placement of our OTUs onto phylogenetic trees, in this section we will apply standardised methodologies to taxonomically classify OTUs and hopefully match them against reference sequences to identify some OTUs to the species or morphospecies level. As well as generating taxonomic classifications for OTUs, we will also explore how we can use these taxonomic classifications to filter our set of OTU sequences.

Getting Started
===============

This section requires that you have a FASTA file of OTUs. As in the previous section, you could substitute ASVs for OTUs throughout this section and get the equivalent ASV-level results.

Next Steps
==========

We will look at three ways of classifying and identifying OTU sequences. These three subsections are completely independent of one another so can be tackled in any order.

In the :ref:`Database Classification <database_classification>` subsection, we'll look at some methods for classifying OTU sequences against publicly available reference databases. We use these classifications to optionally filter our OTU sequences by taxonomy.

In the :ref:`Reference Identification <id_local>` subsection, we'll compare our OTU sequences against a reference set to attempt to identify some our sequences to the species or morphospecies level.

Finally, in the :ref:`Phylogenetic Classification <phylogenetic_classification>` subsection, we'll bring in the phylogenetic tree we built in the previous section to use phylogenetic placement of OTUs alongside references to assign taxonomy. We suggest you have a look the :ref:`Building OTU Phylogeny <phylogeny>` section, particularly the :ref:`Phylogenetic Placement <phylogenetic_placement>` subsection, before this section, although starting data is available if not.


