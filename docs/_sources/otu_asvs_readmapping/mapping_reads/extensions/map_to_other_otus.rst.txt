.. _map_to_other_otus:

================================================
Extension: Mapping reads to CROP and swarm OTUs 
================================================

The reads can be mapped to the CROP OTUs in a similar fashion, altering the -id value to fit the clustering threshold used in CROP. Swarm OTUs are not generated in quite as consistent a manner, but an appropriate threshold using vsearch would be ``-id 0.99``.

For more accurate assignment of reads to swarm OTUs, you *could* try and do the following if you have time and the skills.

1. use swarm’s ``-o`` option while generating OTUS to output a list of unique sequences making up each OTU

2. Use​ ``vsearch --search_exact`` to map the reads against the unique sequences

3. Link this mapping to the list of unique sequences somehow, then to the OTU sequences, and finally count up the number of sequences from each sample for each OTU.

The next section is :ref:`identification using MEGAN and GenBank<id_using_megan>`!