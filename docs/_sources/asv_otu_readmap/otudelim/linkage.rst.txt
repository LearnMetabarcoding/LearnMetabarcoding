.. _linkage_delimitation:

.. role:: var

==========================
Linkage-based delimitation
==========================

Introduction
============

The program **swarm** is a slightly different OTU delimitation algorithm. Rather than using a threshold that applies to all clusters like **VSEARCH**'s clustering method, it uses a local linking threshold that is based on number of differences, rather than overall dissimilarity. It assess the absolute number of differences between all pairs of ASVs, then builds a network where ASVs are nodes and the distance between nodes is the number of differences. It then interrogates this network to separate groups of ASVs with the most differences between them. One of the theoretical benefits of **swarm** is that it is not affected by the abundance distribution of the input ASVs and the clusters are therefore not necessarily as uneven as in greedy clustering. The downside is that **swarm** generally produces many more OTUs than greedy clustering, especially at the authors' recommended settings. Of course, this could vary considerably depending on the dataset.

.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is a FASTA file comprising unique sequences (ASVs). If you're following along step-by-step, this was produced at the end of :ref:`the previous section <chimera>`. Alternatively, the file ``9_mbc_final.fasta`` within the :ref:`sectionC archive <sectionCdata>` can be used as example data.
	
	This tutorial uses the :ref:`swarm <swarm>` software.

Running swarm
=============

**Swarm** is pretty easy to run. The main parameter is ``-d``, which specifies the number of differences to iteratively group ASVs together. This should always be an integer greater than or equal to 1. Our input contains ``;size=`` tags so we use the ``-z`` parameter.

Run the following command to have **swarm** cluster your input ASVs.

.. parsed-literal::

	swarm ​-z :var:`input.fasta` -d 1 -w :var:`output.fasta`

.. admonition:: Exercise
	
	* What happens if you run with higher ``-d`` values?
	* Are higher values more or less strict?
	* While the algorithm is quite different from greedy clustering, given our amplicon is 418bp we can calculate the number of differences that is equivalent to 3% dissimilarity. Try to do this, then check the solution below.
	* Run swarm using this value for ``-d``. How does the number of OTUs differ?

.. admonition:: Solution
	:class: toggle
	
	418 * 0.03 ≈ 13
	
	.. parsed-literal::
		
		swarm -z :var:`input.fasta` -d 13 -w :var:`output.fasta`
	

Tracking our ASVs
=================

We can get **swarm** to output a list of ASVs that were grouped to form each OTU. You can generate this list by adding the ``-o`` option

.. admonition:: Exercise
	
	* Rerun **swarm** with your favourite ``-d`` value and ``-o output.txt`` (replacing ``output.txt`` with an appropriate name, of course)
	* Review this file with ``more``
	* Can you figure out a way to count the number of ASVs per OTU?
	* Is it even?

.. admonition:: Solution
	:class: toggle
	
	.. parsed-literal::
		
		swarm -z :var:`input.fasta` -d 1 -w :var:`output.fasta` -o :var:`output.txt`
		
		grep -n -o "uniq" :var:`input.txt` | cut -d: -f1 | sort | uniq -c
	
	Check out the page on :ref:`grep <grep>` for more help figuring out what this command is doing

Next steps
==========
We've generated a set of OTUs using one method. If you haven't already, try out other types of OTU clustering: :ref:`greedy clustering <greedy_clustering>` or :ref:`bayesian clustering <bayesian_clustering>`. You could optionally also look at the :ref:`extension: phylogenetic delimitation<bptp_delim>`.

.. include:: conclusion.rst
