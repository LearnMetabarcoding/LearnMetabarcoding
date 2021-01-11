.. _metamate:

.. role:: var

==================================
Extension: Stringent ASV filtering
==================================

Introduction
============

When we wish to use ASVs for ecological analyses at the level of populations, we may need greater confidence in the accuracy of our ASVs than compared with cases where we intend to cluster these ASVs to species. Firstly, our sampling must have been deep enough to capture not just sufficient species richness but sufficient haplotype richness to answer our research questions. Secondly, we must be confident that our error filtering has not only removed highly divergent errors that might have caused false OTUs, but also removed minor errors that would have otherwise been absorbed into OTUs. 

In this extension we will look at an alternative pipeline that builds upon the standard pipeline presented elsewhere to more stringently filter ASVs. This pipeline is not exclusively for studies exploring ASV patterns, the more conservative filtering of ASVs will also improve OTU results as well.

This pipeline is centred around the tool **metaMATE**, which performs so-called "Multidimensional Abundance Threshold Evaluation" [#]_. This means that it bases its filtering on ASV frequencies, but it calculates frequencies based on multiple strategies, and then evaluates many different threshold values to generate data from which the ideal filtering strategy can be determined. A key part of this evaluation is validation, where metaMATE independently checks the ASVs to determine if any are clearly valid or invalid, using this control group to evaluate the effect of different abundance calculation and threshold strategies.

In the spirit of openness, we should be clear that **metaMATE** was developed by many of the same people who authored these resources. We think it's a pretty good method for more stringent and careful filtering of ASVs, but of course we might be biased! To be fair, there aren't any other methods as detailed as this, but if you're thinking of using **metaMATE** in your bioinformatic pipeline, you should not do so just because we present it here, but after ensuring you know what it does and concluding that it is the most appropriate tool for your data.

.. admonition:: Data and software
	:class: green
	
	The **metaMATE** software requires quite a bit of input data:
	
	1. A FASTA or FASTQ of all reads in the dataset
	2. A FASTA of denoised unique sequences (ASVs)
	3. A FASTA of reference sequences
	4. A specifications file
	
	If you're following along step-by-step, the first two files were produced in the :ref:`quality filtering<quality_filtering>` and :ref:`denoising<denoising>` tutorials respectively. Alternatively, the files ``4_mbc_concat.fasta`` and ``6_mbc_denoise.fasta`` within the :ref:`sectionB archive<sectionBdata>` can be used as example data.
	
	The reference sequences can be found in the file ``references_CCCPbarcodes.fasta`` in the :ref:`sectionB archive<sectionBdata>`. The specifications file will be generated during the tutorial.
	
	This tutorial uses the :ref:`metaMATE <metamate_install>` software.


Getting started
===============

We will use as input a denoised dataset, prior to any length or translation filtering. This dataset has been reduced in size by performing denoising, but still has some errors that we can use for validation of non-authentic ASVs. Create a new directory and place a copy of your denoised ASVs into this directory.

To find some validated authentic ASVs, we will use a reference set of barcode sequences from some species we know are present in our metabarcoding dataset. Place the reference sequences (see the Data and software box above) into your new directory as well.

Next we must determine **metaMATE**'s threshold specification. This is a description of all of the thresholds that **metaMATE** should test. Unlike in the first part of our frequency filtering section, where we applied one threshold, **metaMATE** can apply many thousands of thresholds, varying either the value of the threshold or the grouping of ASVs on which it's performed. We will use three threshold binning strategies, as follows:
1. The absolute number of reads of an ASV in the dataset as a whole
2. The proportion of reads of an ASV in each of the samples in which it occurs
3. The proportion of reads of an ASV within the clade in which it occurs in each of the samples in which it occurs

We can specify these by typing the following into a text document:

.. parsed-literal::
	
	[total; n; 1-5/5\,6-20/8\,25-50/6\,60-100/5]
	+
	[library; p; 0.00025\,0.0005-0.007/14\,0.008-0.01/3]
	+
	[library|clade; p; 0.001\,0.0025\,0.005-0.065/13\,0.075\,0.09\,0.1-0.4/7\,0.5-0.9/5]

The first command tells **metaMATE** to filter ASVs by total frequency with 5 + 8 + 10 + 5 = 28 different thresholds: 5 values from 1-5, 8 values from 6-20, 6 values from 25-50 and 5 values from 60-100. This is just a shorthand way of typing ``1,2,3,4,5,6,8,10,12,14,16,18,20,25,30,35,40,45,50,60,70,80,90,100``! The ``n`` denotes actual values of frequency, whereas on later lines the ``p`` denotes proportional values, relative to the total number of reads in the given category. So for the second command, we have 18 thresholds, the first being "reject an ASV if it is less than 0.025% of all reads of all ASVS in every sample in which that ASV occurs", with each iteration increasing that percentage up to 1%. Finally, the last command does something similar, but instead of comparing against the total number of reads in a sample, looks at the total number of reads from ASVs in the same clade as the ASV in question. 

This is complicated at first, but is quite straightforward once you get your head around it. Create a text document in your **metaMATE** directory with the above 5 lines - don't forget the ``+`` symbol!

The last thing to do is to make sure you have a copy of your concatenated reads file in your directory. The software will use this to calculate the number of reads of each ASV in each sample.

Finding metaMATE results
========================

We run **metaMATE** specifying the path to these four files, as well as a few other settings.

Run the following code, obviously swapping the names of the files for whatever your file names are. ``metamateout`` should be the name of a directory into which you want to place the results - **metaMATE** will create this if it doesn't exist.

.. parsed-literal::
	
	metaMATE find \\
	-A :var:`denoisedASVs.fasta` -L :var:`concatenatedReads.fasta` \\
	-S :var:`specifications.txt` -R :var:`references.fasta` \\
	--expectedlength 418 --percentvar 0 \\
	--table 5 \\
	-o :var:`metamateout`

You might notice that we're specifying some information about the length and translation of our ASVs. This is because internally, **metaMATE** performs the length and translation filtering that we've performed ourselves in previous tutorials. It does this in order to identify some of the ASVs as *a priori* errors. It also searches the ASVs against the reference to idetnify some of the ASVs as *a priori* valid. 

The output of **metaMATE** will be several files in the output directory. You will have a file ending in ``_results.csv``. This is a table that you should download and open on your computer using Excel or another spreadsheet program.

Analysing metaMATE results
==========================

This table gives a detailed report of the result of every single filtering threshold you applied. The first few columns give the filtering terms, and the rows give their threshold values. If you look across the table, you can see that there are lots of columns giving counts of ASVs. If you're interested, you can read about what all of these are in `the metaMATE documentation <https://github.com/tjcreedy/metamate#results-find-only>`_, but we'll concentrate on two values. We want to know for each of our threshold values, what proportion of our known valid ASVs (those matching our reference) were retained, and what proportion of our known invalid ASVs (those of an incorrect length or containing stops) were rejected. These columns are "verifiedauthentic_retained_p" and "verifiednonauthentic_rejected_p" respectively. 

.. admonition:: Exercise
	
	* Filter and sort the table to try and find the highest values of valid retention and invalid rejection. Feel free to use whatever software you are most comfortable handling data in.
	* Is there an obvious best case, or is it always a trade off? You could pick a threshold and plot it on the x axis with "verifiedauthentic_retained_p" and "verifiednonauthentic_rejected_p" as series on the y axis.
	* Which do you think is more important: rejecting erroneous ASVs or keeping valid ASVs?

There aren't always clear answers to these questions, it must come down to whatever is most suitable for your research. This is the main way in which **metaMATE** is different: it doesn't just spit out an answer, instead its purpose is to evaluate lots of different threshold values and present you with the summary data to determine which threshold is most appropriate for your question.

Select a threshold that you think is the best compromise between retaining authentic ASVs and rejecting nonauthentic ASVs. The first column is called "resultindex", and contains a unique value for each threshold. :guilabel:`Find the resultindex for your selected threshold.`

Implementing thresholds
=======================

We can now use metaMATE again to output the ASVs for the selected threshold. This is much more simple than before. We need two input files: the same set of denoised ASVs as we used for the ``metaMATE find`` command, and the file ending ``_resultcache`` in the output directory. 

Run the following command, replacing the file names with the names of your files, and ``N`` with the resultindex of your selected threshold.

.. parsed-literal::

	metaMATE dump -A :var:`denoisedASVs.fasta` -C :var:`path/to_resultcache` -i :var:`N` -f :var:`output.fasta`

This FASTA contains the ASVs that result from the threshold we selected. In addition, any ASV that matched against our reference set is always included, even if it would otherwise be excluded based on the threshold, and any ASV that is the incorrect length or has stops in the translation is excluded, even if it would otherwise be included based on the threshold. We would generally recommend performing chimera filtering on this output, but otherwise this is ready to be used for analysis.

Next Steps
==========

If you want to use these ASVs in place of those generated by the main tutorials, we suggest performing :ref:`chimera filtering <chimera>` on them. Then, you can use the output from that in the next section, :ref:`C. ASVs, OTUs and read mapping <asv_otu_readmap>` and subsequent sections.

.. [#] C. Andújar, T. J. Creedy, P. Arribas, H. López, A. Salces-Castellano, A. Pérez-Delgado, A. P. Vogler, B. C. Emerson, Validated removal of nuclear pseudogenes and sequencing artefacts from mitochondrial metabarcode data , Molecular Ecology Resources 2021, In press (BioArxiv version here: https://doi.org/10.1101/2020.06.17.157347)
