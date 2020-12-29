.. _aligning:

================================
3. Aligning protein coding genes
================================

Introduction
============

The sequences for each gene need to be aligned so that comparable regions are lined up. In phylogenetic terms, this means we need to ensure that the positions used for tree inference are homologous. 

.. admonition:: Data and software
	:class: green
	
	The input data for this tutorial is a directory of gene sequences in FASTA format, as produced in :ref:`the previous tutorial<extract_genes>`.
	
	This tutorial uses the :ref:`MAFFT <mafft>` software. You should also have an alignment viewer, such as **Aliview**, installed on your personal computer.

Running alignment
=================

We will do a quick alignment using **MAFFT** for each gene, using the FFT-NS-2 method. This is a fast, but less-accurate method.
First, make a directory to store your aligned genes.

Run the following command, making sure to replace ``raw`` with the name of the directory you extracted your genes into in the last step, and ​``new​`` with the name of your new directory:

.. code-block:: bash 

	for f in ​:var:`raw`/\*;
	do
		mafft --thread 1 --retree 2 --maxiterate 0 $f >​ :var:`new`/​${f#\*/};
	done

Notice how we've looped on the extracted gene files, running MAFFT on each file as input and outputting the alignment as a file with the same name, but in new directory.

.. admonition:: Exercise

	While this is running, have a look at the `manual for MAFFT <https://mafft.cbrc.jp/alignment/software/manual/manual.html>`_, in particular the different methods for alignment. Think about what might be best for these genes.
	

.. admonition:: Solution
	:class: toggle
	
	FFT-NS-2 is a fast but inaccurate method; if using your own data, you might want to instead use the **MAFFT** G-INS-i method. We generally would use this method, optimising gap opening and extension penalties for each gene to reduce gap formation. Sometimes the L-INS-I method works better on poorly-aligning genes. But there are no hard and fast rules about which is the most appropriate method in any case, generally the best strategy is to try several methods and use whatever works the best
	

.. admonition:: Exercise

	Once alignment is complete, pick one of your alignments and download it to your computer. Use an alignment viewer, such as AliView, to open the alignment. If you're new to viewing alignments, see :ref:`here <alignment_viewing>` for an introduction.
	* How does it look? Is the reading frame maintained?
	* Are all of the start and stop codons present and complete for all sequences, are they at the beginning or end of the sequences, and are they aligned properly? What might it mean if they aren’t?
	* Are there any sequences that look very out of place. If there were, what could this mean?

Sequence alignment is a big topic, beyond the scope of this course. There is a wide range of software out there: two other commonly-used alignment tools are **MUSCLE** and **CLUSTAL**. We find **MAFFT** to be very versatile and fast for all sorts of alignment tasks. If doing this with your own data, you would generally try to optimise the gap opening parameters for each gene in order to generate an optimum alignment, and you might manually edit your alignment. Manual editing is used to remove sequencing errors, correct obvious misalignments and most importantly to check start/stop codons and ensure that codon positions are correctly maintained across the alignment.

Next Steps
==========

Now that we have an alignment of each of our genes, we can bring this data together by :ref:`4. Concatenating Alignments<concat_alignments>`.

