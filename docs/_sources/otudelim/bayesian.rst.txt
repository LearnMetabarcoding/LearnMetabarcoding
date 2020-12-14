.. _bayesian_clustering:

=========================
Bayesian clustering
=========================

A final method for clustering is CROP, which was originally designed for 16S and has not been updated in a while. Nonetheless, it uses an interesting algorithm based on assuming sequences are a gaussian mixture and models the process of clustering using Markov-chain Monte Carlo simulations.

CROP does not work on dereplicated reads, it needs the originals, so we must replicate them out again.

.. code-block:: bash 

	$ vsearch --rereplicate ​in.fasta​ --relabel repl --output ​out.fasta

We can then run this in crop. Note it creates several outputs using ``outname`` as a name base.

.. code-block:: bash 

	$ crop -b 40 -z 400 -s -r 0 -i ​in.fasta​ -o ​outname

The options ``-b``, ``-z`` and ``-r`` are for optimising the MCMC process. You can read more about these in their `documentation <https://github.com/tingchenlab/CROP/wiki/THE-CROP-WIKI>`_. You can leave these alone. Option ``​-s`` specifies that we want the equivalent of 3% clustering. We could change this to ``-g`` which is equivalent to 5%. You can alternatively supply values to ``-l`` and ``-u`` , for example ``​-l 1 -u 3`` , which are the lower and upper bounds of similarity levels.


CROP creates a bunch of extra files, you may want to ​mv​ them to their own folder. You could create a folder for each CROP run you do and make sure you’re in that directory when you run it.

* How do the number of OTUs differ between methods?

* For these sequences, 3% dissimilarity between two sequences is 0.03 * 418 = 12.54 differences. How does swarm perform if you use this value?

* Even if methods recover similar numbers of OTUs, are they necessarily recovering the same sequences?

For a quick look, we can use the following command to count the number of exactly identical sequences in all of the input files:

.. code-block:: bash 

	$ cat​ in1.fasta in2.fasta [in3.fasta]​ | \
	> perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' | \ 
	> sed -n '2~2p' | sort | uniq -c | grep -c "2"

Next Steps
==========

We've generated a set of OTUs using one method. If you haven't already, try out the other two types of OTU clustering: :ref:`Greedy Clustering <greedy_clustering>` and :ref:`Linkage Delimitation <linkage_delimitation>`.

Alternatively, if you've tried these already, select your favourite set of OTUs and proceed with them to the :ref:`Generating Data <generating_data>` section to learn about mapping your reads to your OTUs and doing taxonomic classification. Later on, we'll use these same OTUs and try to place them onto a phylogenetic tree in the :ref:`Phylogenetic Placement <phylogenetic_placement>` section.

