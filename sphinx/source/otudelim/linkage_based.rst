.. _linkage_delimitation:

========================
Linkage-based clustering
========================

Introduction
============

SWARM is a slightly different OTU delimitation algorithm. Rather than using a threshold that applies to all clusters like vsearch’s clustering method, it uses a local linking threshold that is based on number of differences, rather than overall dissimilarity. It assess the absolute number of differences between all pairs of ASVs, then builds a network where ASVs are nodes and the distance between nodes is the number of differences. It then interrogates this network to separate groups of ASVs with the most differences between them. One of the theoretical benefits of SWARM is that it is not affected by the abundance distribution of the input ASVs and the clusters are therefore not necessarily as uneven as in greedy clustering. The downside is that SWARM generally produces many more OTUs than greedy clustering, especially at the authors' recommended settings. Of course, this could vary considerably depending on the dataset.

Running SWARM
=============

SWARM is pretty easy to run. The main parameter is the ``-d` parameter, which specifies the number of differences to iteratively group ASVs together. This should always be an integer greater than or equal to 1. Our input contains USEARCH/VSEARCH-style ``;size=`` tags so we use the ``-z`` parameter.

Run the following command to have SWARM cluster your input ASVs.

.. code-block:: bash

	$ swarm ​-z ​in.fasta -d 1 -w ​out.fasta

.. admonition:: Exercise
	
	What happens if you run with higher ``-d`` values? Are higher values more or less strict?
	While the algorithm is quite different from greedy clustering, we can calculate the number of differences that 3% dissimilarity equates to given our amplicon is 418bp (the solution is below if you can't figure it out). Run SWARM using this value for ``-d``. How does the number of OTUs differ?

.. admonition:: Solution
	:class: toggle
	
	:math:`418 * 0.03 ≈ 13`
	.. code-block:: bash
		
		$ swarm -z in.fasta -d 13 -w out.fasta

Next Steps
==========

We've generated a set of OTUs using one method. If you haven't already, try out the other two types of OTU clustering: :ref:`Greedy Clustering <greedy_clustering>` and :ref:`Bayesian Clustering <bayesian_clustering>`.

Alternatively, if you've tried these already, select your favourite set of OTUs and proceed with them to the :ref:`Generating Data <generating_data>` section to learn about mapping your reads to your OTUs and doing taxonomic classification. Later on, we'll use these same OTUs and try to place them onto a phylogenetic tree in the :ref:`Phylogenetic Placement <phylogenetic_placement>` section.
