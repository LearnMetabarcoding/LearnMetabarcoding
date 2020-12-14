.. _linkage_delimitation:

========================
Linkage-based clustering
========================

Introduction
============

SWARM is a slightly different clustering algorithm. Rather than using a threshold that applies to all clusters like vsearch’s clustering method, it uses a local linking threshold that is based on number of differences, rather than overall dissimilarity. Run swarm as follows:

.. code-block:: bash

	$ swarm -w ​out.fasta​ -d 1 -z ​in.fasta

* What happens if you run with higher ``-d`` values (they must be integers).

Next Steps
==========

We've generated a set of OTUs using one method. If you haven't already, try out the other two types of OTU clustering: :ref:`Greedy Clustering <greedy_clustering>` and :ref:`Bayesian Clustering <bayesian_clustering>`.

Alternatively, if you've tried these already, select your favourite set of OTUs and proceed with them to the :ref:`Generating Data <generating_data>` section to learn about mapping your reads to your OTUs and doing taxonomic classification. Later on, we'll use these same OTUs and try to place them onto a phylogenetic tree in the :ref:`Phylogenetic Placement <phylogenetic_placement>` section.
