.. _mapping_reads_otus:

=====================================
Mapping reads to OTUs
=====================================

Introduction
============

At first glance, we might assume that it is as straightforward to match reads to OTUs as it is to match reads  to ASVs. However, with ASVs, the sequence of an ASV represents 100% of the variation of that ASV, so we can perform strict exact matching with confidence and even less strict matching with some confidence. On the other hand, the representative sequence of an OTU does not represent all possible variation within an OTU. So exact matching of reads to OTU sequences will leave a large proportion of reads unmatched, many of which will be the reads corresponding to valid ASVs that formed part of an OTU, but did not become that OTU's representative sequence.

On the other hand, matching with some threshold of similarity may often be inappropriate for OTUs, because not only might the threshold not be the same, the computation of similarity performed by the matching may not be equivalent to the algorithm used to group OTUs. In the previous section, we used an unambiguous similarity threshold within ``--usearch_global`` to assign reads to ASVs, and using the same threshold to assign reads to OTUs would only be appropriate *if the same method was used to group ASVs into OTUs*.

If this is not the case, we must use a two-stop process. First, we match reads to ASVs as we did in the previous section. Next, we use the data we generated during OTU delimitation reporting which ASVs form each OTU to reduce the ASV read map into an OTU read map, grouping together data for all of the ASVs in each OTU.

Grouping ASV Read Data
======================

For this step, you will need a table of read counts per ASV per sample, as produced in the previous step, with ASVs as the rows and samples as the columns. You will also need a file that lists the set of ASVs in each OTU, as produced as part of the OTU delimitation for each of our steps. However, because the format of this was slightly different for each OTU delimitation step, we will need to process each of them first, according to the method used.

Greedy Clustering using VSEARCH
-------------------------------

Here our list takes the form of a table, so it's already almost in the format we want, we just need to drop the hit statistics and strip the ``;size=`` tags

.. code-block:: bash
	
	cut -f1,8 input.uc | sed -e "s/;size.*$//" > output.tsv

Linkage Delimitation using ``swarm``
------------------------------------

Here each line of the file is a list of ASVs in one OTU, with the centroid sequence being the first ASV name. The following command strips out the ``size=`` tags then converts into a table by looping through each line one by one, storing the first item in each line, then looping through the items in a line to generate the output.

.. code-block:: bash
	sed -e "s/;size=[^ ]*//g" input.tsv | \
	sed -e "s/;size=[^ ]*//g" asv_otus_linkage_d13.tsv | \
	while read l \
	do \
		n=${l%% *}; \
		for a in $l \
		do \
			echo -e "$n\t$a" \
		done \
	done > output.tsv

Bayesian Delimitation using CROP
------------------------------------

The file output by CROP is similar to that output by swarm. The first item on each line is the name of the centroid sequence, which is followed by a tab then a list of all the ASV reads forming that OTU. Remember, CROP worked on ASV reads, i.e. one sequence for each ASV for each read it had in the original dataset. So we will see duplicated ASV names within OTUs. We don't need to strip out ``;size=`` tags though!
The following command is similar to the command for ``swarm``. We convert commas to spaces, then loop through the table in the same way, this time instead of using a single variable ``$l`` for a line we use two, because we've specified that the Input File should be Separated by tab (``IFS=$'\t'``). We generate a line for each ASV read as we did before, but this time we pipe this into a ``sort`` then find the ``uniq`` lines to strip out those duplicates.

.. code-block:: bash
	
	sed -e "s/,/ /g" input.list | \
	while IFS=$'\t' read -r n l \
	do \
		for a in $l \
		do \
			 echo -e "$n\t$a" \
		done | sort | uniq \
	done > output.tsv







This step takes our trimmed, merged and quality filtered reads and tries to find which OTU each read belongs to. We take our reads prior to the more recent read filtering because this filtering may have removed many true but rare variants of our OTUs, or slight PCR or sequencing-induced error variants. These reads get matched to the closest OTU, but we set a similarity cut-off so that any reads that are major errors will not match to any OTU and be ignored.

We are going to use our 3% clustering OTUs for this at first, using the ``​VSEARCH --usearch_global`` command to search the reads against the OTUs, and output an OTU table.

.. code-block:: bash

	$ vsearch --usearch_global mbc_concat.fasta -db ​otus.fasta ​-id 0.97 -uc ​mapresults.uc

We use the ``-id 0.97`` parameter to set a 3% similarity cutoff, which is obviously appropriate for the 3% OTUs. The algorithm finds the best match in the database for each query sequence and output this information in a ``.uc`` file, which is a tabulated output. Have a look at this file using head or cat. Each line shows the hit statistics for each input read against its best match, if it has one. You should be able to see that each read has a ``sample=`` part to the name that we added earlier to identify its source. So all we need to do now is count up the number of hits for each OTU for each sample.

Thankfully, vsearch can do this for us. Run the command above again, but this time swap out the ``-uc out.uc`` o​ption for ``-otutabout ​out.tsv.`` Have a look at the table output using head or cat. Perfect!

If your interested in how you'd map reads to CROP and swarm OTUs, have a look at the next :ref:`extension<map_to_other_otus>`.
Alternatively, move on to the next :ref:`section<id_using_megan>`
