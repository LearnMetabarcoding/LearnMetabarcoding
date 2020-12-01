=================================
Linkage-based clustering
=================================

SWARM is a slightly different clustering algorithm. Rather than using a threshold that applies to all clusters like vsearch’s clustering method, it uses a local linking threshold that is based on number of differences, rather than overall dissimilarity. Run swarm as follows:

.. code-block::bash 

	$ swarm -w ​out.fasta​ -d 1 -z ​in.fasta

* What happens if you run with higher ``-d`` values (they must be integers).