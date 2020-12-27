.. _denoising:

====================================
3. Frequency filtering / denoising
====================================

.. toctree::
	:hidden:
	
	extensions/denoising_by_sample


Introduction
============

Due to the use of PCR to generate metabarcoding datasets, we should generate plenty of copies of each real variant of the amplicon of interest, and thus many reads - depending on sequencing depth, of course. We can therefore be relatively confident that ASVs that occur at very low frequencies in the dataset are more likely to be errors.

.. admonition:: Software and data
	:class: green 
	
	The input data for this tutorial is a FASTA file comprising all of the unique sequences (ASVs) in your dataset. If you're following along step-by-step, this was produced in :ref:`the previous tutorial<dereplication>`. Alternatively, the file ``5_mbc_derep.fasta`` within the :ref:`sectionB archive<sectionBdata>` can be used as example data.
	
	This tutorial uses the :ref:`**VSEARCH**<vsearch>` software.
	

Simple frequency filtering
==========================

We can apply a simple threshold, keeping only ASVs that are present at equal to or greater than a given number of reads in the entire dataset. A standard threshold here would be 2, i.e. any singletons will be removed. This is a very straightforward function to apply, once again this could be performed by any number of different software tools but we will use **VSEARCH** because we probably have it installed already. :guilabel:`Run the below command`, remembering to replace ``input.fasta`` with the input data (see the software and data box above) and ``output.fasta`` with a sensible name.

.. parsed-literal::
	
	vsearch --fastx_filter :var:`input.fasta` --minsize 2 --fastaout :var:`output.fasta`
	

This is a straightforward filter, but it doesn't take into account all of the realities of amplification and sequencing. If an error arose in the later stages of PCR, or occured when sequencing a relatively rare ASV, then it's reasonable that errors may be infrequent, but if an error arose in the early stages of PCR then it would have been amplified many times.

Denoising
=========

A much more sophisticated approach to filtering errors is denoising. Denoising algorithms use read frequency and sequence composition to infer likely sequencing errors. ASVs are compared against one another and frequency thresholds are applied relative to counts of similar (but more common) ASVs. Instead of doing the size filtering as part of dereplication, we will instead do it as part of a denoising command. We will use the `**UNOISE3**<https://drive5.com/usearch/manual/unoise_algo.html>`_ algorithm, implemented again in **VSEARCH**. :guilabel:`Run the following command`, remembering to replace ``input.fasta`` with the input data (see the software and data box above) and ``output.fasta`` with a sensible name.

.. parsed-literal::

	vsearch --cluster_unoise :var:`​input.fasta`​ --minsize 2 --unoise_alpha 2 --centroids :var:`output.fasta`

The key parameter here is the alpha parameter, which determines the threshold level of dissimilarity between frequent and infrequent reads for exclusion of infrequent reads. Note that we’re using a less conservative minsize threshold than the default of 8 because of the smaller size of this toy dataset. 

.. admonition:: Exercise
	
	* How does the number of sequences filtered by this command compare with the output of the simple abundance threshold run before?
	* What is the effect on the number of sequences and size distribution of those sequences of varying the alpha parameter?
	* You can get the size distribution by running
	
	.. parsed-literal::
		
		grep -oP "(?<=size=).*$" ​:var:`input.fasta​` sort | uniq -c
	
	In the output of this command, the second column is the count of reads, and the first column is the count of these counts. So for example, if a row says ``24 12``, there are 24 ASVs that have 12 reads each.

Selecting denoising parameters
==============================

Denoising removed a large proportion of our ASVs, and this might seem like a large amount of data is being thrown away. However, while this removed a lot of unique sequences, the vast majority of them would have been rarer ASVs, and relative to the total number of reads in the dataset relatively few were discarded. Unfortunately, denoising is one of these steps where we cannot choose thresholds and parameter based on an *a priori* expectation, the settings must be tuned to the dataset and the research questions. 

As a baseline, it is sensible to always discard singletons. Beyond this, if the dataset is large, the research questions are tolerant to the loss of rare real sequences and/or it is important that as high a proportion of ASVs be valid as possible, then stricter settings (higher ``--minsize``, lower ``--unoise_alpha``) would be sensible. If the dataset is small and the preservation of as many valid ASVs as possible is preferred despite the probably retention of errors, then less strict settings should be used. The important point is that the decision is justified by the research questions and the dataset is sufficiently sequenced as to be resilient to the suitable settings.

Alternative pipelines and software
==================================

Denoising is crucial to modern metabarcoding pipelines, especially as increased work with Metazoan communities shows the scale of erroneous ASVs present in datasets. This is just one way that denoising can be performed, albeit the most common algorithm used. 

USEARCH vs VSEARCH
------------------

Here we have used the **VSEARCH** version of the **UNOISE** algorithm. The **USEARCH** version may on occasion be more up to date, and also includes chimera filtering (which we will do later). We are using the **VSEARCH** version because it only does denoising and because it's completely free and open source, whereas **USEARCH** is closed source and the free version has memory limitations. Some versions of the **USEARCH** version also change the output sequence headers in annoying ways that can't be changed.

We should recognise that Robert Edgar, the author of **USEARCH** and **UNOISE**, built this highly useful algorithm, but making software like this fully and freely available to the research community is an important principle and allows not only more rapid software development but greater validation of the algorithms and wider accessibility of these methods. 

Denoising by sample
-------------------

The standard usage of **UNOISE** works on the entire dataset, thus considers the frequency of ASVs relative to one another over the entire dataset. However, individual samples within a dataset are rarely evenly sequenced, therefore some ASVs may be rarer because they occur in undersequenced samples, not because they are errors. It may be more appropriate to denoise on the level of individual samples. If you'd like to try this out, you can try out this extension: `Extension: Denoising by sample <denoise_by_sample>`. Note it may take a little while so you may choose to come back to this later.

Other software
--------------

`**BFC** <https://github.com/lh3/bfc>`_ is a fairly common denoiser, often used more in the genomic sequencing realm than in amplicon sequencing, but it is occasionally used in metabarcoding. `**dada2** <https://benjjneb.github.io/dada2/index.html>`_ has recently gained in popularity among metabarcoders. Both of these algorithms work on an earlier stage of the pipeline, on the reads including quality data. In our experience, these algorithms tend to be much more strict than **UNOISE**, which may well be appropriate for some questions. We're not exploring them here because their approach wraps up many of the steps we're learning one-by-one, thereby skipping over a lot of the points we try to illustrate in these resources. However, we certainly do not recommend against them; **dada2** has `an excellent tutorial<https://benjjneb.github.io/dada2/tutorial.html>`_ that in our experience is straightforward to follow and produces reasonable outputs, albeit conservative. We would note that if you try out **dada2** for a coding region such as CO1, length and translation filtering should be performed on the denoised outputs.

Next steps
==========

You should have produced many denoised outputs while you were playing around with the thresholds. We suggest you clean these up and proceed using the output from the command given above, i.e. with ``--minsize 2 --unoise_alpha 2``. This file contains a more filtered set of ASVs than we started with, but there are still other sources of error we can address, starting with :ref:`4. Indel filtering <indel_filtering>`.

