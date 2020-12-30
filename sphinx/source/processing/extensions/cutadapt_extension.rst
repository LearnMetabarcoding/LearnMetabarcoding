.. _cutadapt_extension:

.. role:: comment

==============================
Extension: Cutadapt parameters
==============================

**Cutadapt** has a lot more parameters for searching. Here are some of them that you might use to optimise returning as many reads as possible while still removing any errors.

This extension follows on from the tutorial on :ref:`demultiplexing <demultiplexing>` using the same data and software.

Error tolerance
===============

**Cutadapt** can be error-tolerant, allowing you to permit some mismatches between your indices and the sequences. Our adapters are all at least 3 bases different, so in theory we could allow a one-base difference to try and get more reads for our samples. The relevant option is ``-e​``, which is the maximum error rate (0-1), i.e. the total proportion of errors allowed in our indices. The default, 0.1, would allow 10% errors, but since our indices are only 6 bases this rounds to 0 errors allowed.

.. admonition:: Exercise

	* Create two more new directories and try ``-e`` values that allow one error or two errors, putting the outputs into those two directories. Explore the read numbers using ``grep``
	
	* How do the read numbers vary?
	* Is being more error-tolerant sensible?

Variable index location
=======================

In the main section, we used the ``^`` symbol to denote that our index sequences must be exactly at the start of a read. However, sequencing errors may mean that this might not be the case. There may be extraneous bases before the index sequence, or some of the bases may be missing. Of course, if too many bases are missing it will no longer be identifiable, but as we discussed above, 5 out of 6 correct bases would still allow us to identify the correct index. Consider the following hypothetical reads:

.. parsed-literal::
	
	key: **INDEX**\ *PRIMER*\ SEQUENCE
	1  **AACACC**\ *CCAGATATGGCCTTCCCACG*\ ATCC    :comment:`# This is perfect`
	2  **ACACC**\ *CCAGATATGGCCTTCCCACG*\ ATCCG    :comment:`# This is missing just one index base`
	3  T\ **AACACC**\ *CCAGATATGGCCTTCCCACG*\ ATC    :comment:`# This has an extra base before the index`

**Cutadapt** is very flexible, and we can find these variants if we abandon the anchoring (i.e. we remove ``^`` before the indices). 

To cope with the truncated index (example 2 above), we can set the minimum overlap parameter, ``-O`` to 5, i.e. we must find at least 5 bases (in order) of the index sequence. To allow the index sequence to move into the read, we can add ``N`` before the index, essentially searching for an index that is 7 bases long, but the first base can be anything. Paired with the ``-O 5`` option, this will find all of the examples above. 

But wait, we've removed index anchoring, so now it'll *also* find any sequence motifs within the read that match the index - that's not good! Never fear. We can add a special character, ``X`` to the beginning of our indices to make them "noninternal". Within cutadapt, the ``X`` base is the opposite of ``N``: where ``N`` is anything, ``X`` is nothing - ``X`` should never match a base, and therefore the index cannot match anything within the read. 

To visualise this, we can consider a search using the index ``g=XNAACACC`` with ``-O 5``:

.. parsed-literal::
	
	1  **AACACC**\ *CCAGATATGGCCTTCCCACG*\ ATCC
	 **XNAACACC**  = match!
	
	2  **ACACC**\ *CCAGATATGGCCTTCCCACG*\ ATCCG
	**XNAACACC**  = match!
	
	3  T\ **AACACC**\ *CCAGATATGGCCTTCCCACG*\ ATC
	  **XNAACACC**  = match!
	
	4  ATG\ **AACACC**\ CGUTTAGCTAAACGGATTTAGAC
	    **XNAACACC** = no match, X may not match a base!

.. admonition:: Exercise
	
	* Create another new directory, then build a **cutadapt** command that uses these "noninternal" indices. If you get stuck, see the solution below.
	* Check the number of reads returned using ``grep``. 
	* Do we see a boost in read counts?
	

.. admonition:: Solution
	:class: toggle
	
	.. parsed-literal::
		
		cutadapt -g T4=XNAAGAGG -g T9=XNAATCGC -g T11=XNAGCTAC \\
		-G T4=XNAAGAGG -G T9=XNAATCGC -G T11=XNAGCTAC \\
		-O 5 \\
		-o 1_demux/{name1}-{name2}_R1.fastq -p 1_demux/{name1}-{name2}_R2.fastq \\
		0_rawsequences/Lib1_R1.fastq 0_rawsequences/Lib1_R2.fastq

Tradeoffs
=========

Changing the error rate, minimum overlap and/or using noninternal indices (rather than anchored indices) generally increases the number of reads we get, but these may allow more errors to creep in. As always with bioinformatics, it's a trade-off between having highly accurate data or having as much data as possible. There is no right answer, you should consider what variation you consider to be reasonable within valid data, and which is more important: highly accurate data with possible missing information, or complete data with some inaccuracies.
