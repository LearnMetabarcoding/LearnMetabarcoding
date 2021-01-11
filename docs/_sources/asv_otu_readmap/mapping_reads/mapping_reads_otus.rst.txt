.. _mapping_reads_otus:

.. role:: var

=====================================
Mapping reads to OTUs
=====================================

Introduction
============

At first glance, we might assume that it is as straightforward to match reads to OTUs as it is to match reads  to ASVs. However, with ASVs, the sequence of an ASV represents 100% of the variation of that ASV, so we can perform strict exact matching with confidence and even less strict matching with some confidence. On the other hand, the representative sequence of an OTU does not represent all possible variation within an OTU. So exact matching of reads to OTU sequences will leave a large proportion of reads unmatched, many of which will be the reads corresponding to valid ASVs that formed part of an OTU, but did not become that OTU's representative sequence.

On the other hand, matching with some threshold of similarity may often be inappropriate for OTUs, because not only might the threshold not be the same as used for OTU grouping, the computation of similarity performed by the matching may not be equivalent to the algorithm used to group OTUs. In the previous section, we used an unambiguous similarity threshold within ``--usearch_global`` to assign reads to ASVs, and using the same threshold to assign reads to OTUs would only be appropriate *if the same method was used to group ASVs into OTUs*.

If this is not the case, we must use a two-step process. First, we match reads to ASVs as we did in the previous section. Next, we use the data we generated during OTU delimitation reporting which ASVs form each OTU to reduce the ASV read map into an OTU read map, grouping together data for all of the ASVs in each OTU.

.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is a FASTA file comprising OTU sequences, a text file listing the ASVs grouped into each OTU, and a tab-delimited table recording reads per ASV per sample. If you're following along step-by-step, the first two files will have been produced by the :ref:`OTU delimitation <otu_delim>` method of your choice. The third file will have been produced in the previous tutorial, :ref:`Mapping reads to ASVs<mapping_reads_asvs>`. Alternatively, the files ``otus_greedy_0.97.fasta``, ``asvgroups_greedy_0.97.uc`` and ``9_mbc_final_readsmap.tsv`` within the :ref:`sectionC archive<sectionCdata>` can be used as example data.
	
	This tutorial uses the :ref:`VSEARCH<vsearch>` software.
	

Preparing the OTU ASV lists
===========================

For this step, you will need a file that lists the set of ASVs in each OTU, as produced as part of the OTU delimitation for each of our steps. However, because the format of this was slightly different for each OTU delimitation step, we will need to process each of them first, according to the method used. Note that there's no particular need to run all three of these sections, just run whichever section matches the OTU delimitation method that you chose.

Greedy clustering using VSEARCH
-------------------------------

Here our list takes the form of a table, so it's already almost in the format we want, we just need to drop the hit statistics and strip the ``;size=`` tags

.. parsed-literal::
	:class: codebg
	
	cut -f1,8 :var:`input.uc` | sed -e "s/;size.*$//" > :var:`output.tsv`

Linkage delimitation using swarm
--------------------------------

Here each line of the file is a list of ASVs in one OTU, with the centroid sequence being the first ASV name. The following command strips out the ``size=`` tags then converts into a table by looping through each line one by one, storing the first item in each line, then looping through the items in a line to generate the output.

.. parsed-literal::
	:class: codebg
	
	sed -e "s/;size=[^ ]\*//g" :var:`input.tsv` |
	while read l;
	do
		n=${l%% \*};
		for a in $l;
		do
			echo -e "$n\\t$a";
		done;
	done > :var:`output.tsv`

Bayesian delimitation using CROP
--------------------------------

The file output by **CROP** is similar to that output by swarm. The first item on each line is the name of the centroid sequence, which is followed by a tab then a list of all the ASV reads forming that OTU. Remember, **CROP** worked on ASV reads, i.e. one sequence for each ASV for each read it had in the original dataset. So we will see duplicated ASV names within OTUs. We don't need to strip out ``;size=`` tags though!

The following command is similar to the command for **swarm**. We convert commas to spaces, then loop through the table in the same way, this time instead of using a single variable ``$l`` for a line we use two, because we've specified that the Input File should be Separated by tab (``IFS=$'\t'``). We generate a line for each ASV read as we did before, but this time we pipe this into a ``sort`` then find the ``uniq`` lines to strip out those duplicates.

.. parsed-literal::
	:class: codebg
	
	sed -e "s/,/ /g" :var:`input.list` |
	while IFS=$'\\t' read -r n l;
	do
		for a in $l;
		do
			 echo -e "$n\\t$a";
		done | sort | uniq;
	done > :var:`output.tsv`

Extension: phylogenetic delimitation using bPTP
-----------------------------------------------

If you also tried out using **bPTP** for OTU delimitation, when we re-processed the output for **bPTP** we actually made it into the same format as for **swarm**. So you can use exactly the same code as for the **swarm** ASV grouping file, above.

Joining our data
================

Now we can join the output from the above to your table of read counts per ASV per sample, as produced in the previous step, with ASVs as the rows and samples as the columns. We do this using the linux ``join`` command. The first table will be our table of ASVs and OTUs: the ASVs are column two, so we specify that the join column for the first table is column two (``-1 2``). The second table is our ASV read counts table, where the join column (the column of ASV names) is column one (``-2 1``).

.. parsed-literal::
	:class: codebg
	
	join -1 2 -2 1 <(sort :var:`ASV-OTU.tsv`) :var:`ASV_read_map.tsv` > output.tsv

Note that we sorted the ASV-to-OTU table, this is a necessary step for ``join`` to work properly.

Use ``head`` to view the output file. You'll see two columns of sequence names followed by the read count data. The first column is the join column, i.e. the ASV names. The second column is the other column from the ASV-to-OTU table, i.e. the OTU centroid names. We can now get rid of the first column, the ASV names, after changing the file from space-delimited back to tab-delimited

.. parsed-literal::
	:class: codebg
	
	sed -e "s/ /\\t/g" :var:`input.tsv` | cut -d2- > :var:`output.tsv`

You might have noticed that we've lost the header column from the ASV read map table: this is because it didn't have an ASV name in column 1 to match against the other table. No matter, we can bring it back again.

.. parsed-literal::
	:class: codebg
	
	cat <(head -1 :var:`ASV_read_map.tsv`) :var:`input.tsv` > :var:`output.tsv`

Summing over OTUs
=================

The last issue is that we have multiple rows for each OTU, and we want to sum all occurences of all ASVs within each OTU into one row. We can do this using an R one-liner.

.. parsed-literal::
	:class:
	
	Rscript -e 'x<-read.table(":var:`input.tsv`",header=T,comment.char="",sep="\\t");rowsum(x[,-1],x[,1])' > :var:`output.tsv`
	

This output gives the total read numbers for all ASVs within each OTU by sample.

Shortcut for greedy clustering
==============================

In the introduction, we discussed that simply matching reads directly to OTUs is not appropriate unless the method we use to match reads to OTUs accurately reflects the method by which OTUs were initially delimited. In fact, for greedy clustering, this is true. Greedy clustering uses pairwise similarity to group ASVs, working in order of ASV frequency which has the effect that ties are broken by choosing the more frequent cluster. Given that the outputs are thus ordered by frequency, and that ``--usearch_global`` chooses the the first record in the database in the case of ties, we can in fact search reads directly against the OTUs **for greedy clustering only**. This uses the same command as we saw in less-strict ASV mapping:

.. parsed-literal::
	:class: codebg
	
	vsearch --usearch_global :var:`reads.fasta` -db :var:`​otus.fasta` -id 0.97 -otutabout :var:`output.tsv`
	

We use the ``-id 0.97`` parameter to set a 3% similarity cutoff for OTUs that have been clustered at 97% similarity. Obviously if you had used a different similarity threshold when clustering, you'd use the same value here.

This shortcut is **only** available for greedy clustering. To the best of our knowledge, the above two-step process is the most appropriate way to map reads to OTUs for other types of OTU delimitation. Hopefully we've persuaded you that to map reads using this shortcut for **swarm**, **CROP** or another method would likely give erroneous read counts. Of course, it's likely that the majority of read assignments would probably be correct, since in most cases the most similar OTU to a read is likely the appropriate read, but its the handling of outlying variants that could cause errors and ambiguities to creep in.

Next steps
==========

The output from this subsection forms the metabarcoding equivalent of a site by species table ready to be used in downstream analysis, although we would recommend some further filtering which we discuss in the :ref:`Analysing read tables <analysis>` subsection. 

You may want to learn about building a phylogeny of your OTUs in the :ref:`Building OTU phylogeny <phylogeny>` section, or taxonomically identifying and/or classifying your OTUs in the :ref:`Identifying OTU sequences <otuid>` section.
