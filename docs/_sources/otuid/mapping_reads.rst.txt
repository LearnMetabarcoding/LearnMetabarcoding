=====================================
1) Mapping reads to OTUs
=====================================

.. toctree::
    :hidden:

    extensions/map_to_other_otus


This step takes our trimmed, merged and quality filtered reads and tries to find which OTU each read belongs to. We take our reads prior to the more recent read filtering because this filtering may have removed many true but rare variants of our OTUs, or slight PCR or sequencing-induced error variants. These reads get matched to the closest OTU, but we set a similarity cut-off so that any reads that are major errors will not match to any OTU and be ignored.

We are going to use our 3% clustering OTUs for this at first, using the ``​VSEARCH --usearch_global`` command to search the reads against the OTUs, and output an OTU table.

.. code-block:: bash

	$ vsearch --usearch_global mbc_concat.fasta -db ​otus.fasta ​-id 0.97 -uc ​mapresults.uc

We use the ``-id 0.97`` parameter to set a 3% similarity cutoff, which is obviously appropriate for the 3% OTUs. The algorithm finds the best match in the database for each query sequence and output this information in a ``.uc`` file, which is a tabulated output. Have a look at this file using head or cat. Each line shows the hit statistics for each input read against its best match, if it has one. You should be able to see that each read has a ``sample=`` part to the name that we added earlier to identify its source. So all we need to do now is count up the number of hits for each OTU for each sample.

Thankfully, vsearch can do this for us. Run the command above again, but this time swap out the ``-uc out.uc`` o​ption for ``-otutabout ​out.tsv.`` Have a look at the table output using head or cat. Perfect!

If your interested in how you'd map reads to CROP and swarm OTUs, have a look at the next :ref:`extension<map_to_other_otus>`.
Alternatively, move on to the next :ref:`section<id_using_megan>`