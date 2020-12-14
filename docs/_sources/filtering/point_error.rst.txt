.. _point_error:

========================================
5. Point error filtering
========================================

Introduction
============

Filtering by length will remove sequences that have one or more PCR/sequencer-caused insertions or one or more deletions, however in some cases these errors may cancel one another out; or alternatively, PCR or sequencing may induce the equivalent of point mutations, where a single base is misread. Similarly, noncoding gene variants such as numts or pseudogenes may actually have point mutations in comparison to the 'true' region.

We can identify some point errors because they will alter the translation of the genetic code in such a way that it becomes meaningless - if the barcode region is a coding region, of course. The obvious error is the introduction of stop codons into the translation. By translating all of our sequences and checking for stop codons, we can easily reject these errors or variants. 

Filtering by translation
========================

We use the tool ``filtertranslate`` for this. 

.. sidebar:: Alternatives
	
	``filtertranslate`` is part of the metaMATE program, available `here <https://github.com/tjcreedy/metaMATE/>`_. In general, in these resources we aim to use the most popular tools, not just what we think is best, and avoid evangelising our own solutions. However, we haven't yet found another piece of software that so simply performs translation filtering, so here we use one of our own tools.
	
	Most commonly, we see other metabarcoders either performing this step manually, by translating the sequences in some GUI sequence viewer like Geneious and manually checking for stops, or by using `MACSE <https://bioweb.supagro.inra.fr/macse/>`_. MACSE is a very neat piece of software that performs alignment of nucleotide sequences against references using the translation, and is very good at finding frameshift errors. However it is a little complex to use and most seriously is not very efficient, scaling very poorly for larger amplicon dataset.

Check the helpfile for this script by running:

.. code-block:: bash 

	$ filtertranslate -help

.. admonition:: Exercise
	
	Figure out what the command is to run ``filtertranslate`` with all of the following options:
	1. using automatic reading frame detection
	2. outputting both succeeding and failing sequences in separate files
	
	Hint: check the usage line to figure out where some of the arguments go. Don’t forget, our samples are insects.

.. admonition:: Solution
	:class: toggle

	.. code-block:: bash

		$ ​filtertranslate ​-i in.fasta​ -t 5 -y separate -o output

.. admonition:: Exercise

	Have a look at the failed file. 
	Go to an online amino acid translator (e.g. `here <https://web.expasy.org/translate/>`__) and paste in a sequence. Make sure to set the correct genetic code.
	See what the translation looks like. Frame 2 is the correct frame. 
	Can you see the stop(s)?

Other 'point errors' that do not cause stops are harder to spot. Some will not affect coding at all, which is impossible to distinguish from natural variation. The majority will affect coding, but again distinguishing these from natural variation is very hard. One possibility is to look at the structure of the translated protein and see if it's realistic, but there aren't currently any tools that can do this...

Next steps
==========

We now have a set of ASVs that are all of the correct length, with a lot of errors hopefully removed. The final thing to do is remove chimeras, which we will do in the next step: :ref:`6. Chimera Filtering <chimera>`.
