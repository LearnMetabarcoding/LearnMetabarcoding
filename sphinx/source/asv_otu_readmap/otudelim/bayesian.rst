.. _bayesian_clustering:

.. role:: var

=========================
Bayesian clustering
=========================

Introduction
============

The software **CROP** was originally designed for 16S and has not been updated in a while. Nonetheless, it uses an interesting algorithm based on assuming sequences are a gaussian mixture and models the process of clustering using Markov-chain Monte Carlo simulations. This approach probably bears more similarity to greedy clustering than to **swarm**, but is sufficiently different that it is interesting to compare the methods.

.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is a FASTA file comprising unique sequences (ASVs). If you're following along step-by-step, this was produced at the end of :ref:`the previous section <chimera>`. Alternatively, the file ``9_mbc_final.fasta`` within the :ref:`sectionC archive <sectionCdata>` can be used as example data.
	
	This tutorial uses the :ref:`VSEARCH <vsearch>` and :ref:`CROP <crop>` software.
	

Getting started
===============

**CROP** needs every unique read for each ASV in the input dataset, it cannot read ``;size=`` tags. We can generate this from our input ASVs quite easily though, using the ``--rereplicate`` function of **VSEARCH**.

.. parsed-literal::

	vsearch --rereplicate :var:`input.fasta` --output :var:`output.fasta`

Running CROP
============

We then use this rereplicated FASTA file in **CROP**. Note it creates several outputs using ``output`` as a name base. You should of course replace this with a sensible name.

Try running the following command:

.. parsed-literal::
	:class: background

	crop -b 40 -z 400 -s -r 0 -i :var:`input.fasta` -o :var:`output`

The options ``-b``, ``-z`` and ``-r`` are for optimising the MCMC process. You can read more about these in their `documentation <https://github.com/tingchenlab/CROP/wiki/THE-CROP-WIKI>`_. You can probably leave them alone unless you're really interested. 

Option ``​-s`` specifies that we want the equivalent of 3% dissimilarity clustering. We could change this to ``-g`` which is equivalent to 5%. You can alternatively supply values to ``-l`` and ``-u`` , for example ``​-l 1 -u 3`` , which are the lower and upper bounds of similarity levels.

**CROP** creates a bunch of files, you may want to ``​mv​`` them to their own folder. You could create a folder for each **CROP** run you do and make sure you’re in that directory when you run it. The ``output.cluster.fasta`` file contains the centroid sequences for each cluster, i.e. the representative OTU sequences.

.. admonition:: Exercise
	
	* Run **CROP** at the 5% level using the ``-g`` option in place of ``-s``. 
	* How does the number of OTUs change?
	* Run :ref:`greedy clustering<greedy_clustering>` at the 3% and 5% dissimilarity levels. How do the number of OTUs compare against **CROP**?

Tracking our ASVs
=================

The ``outname.cluster.list`` file that **CROP** produces is a text file that contains a list of the sequences included in each cluster. Run ``more`` to have a look at it. You'll note that on each line, the same ASV is repeated multiple times. This is because we rereplicated our ASVs earlier, and CROP worked on these ASV reads, each of which had the same name. We'll return to this file later when we want to map our reads.

Next steps
==========

We've generated a set of OTUs using one method. If you haven't already, try out other types of OTU clustering: :ref:`linkage delimitation <linkage_delimitation>` or :ref:`greedy clustering <greedy_clustering>`. You could optionally also look at the :ref:`extension: phylogenetic delimitation <bptp_delim>`.

.. include:: conclusion.rst

