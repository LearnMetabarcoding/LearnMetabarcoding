.. _phylogenetic_classification:

===========================
Phylogenetic Classification
===========================

Introduction
============

As we saw in the previous section (:ref:`Building OTU Phylogeny<phylogeny>`), we can place OTUs onto phylogenetic trees constructed from reference sequences. If we then annotate the tree with the taxonomy of these reference sequences, we often observe OTUs placed within clades that correspond to a taxonomic group. Thus it follows that we should be able to use this tree to assign taxonomy to OTUs based on their placement.

The upside of using phylogeny for taxonomic classification is that the process of phylogenetic placement, if performed accurately, is much more thorough than similarity or local alignment used in the database-searching approaches. Since phylogenetic reconstruction takes account of all sequences in the dataset at the same time, the placement of an OTU in a phylogeny is much more accurate in showing the degree of relation between an OTU and references than a database search.

The downside of using phylogeny is that the size of the reference set is much more limited, by necessity of the increased computational requirements. Rather than using all possible sequences available on public databases, we are forced to select a limited taxonomic range and generally then only a subset of sequences within that range. This means that the application of phylogenetic placement to taxonomic classification is limited to a specific taxon, such as the Coleoptera, and the depth of classifications achieved is likely to be less than that of database classification. 

The optimal classification may then be best achieved through a combination of broad scale database classification on the entire OTU set, then detailed phylogenetic placement for taxa of interest. Phylogenetic placement is best applied when you want certainty about the membership (or not) of a set of OTUs within a particular taxon, and accurate group-level placement within that taxon. For example, here we will place our OTUs onto a Coleoptera tree, which will provide us with clear evidence of which OTUs are Coleoptera or not. Then we will see which families the OTUs are placed within, giving us largely-accurate family-level assignment. However, genus or species assignments largely won't be possible, as we simply don't have the depth of coverage for this.

.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is a phylogenetic tree with query sequences (i.e. OTUs) placed among a set of references with known taxonomy. You will also need a table recording taxonomy for these references. If you have been following along step-by-step, you can use the phylogenetic tree you produced in the `placing OTUs in trees<phylogenetic_placement>` tutorial, and the corresponding taxonomy table. Alternatively, the files ``phylogeny_GB_CCCP_otus_greedy_0.97.tre`` and ``taxonomy_GB_CCCP.csv`` within the :ref:`sectionE archive <sectionEdata>` can be used as example data.
	
	This tutorial uses the :ref:`phylabel.R<phylostuff>` and :ref:`treedentify.R<phylostuff>` scripts.

Approaches
==========

This task has two main steps. First we must place OTUs onto a phylogenetic tree. We cover one way of doing this in the :ref:`phylogenetic placement <phylogenetic_placement>` tutorial, we strongly suggest you head over and do that tutorial before this one. 

The second step involves parsing the taxonomy of the references and inferring the taxonomy of the OTUs. We do this with some custom R scripts, because we find this option is the most flexible. Here we will use these R scripts as standalone tools, but if you're familiar with R we suggest you open up the scripts and see what they're doing. The key function within these scripts is the ``nodelabel.phylo`` function from geiger `<https://www.rdocumentation.org/packages/geiger/versions/2.0.7/topics/nodelabel.phylo>`_, which does the work of assigning taxonomy to the internal nodes of the tree based on the tips.

Taxonomising the tree
=====================

First, we must assign taxonomy to the tree. We do this with the ``phylabel.R`` script. This script takes as input the tree and the taxonomy, and outputs a tree with taxonomic names assigned to some of the internal nodes. We've seen this script before for relabelling terminals, but it also works on nodes.

.. parsed-literal::
	
	phylabel.R -p :var:`input.tre` -x -t :var:`taxonomy.csv` -o :var:`output.tre`
	

.. admonition:: Exercise
	
	* Download this tree and open it in your tree viewer. Have a look at the internal nodes, looking particularly for those to which the script has assigned taxonomy.
	* Do the nodes correspond with the tips?
	* Are the taxonomic groups always monophyletic?
	* Do most of the OTUs look like they'll have taxonomy assigned?
	

You'll see that a lot of the node names have quotation marks (``"``). This is added when most, but not all, of the descendents of a node match this taxon. We can be more strict by adding the strict ``-s`` option to the ``phylabel.R`` command.

.. admonition:: Exercise
	
	* Run the script again with strict on. 
	* Look at your new version of the tree. Have fewer nodes been assigned taxonomy? How will this affect the OTUs?
	* Which is more appropriate?

Inferring OTU classification
============================

Now that we have our taxonomised tree, we can infer the OTU classification. This is performed with another R script, **treedentify**, and the logic here is very straightforward: the script looks at the parent nodes of each OTU, and assigns the OTU the taxonomy of the most recent parent node with any taxonomy.

.. note:: A slight complexity here: these tools only know what we tell them. If you took a random tip in the taxonomised tree and looked at all of its parent nodes, you'll see that only some of the taxonomy is present. We might be missing order-level or even family-level taxonomy if our phylogeny doesn't closely match the taxonomy, even if we have an ancestral node with a genus-level identification. However, if we can infer that an OTU belongs to a genus, it of course also belongs to the corresponding family, order, etc, and we want that information! 

Run this as follows. We suggest you use as ``input.tre`` the first taxonomised tree you generated, without strict taxonomisation.

.. parsed-literal::
	
	treedentify.R -p :var:`input.tre` -e ^otu -u -o :var:`output.csv`
	

The ``-e`` argument tells **treedentify** that we want to classify any tips beginning with ``otu``. You might want to swap this for ``uniq`` or something else if your OTU or ASV sequences have different names. The ``-u`` argument tells **treedentify** to check NCBI to get the complete taxonomy of any matches. 

.. admonition:: Exercise
	
	* Download and open the taxonomy classification table. Check a few of the OTUs against the tree. Do they fit?
	* Have all the OTUs recieved the same depth of classification? Why might some have fewer or more taxonomic levels? 
	* Compare the classification of some of the OTUs against the classification achieved by the database approaches. Can you see any discrepancies? Which do you think is more accurate?

