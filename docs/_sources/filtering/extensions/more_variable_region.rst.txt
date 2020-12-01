.. _more_variable:

======================================================================
What if we have a more variable region? Extension
======================================================================

What if we have a coding region like CO1 where we expect no single-base indels, but overall the region is more variable (or we have a wider range of taxa) and we might see real established whole-codon insertions or deletions?

* Briefly think about how we might specify a filter for this - assuming the same target length of 418bp, what lengths might we allow?

As it happens, it doesn’t seem that there are any programs out there that do this filtering already. One way to do it is filter by each length separately, and then concatenate the results - so, allowing one codon of variation, we would do:

.. code-block:: bash 

	$ for l in 415 418 421; do \
	> vsearch --fastx_filter mbc_concat.fastq --fastq_minlen $l \
	> --fastq_maxlen $l --fastaout mbc_concat_${l}_ctrim.fasta; \ 
	> done && cat *ctrim.fasta

We would want to make sure that worked properly by checking the number of sequences in the relevant files:

.. code-block:: 

	$ grep -c "^>" *ctrim.fasta

You can now move onto the :ref:`Frequency filtering / denoising section<denoising>`.