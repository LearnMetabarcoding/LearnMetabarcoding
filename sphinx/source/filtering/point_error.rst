.. _point_error:

========================================
5) Point error filtering
========================================

Filtering by length will remove sequences that have one or more PCR/sequencer-caused insertions or one or more deletions, however in some cases these errors may cancel one another out; or alternatively, PCR or sequencing may induce the equivalent of point mutations, where a single base is misread. Similarly, noncoding gene variants such as numts or pseudogenes may actually have point mutations in comparison to the ‘true’ region.

We can identify some point errors because they will alter the translation of the genetic code in such a way that it becomes meaningless - if the barcode region is a coding region, of course. The obvious error is the introduction of stop codons into the translation. By translating all of our sequences and checking for stop codons, we can easily reject these errors or variants. We use the script filtertranslate.py [#f1]_ for this - check the helpfile by running:

.. code-block:: bash 

	$ filtertranslate.py -help

* Figure out what the command is to run it using automatic reading frame detection. Hint: check the usage line to figure out where some of the arguments go. Don’t forget, our samples are insects.

.. admonition:: Solution
	:class: toggle

	``$ ​filtertranslate.py ​in.fasta​ 5`` ​- yup, it’s that simple!

.. admonition:: Solution
	:class: togglegreen

	``$ ​filtertranslate.py ​in.fasta​ 5`` ​- yup, it’s that simple!	

You may want to rename the automatically-named output.

* Have a look at the failed file. Go to an online amino acid translator and paste in a sequence. See what the translation looks like. Can you see the stop(s)?

Other ‘point errors’ are harder to spot. Some will not affect coding at all, which is impossible to distinguish from natural variation. The majority will affect coding, but again distinguishing these natural variation is very hard. This is actually something that some denoising algorithms attempt to do, broadly, but further work on this is ongoing.

The next step is :ref:`chimera filtering<chimera>`

.. rubric:: Footnotes 

.. [#f1] This custom script is available on my `github <https://github.com/tjcreedy>`_. 
		 Please let me know if you know of any established software that can do this in a similar manner!
