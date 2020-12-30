.. _map_to_ref:

========================================
Extension: Mapping reads to references
========================================

If we were only interested in the species for which we have reference sequences, for example if we were monitoring for a single or set of known species, there isn’t really much need to generate anonymous OTUs. We could simply map our trimmed, merged and quality filtered reads against the references directly, to get counts of our reference species in each sample.

.. admonition:: Data and software
	
	This tutorial requires as input a FASTA file of trimmed, merged and quality filtered reads, and a FASTA file of reference sequences. If you're following along step-by-step, we produced the former back in the :ref:`quality trimming<quality_trimming>` tutorial. Alternatively, the files ``4_mbc_concat.fasta`` and ``references_CCCPbarcodes.fasta`` within the :ref:`sectionE archive <sectionEdata>` can be used as example data.
	
	This tutorial uses the :ref:`BLAST<blast>` and :ref:`VSEARCH<vsearch>` software.

Searching reads
===============

We've carried out searching in two different previous tutorials: using **BLAST** when we :ref:`searched our OTUS against references<id_local>`, and using ``usearch_global`` when searching :ref:`reads against OTUs<mapping_reads>`.

.. admonition:: Exercise
	
	* Using what you learned in these previous tutorials, design commands to search your reads file against your reference sequences. Try using both **BLAST** and **VSEARCH** ``--usearch_global``. 
	* Experiment with different thresholds and outputs, in particular try the ``--otutabout`` option for **VSEARCH**
	* Is one method clearly superior?
