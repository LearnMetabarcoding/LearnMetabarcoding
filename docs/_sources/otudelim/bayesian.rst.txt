.. _bayesian_clustering:

=========================
Bayesian clustering
=========================

Introduction
============

A final method for OTU delimitation is the software CROP, which was originally designed for 16S and has not been updated in a while. Nonetheless, it uses an interesting algorithm based on assuming sequences are a gaussian mixture and models the process of clustering using Markov-chain Monte Carlo simulations. This approach probably bears more similarity to greedy clustering than to SWARM, but is sufficiently different that it is interesting to compare the methods.

Getting Started
===============

CROP needs every unique read for each ASV in the input dataset, it cannot read ``;size=`` tags. We can generate this from our input ASVs quite easily though, using the ``--rereplicate`` function of VSEARCH.

.. code-block:: bash 

	$ vsearch --rereplicate ​in.fasta​ --relabel repl --output ​out.fasta

Running CROP
============

We then use this rereplicated FASTA file in CROP. Note it creates several outputs using ``outname`` as a name base.

Try running the following command:

.. code-block:: bash 

	$ crop -b 40 -z 400 -s -r 0 -i ​in.fasta​ -o ​outname

The options ``-b``, ``-z`` and ``-r`` are for optimising the MCMC process. You can read more about these in their `documentation <https://github.com/tingchenlab/CROP/wiki/THE-CROP-WIKI>`_. You can leave these alone. Option ``​-s`` specifies that we want the equivalent of 3% dissimilarity clustering. We could change this to ``-g`` which is equivalent to 5%. You can alternatively supply values to ``-l`` and ``-u`` , for example ``​-l 1 -u 3`` , which are the lower and upper bounds of similarity levels.

CROP creates a bunch of extra files, you may want to ​mv​ them to their own folder. You could create a folder for each CROP run you do and make sure you’re in that directory when you run it.

.. admonition:: Exercise
	
	Run CROP at the 5% level using the ``-g`` option in place of ``-s``. How does the number of OTUs change?
	Run greedy clustering at the 3% and 5% dissimilarity levels. How do the number of OTUs compare against CROP?

Next Steps
==========

We've generated a set of OTUs using one method. If you haven't already, try out the other two types of OTU clustering: :ref:`Greedy Clustering <greedy_clustering>` and :ref:`Linkage Delimitation <linkage_delimitation>`.

.. include:: conclusion.rst

