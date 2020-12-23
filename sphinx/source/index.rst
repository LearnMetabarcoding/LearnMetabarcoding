.. _index:
====================================================
Bioinformatic Methods for Biodiversity Metabarcoding
====================================================

Introduction
============

Welcome to the online resources for Bioinformatic Methods for Biodiversity Metabarcoding. These resources aim to introduce a beginner to the bioinformatics required for metabarcoding through a self-guided practical course, but also aim to act as a reference for those more experienced in bioinformatics or metabarcoding. To this end, these resources are structured as a set of independent tutorials. Using a set of example data, or your own dataset, you can follow along with these tutorials, step-by-step, to learn how to go from raw sequence reads to the generation of biodiversity data for use in a wide range of applications. Alternatively, you can seek out only those areas where you want to learn more, as most tutorials can stand alone, with clear guidance on what input data and software might bee needed.

Each tutorial is generally centred around a particular step in metabarcoding, introducing the important concepts of this step, a software tool to perform this step, and key parameters to consider when using this software. Some tutorials also have expansion exercises, which explore more advanced topics around a bioinformatic step for those looking for an added challenge. There is also a substantial reference section covering basic topics in bioinformatics to assist those who are just starting out.

While we have made every effort to cover a wide range of metabarcoding bioinfirmatic topics, metabarcoding is a continually evolving field and it's impossible to be comprehensive. This course explicitly focuses on metabarcoding for bulk community samples of arthropods using a protein-coding markers, as distinct from many other forms of metabarcoding such as environmental DNA sequencing, dietary-derived metabarcoding, or microbiome sequencing using ribosomal RNA markers. As such, we do not tackle some areas, such as adaptation of the bioinformatic approaches to degraded DNA, and some areas we do cover may not be relevant, such as translation-based ASV filtering. Nonetheless, the majority of the core concepts are identical across all metabarcoding so we hope this resource will be useful to any metabarcoder, no matter their background.

Resource structure
==================

These resources are structured around six main sections, accessible through the links on the left. 

We suggest you start with the :ref:`Getting started <gettingstarted>` section, which will cover the computational requirements of the course, introduce the example dataset, and outline in more detail how best to use the tutorials. This section also has a :ref:`reference section <cli_bioinformatics>` for hints and tips for those new to the Linux commandline environment.

If you want to follow through the self-guided course, you should then head to the first section, on :ref:`Read processing <read_processing>` where you will learn about the steps needed to process raw sequence reads into complete amplicon sequences. Once you've worked through the four sequential tutorials in that section, you can then move on to the :ref:`Filtering amplicon data <filtering>` section, where you will learn about sources of errors in metabarcoding datasets and how to remove them in six tutorials. Once you have error-free sequences, head to the section on :ref:`OTUs, ASVs and read mapping <otu_asv_read_mapping>` to learn how to generate biologically meaningful sequence units and community data. Then, the next section on :ref:`Building OTU phylogeny <phylogeny>` well take you through how to construct phylogenetic trees using your sequences. Finally, learn how to generate taxonomic information for your sequences in the final section on :ref:`Identifying OTU sequences <otuid>`.

If you already have some experience with metabarcoding bioinformatics and want to learn a specific topic, you can check out the complete index of the tutorials available below, or use the search bar in the top left hand corner to find the topic you're interested in. While we try to make each tutorial stand alone, to avoid unecessary redundancy some relevant information may be found in the parent page of a specific tutorial, so we recommend if you're intested in, for example, :ref:`greedy clustering <greedy_clustering>`, you make sure to read the pages on :ref:`OTUs, ASVs and read mapping <otu_asv_read_mapping>` and :ref:`OTU delimitation <otudelim>` first.

Page tree
=========

.. toctree::
	
	gettingstarted
	readprocessing
	filtering
	otu_asv_read
	building_otu_phylogeny
	otuid

