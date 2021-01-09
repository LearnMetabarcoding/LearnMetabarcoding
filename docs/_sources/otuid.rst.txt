.. _otuid:

============================
E: Identifying OTU sequences
============================

.. toctree::
	:hidden:
	
	otuid/database
	otuid/id_local
	otuid/phylogeny_based

.. admonition:: Note
	:class: green
	
	In this section we will talk only about OTUs, but if you wanted to work at the ASV level you could simply use ASV sequences in place of OTU sequences. So whenever you see OTU in this section, you can simply replace this with ASV for equivalent results.

Introduction
============

In previous sections we found how to filter metabarcoding sequences to generate an ASV dataset, and how to group these into OTUs. To that point, the output sequences were anonymous - beyond an arbitrary name, we didn't necessarily know anything about what taxa these OTUs represent, a crucial step for using metabarcoding for biodiversity.

While we may have got some anecdotal hints from the placement of our OTUs onto phylogenetic trees, in this section we will apply standardised methodologies to taxonomically classify OTUs and hopefully match them against reference sequences to identify some OTUs to the species or morphospecies level. As well as generating taxonomic classifications for OTUs, we will also explore how we can use these taxonomic classifications to filter our set of OTU sequences.

.. admonition:: Data
	:class: green
	
	The starting point for this section is a FASTA file of sequences that you want to find out taxonomic information for, i.e. ASVs or OTUs. For some tutorials, you will also need some reference sequences. If you worked through the previous sections, the ASV or OTU data were produced during :ref:`filtering<filtering>` or :ref:`OTU delimitation<otu_delim>`. 
	
	You can download a zip archive of example data for all of the tutorials in this section :ref:`here <sectionEdata>`, including unidentified sequences and reference sequences. Unzip this to a convenient location.


Next steps
==========

We will look at three ways of classifying and identifying OTU sequences. These three parts are completely independent of one another so can be tackled in any order.

In the :ref:`Database classification <database_classification>` set of tutorials, we'll look at some methods for classifying OTU sequences against publicly available reference databases. We use these classifications to optionally filter our OTU sequences by taxonomy.

In the :ref:`Reference identification <id_local>` tutorial, we'll compare our OTU sequences against a reference set to attempt to identify some our sequences to the species or morphospecies level.

Finally, in the :ref:`Phylogenetic classification <phylogenetic_classification>` tutorial, we'll bring in the phylogenetic tree we built in the previous section to use phylogenetic placement of OTUs alongside references to assign taxonomy. Before tackling this tutorial, we suggest you find out how we built this tree in the :ref:`Building OTU phylogeny <phylogeny>` section, particularly the :ref:`Phylogenetic Placement <phylogenetic_placement>` tutorial.


