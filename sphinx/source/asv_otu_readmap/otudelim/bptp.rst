.. _bptp_delim:

====================================
Extension: Phylogenetic delimitation
====================================

Introduction
============



.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is a FASTA file comprising unique sequences (ASVs). If you're following along step-by-step, this was produced at the end of :ref:`the previous section<chimera_filtering>`. Alternatively, the file ``9_mbc_final.fasta`` within the :ref:`sectionC archive<sectionCdata>` can be used as example data.
	
	This tutorial uses the :ref:`**FastTree**<fasttree>` and :ref:`**bPTP**<bptp>` software.

Real datasets
=============

Software for species delimitation of sequences is much more resource-intensive than the methods for OTU delimitation we've already seen. Our example dataset is small enough that we can run this on the whole dataset, but many real life datasets might be too large. The best way to utilise phylogenetic delimitation in your pipeline may be to use it as validation for choosing another OTU delimitation method and threshold. In this case, we would suggest the following process:

1. Run OTU delimitation
2. Build a phylogenetic tree of your OTUs (see :ref:`section D: OTU phylogeny<phylogeny>`)
3. Identify one or more clades on the tree with around 20-50 OTUs
4. For each clade, find the ASVs that form these OTUs.
5. For each set of ASVs, build a phylogenetic tree and run phylogenetic delimitation
6. :ref:`Compare the OTU delimitations between the methods<comparing_otus>`

Here we will just do step 5.

Building a tree
===============

The first thing to do is build a phylogenetic tree of our ASVs. We do this using the **FastTree**. This is a quick and dirty approach, we'll revisit building OTU phylogeneny in more detail in the :ref:`Building OTU phylogeny<phylogeny>` section.

First we must strip out our ``;size=`` annotations, as these often cause issues in newick-format trees. :guilabel:`Run the following command, replacing ``input.fasta`` with the name of your ASV file`.

.. parsed-literal::
	
	sed -e "s/;size=.*$//" :var:`input.fasta` > :var:`output.fasta`

:guilabel:`Now run FastTree; your input file should be the output from the ``sed`` command`.

.. parsed-literal::
	
	FastTree -gtr -nt < :var:`input.fasta` > :var:`output.tre`
	

Running bPTP
============

**bPTP** creates a lot of output files so it's useful to make a directory for the outputs to keep things tidy. 

The ``-s`` argument sets a seed (a starting number for random number generation in the software). Setting a seed means that performing the same command twice will have the same outcome.

.. parsed-literal::
	
	mkdir bPTP_outputs
	bPTP -t :var:`input.tre` -r -s 1234 -o bPTP_outputs/:var:`output`
	

bPTP outputs
============

There are a lot of outputs, if you want to know about all of them have a look at the `bPTP documentation <https://github.com/zhangjiajie/PTP/blob/master/README.md>`_. We'll look at two. 

Download the file ending "PTPhSupportPartition.txt.png" to your personal computer and open it. You'll see a phylogenetic tree of your ASVs, with some branches in red. ASVs linked by red branches have been grouped together into OTUs. Any ASVs with blue branches have formed OTUs by themselves. 

Use ``more`` to look at the file ending ``PTPhSupportPartition.txt``. This lists the asvs forming each "Species", with a support value of each Species group. These values are probabilities, so values closer to 1 are high probabilities.

.. admonition:: Exercise
	
	* How well supported are the OTU clusters? Does it vary?


Picking OTUs
============

Like other methods, bPTP has grouped together ASV sequences into groups we can call OTUs. However, unlike other methods it hasn't automatically selected a representative sequence for each OTU. Depending on your application, this might not matter. However, many downstream applications such as taxonomic classification require OTU sequences, so we need to select representative sequences after the fact. We will do this based on abundance - for each OTU group we will use the most common ASV as the representative sequence.

First let's reformat the ``PTPhSupportPartition.txt`` file a little bit. We want to just extract out the lists of ASVs, dropping all other lines. We then change the lists to space-delimited to make it easier to handle. :guilabel:`Run the following command:`

.. parsed-literal::
	
	# find only lines starting with space, the lists
	grep "^ " :var:`input.txt` | 
	
	# remove the spaces and then replace commas with spaces
	sed -e "s/ //g" -e "s/,/ /g" > :var:`output.txt`
	

Then, for each line we're going to find the ASV with the largest size. This is a little bit of effort. First we must sort our ASVs into size order. The input to this command must not be the file you stripped ``;size=`` tags from earlier!

.. parsed-literal::
	
	vsearch --sortbysize :var:`input.fasta` --output :var:`output.fasta`
	

The following command loops through the lines of the reformatted partition summary text file that we just created. For each line, it converts the space-separated list of ASVs into a multi-line string, then searches for those ASVs in the sorted ASVs FASTA we just created. Because this is sorted by size, the most frequent ASV will be the first hit, so we take the first line, remove the ``>`` at the beginning of the line and output this to a file. :guilabel:`Run this command`.

.. parsed-literal::
	
	while read l;
	do
		grep -Ff <(echo -e "${l// /;\\n}") :var:`sortedASVs.fasta` |
		head -1 | sed -e "s/>//" ;
	done < :var:`reformattedpartitionsummary.txt` > :var:`output.txt`


.. admonition:: Exercise
	
	* Check the contents of the output file with ``head``.
	* Use ``wc -l`` to make sure the number of lines matches that of the partition summary

:guilabel:`Paste this output together with the reformatted partition table to get our final list of ASVs and OTUs`

.. parsed-literal::
	
	paste -d$' ':var:`representativeASVs.txt` :var:`reformattedpartitionsummary.txt` > :var:`output.txt`
	

This output file is the record of ASVs grouped into each OTU, just like we generated in the OTU delimitation methods.

Finally, let's filter our ASVs to get only the OTU representative sequences. See the bash command :ref:`cheatsheet<cheatsheet>` for how this command works. Run this command, making sure to use the version of the ASVs *with* ``;size=`` tags.

.. parsed-literal::
	
	perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' :var:`asvs.fasta` |
	grep --no-group-separator -A1 -Ff :var:`representativeASVs.txt` <() > :var:`output.fasta`

The output file here is analogous to the OTU files generated in the other OTU delimitation methods

.. admonition:: Exercise
	
	* How does the number of OTUs generated compare with the other methods?
	* What might improve the accuracy of this phylogenetic method?

.. admonition:: Solution
	
	We have performed a species delimitation method on what may only be a subsample of the true variation within the real species of our dataset. Thus there may not be enough data of both within-species and between-species variation for the **bPTP** algorithm to efficiently distinguish species groups. One way we could improve on this is to add more sequences in that we have *a priori* knowledge about. We could go to GenBank, search for some well-studied species that are closely related to our metabarcoded community and that have many haplotypes available, download them and add them to our ASVs.


Next Steps
==========

We've generated a set of OTUs using one method. If you haven't already, try out other types of OTU clustering: :ref:`greedy clustering <greedy_clustering>`, :ref:`linkage delimitation <linkage_delimitation>` or :ref:`bayesian clustering <bayesian_clustering>`.

.. include:: conclusion.rst
