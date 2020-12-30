.. _pair_concatenation:

.. role:: var

========================================
Extension: Pair concatenation
========================================

Introduction
============


What happens if our fragment length is so much longer than our read length that it doesn’t overlap? For example, if we had sequenced these fragments using a 2x150bp metric instead of 2x300bp? Let’s simulate it.

.. admonition:: Data and software

	This extension follows on from the tutorial on :ref:`pair merging <pair_merging>` using the same starting data and software.
	
	We will also use :ref:`cutadapt <cutadapt>` and :ref:`pairfq <pairfq>`.


Simulation
==========

We will use the same starting data as from the :ref:`pair merging <pair_merging>` tutorial; that is, a set of paired FASTQ files, one pair per sample. We can apply **cutadapt** to remove 150bp from the 3’ end of each read for a pair of files (see the :ref:`demultiplexing<demultiplexing>` and/or :ref:`primer removal <primer_removal>` tutorials for more about **cutadapt**). First, create a folder for this experiment (mine is called ``trimmed_150``). Next, run the following commands, selecting the file pair from a single sample as the inputs.

.. parsed-literal:: 

	cutadapt -u -150 -o :var:`trimmed_150/output_R1.fastq` :var:`input_R1.fastq`
	cutadapt -u -150 -o :var:`trimmed_150/output_R2.fastq` :var:`input_R2.fastq`

.. admonition:: Exercise
	
	* Now try running PEAR on these two files using the commands from the :ref:`previous tutorial<pair_merging>`

We can't merge them, because there's nothing left that overlaps. So instead we have to perform concatenation - stitching the forward and reverse reads together. This achieves the same aim, converting into a single sequence rather than two independent reads.

The sequencer has introduced some length variation - some reads have recovered a little more data than others. **PEAR** took care of this automatically when it was forming a single read using the overlap, but concatenation is more basic. With non-overlapping data we need to concatenate like with like so that we generate a consistent (pseudo-)region of DNA. Otherwise we would generate spurious insertions/deletions when comparing our sequences.

In most cases, we would trim or discard reads such that the forward and reverse reads were each a fixed length, and then stitch each mate pair together to form a pseudo-locus. While there’s really a missing section of DNA in the middle, we have summarised our molecular information into a single fragment that is perfectly usable for many metabarcoding applications.

Let’s review the length distribution of our sequences to select a fixed length for each direction:

.. parsed-literal:: 

	sed -n '2~4p' ​in.fastq​ | while read l; do echo ${#l} ; done | sort | uniq -c

Generally, we would select something around the central tendency, to retain as much data as possible.

:guilabel:`Select a length for each read direction. It does not need to be the same value.`

We know the end with the primer is the accurate end, so we trim bases from the other end. We use **cutadapt** for this. The ``-l`` argument trims reads down to a value, and the ``-m`` argument specifies a minimum length. Set them as the same value, and then run the following command on each of your simulated short read files.

.. parsed-literal:: 

	cutadapt -l :var:`N` -m :var:`N` -o :var:`output.fastq` :var:`input.fastq`

Re-pairing mates
================

**Cutadapt** removed short reads without removing their mates. We can't concatenate these files yet, because they have uneven numbers of sequences. This gives us the opportunity to test using a tool for mate-pairing - i.e. making sure two files are "in sync". This is performed by throwing away any reads in either the forward or reverse file that do not have a mate pair in the other file. We will use **pairfq** for this.

.. admonition:: Exercise
	
	Run **pairfq** on your simulated short read files, as follows. There are a lot of names to replace in this command!
	
	.. parsed-literal:: 
	
		pairfq makepairs -f ​:var:`input_R1.fastq` -r :var:`input_R2.fastq` -fp :var:​`output_R1.fastq` -rp :var:`output_R2.fastq` -fs ​:var:`output_R1_unpaired.fastq​ -rs` :var:`​output_R2_unpaired.fastq`
	
	As always, use ``grep`` to check output file read numbers. 

Stitching
=========

**PEAR** can stitch our mate pairs, and it reverse-complements the reverse reads for us.

.. parsed-literal:: 

	pear -i -f :var:`input_R1.fastq` -r :var:`input_R2.fastq` -o :var:`outname`

This won't work! The problem is thatThen run **PEAR** again to concatenate the mate pairs, as in the previous command but now using the outputs from **pairfq**.
	
	* Are these concatenated sequences as reliable as our merged sequences? Why not?

.. admonition:: Note
	
	If we have reads that are just too short to overlap, or too short to overlap well (e.g. < 10-20bp overlap), one option is to edit the reads such that the small missing region is padded with Ns. Reads that do overlap are merged if possible, or trimmed to be consecutive. Reads that are too short have N added to go up to the right length, and then the reads are stitched. This only applies to regions where we can be reasonably confident of a consistent, predictable length between primers. One issue would be the selection of an OTU delimitation method that took account of the ambiguous regions, otherwise the sequences would in general be more similar to one another than expected. For this reason this would only usually be done for projects with a small missing region.

Next steps
==========

If you have lots of time and you're very interested, you could at this point run the simulated trimming, re-pairing and stitching on the rest of the files, creating a parallel dataset of concatenated short reads. Later, after completing sections A, B and C you could then come back to these and work through the rest of the tutorials. Compare how these sequences behave in the future steps, particularly :ref:`chimera filtering <chimera>` and :ref:`OTU delimitation<otu_delim>`.

Alternatively, we'd suggest deleting or archiving the files created in this step, to avoid clutting up your working directories, then proceeding with the next tutorial, :ref:`4. Data concatenation<data_concat>`, which uses the merged files from the :ref:`3. Pair merging<pair_merging>` tutorial.
