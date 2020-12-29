.. _greedy_clustering:

.. role:: var

=================
Greedy Clustering
=================

Introduction
============

Greedy clustering is the conceptually most simple method of OTU delimitation we will see. In this method, each ASV is examined one-by-one, starting from the most common ASV (based on the frequency of reads of that ASV stored in the ``;size=`` tag in the sequence headers). The first ASV always forms the centroid sequence of the first OTU; each successive ASV is compared against the current set of centroids, with the ASV joining an OTU cluster if it sufficiently similar to one of the existing centroids, or forming a new centroid if not sufficiently similar to any existing centroids. This method is called "greedy" clustering because in general it tends towards uneven clusters, with the addition of sequences to the largest cluster is preferred when there might be any ambiguity. 

The similarity threshold determines how large the clusters are and how many OTUs form. The most common similarity threshold is 97% similarity, where new ASVs join a cluster if they are no more than 3% different from the centroid. This *difference* is often known as the cluster radius, and this value is often used as much as the similarity value to specify the OTUs. Note that any two ASVs within a cluster may be as much as 6% dissimilar: the key measurement is between the *centroid* and any ASV, not among ASVs, hence the use of the term "radius".

.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is a FASTA file comprising unique sequences (ASVs). If you're following along step-by-step, this was produced at the end of :ref:`the previous section <chimera>`. Alternatively, the file ``9_mbc_final.fasta`` within the :ref:`sectionC archive <sectionCdata>` can be used as example data.
	
	This tutorial uses the :ref:`VSEARCH <vsearch>` software.
	

Running greedy clustering
============================

While the **USEARCH** **UPARSE** pipeline is probably the most commonly used tool for greedy clustering, we will instead once again use **VSEARCH**. **VSEARCH** implements exactly the same clustering algorithm as **USEARCH**, but also allows greater flexibility in outputs and in similarity algorithms available.

The following is the basic command for 97% clustering of our ASVs, using the **USEARCH** algorithm. :guilabel:`Run this command, using your ASVs as input and making sure to use a sensible name for the output file.` We would suggest including in your output file name the method and the threshold parameter (e.g. ``otus_greedy_0.97.fasta``)

.. parsed-literal::

	vsearch --cluster_size :var:`​input.fasta​` --id 0.97 --centroids ​:var:`output.fasta` --sizein --relabel otu

The ``--cluster_size`` function specifies that we want to cluster based on the ``size=`` tags in our input FASTA. The ``--centroids`` argument tells VSEARCH where to output the centroid sequences, ``--relabel``\led as ``otu001`` etc.

.. admonition:: Exercise
	
	* What happens if you modify the ``--id`` threshold value? Try increasing it and decreasing it, changing the name of your output file as appropriate.
	* Can we know what is the most appropriate threshold, or is it somewhat arbitrary based loosely on our understanding of genetic variation in our taxon of interest and what seems to give the right values?

If you’re familiar with `**CD-HIT-EST** <http://weizhongli-lab.org/cd-hit/>`_ , this is very similar. **CD-HIT-EST** uses a slightly different calculation of dissimilarity, which can be used by including the parameter ``--iddef 0`` 

Tracking our ASVs
=================

One common question after performing clustering like this is to ask "which ASVs formed which OTUs?". **VSEARCH** allows you to find this out by outputting a table recording the matches of each ASV to each cluster.

.. admonition:: Exercise
	
	* Rerun the above command, adding ``--uc output.uc`` to the end (we suggest changing ``output.uc`` to a sensible name that also reflects the method and threshold.
	* Run ``more`` on the ``.uc`` file to view this table, checking the `VSEARCH documentation <https://github.com/torognes/vsearch#getting-help>`_ (page 11) to see what each column means. 
	* Note that it labels the centroids (columnh 2) as 0, 1, 2, etc. rather than otu1, otu2, otu3, etc. We can correct this a little by doing the following:
	
	.. parsed-literal::
		
		# Remove the cluster lines
		grep -v "^C" :var:`input.uc` > asvgroups.temp
		
		# Convert to the correct names
		cut -f2 asvgroups.temp | while read l; do echo "otu$(($l + 1))"; done > otus.temp
		
		# Extract the rest of the table
		cut -f3-9 asvgroups.temp > rest.temp
		
		# Join the table parts together
		paste otus.temp rest.temp > :var:`output.uc`
		
		# Clean up
		rm \*.temp
		

Next Steps
==========

We've generated a set of OTUs using one method. If you haven't already, try out other types of OTU clustering: :ref:`linkage delimitation <linkage_delimitation>` or :ref:`bayesian clustering <bayesian_clustering>`. You could optionally also look at the :ref:`extension: phylogenetic delimitation <bptp_delim>`.

.. include:: conclusion.rst
