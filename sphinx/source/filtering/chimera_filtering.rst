.. _chimera:

====================
6. Chimera filtering
====================

Introduction
============

Chimeras generally arise during PCR when two strands of DNA that are not in fact the correct mirrors of one another become annealed together. This can create ASVs where different parts of the sequence come from different true sources. We remove these with a clever algorithm, **UCHIME denovo**, that (simply) searches all of the ASVs against one another, looking for *subregions* that match, not just matches over the complete length of the ASVs. Where a sequence has two or more parts that match to two or more different ASVs *that are more common*, this sequence is thought to likely be a chimera. Like **UNOISE**, this algorithm is implemented in both the **USEARCH** and **VSEARCH** software (see the :ref:`denoising tutorial <denoising>` for a discussion about **USEARCH** and **VSEARCH**.

.. admonition:: Software and data
	:class: green 
	
	The input data for this tutorial is a FASTA file comprising unique sequences (ASVs). If you're following along step-by-step, this was produced in :ref:`the previous tutorial <point_error>`. Alternatively, the file ``8_mbc_transpass.fasta`` within the :ref:`sectionB archive <sectionBdata>` can be used as example data.
	
	
	This tutorial uses the :ref:`VSEARCH <vsearch>` software.
	

Performing chimera filtering
============================

For a complex algorithm, chimera filtering is very easy to implement, as it doesn't generally require much in the way of parametric tuning (i.e. fiddling with arbitrary thresholds).

.. parsed-literal::

	vsearch --uchime3_denovo ​:var:`input.fasta​` --nonchimeras ​:var:`output.fasta`

It’s that simple, and in the vast majority of cases this will work really well. There is an alternate version of UCHIME that compares against a reference collection rather than doing *de novo* detection against other ASVs in the dataset. This version may be much more accurate, since rather than assuming that the more frequent ASV is the correct one, it has a set of known correct sequences. However, it requires a very comprehensive reference set, which is rarely possible in metabarcoding. Generally, the assumption that more frequent ASVs are more likely to be correct holds true, and the *de novo* approach is completely fine.

Next Steps
==========

We have completed our main filtering pipeline, and the ASVs that remain after chimera filtering are our best estimates of the true biological sequences in our dataset. We will be using this file for many of the other sections, so make sure you name it clearly so you can get to it later.

In the next section, :ref:`ASVs, OTUs and read mapping <asv_otu_readmap>` we'll discuss two of the most common next steps for a set of ASVs: delimiting the ASVs into OTUs, and mapping the reads onto the ASVs or OTUs to get counts of reads per ASV/OTU per sample.

The next section discusses using ASVs without OTU delimitation. This is a completely legitimate approach that lets us examine population-level patterns of community ecology. You may want to read the discussion and explore the alternative filtering strategy available using **metaMATE**, examined in this extension: :ref:`Extension: metaMATE <metamate>`. 
