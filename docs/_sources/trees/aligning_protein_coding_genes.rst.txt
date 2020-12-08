.. _aligning:

======================================
3) Aligning protein coding genes
======================================

The sequences for each gene need to be aligned so that comparable regions are lined up. In phylogenetic terms, this means we need to ensure that the positions used for tree inference are homologous.

We will do a quick alignment using MAFFT for each gene, using the FFT-NS-2 method. First, make a directory to store your aligned genes.

Run the following command, making sure to replace *raw* with the name of the directory you extracted your genes into in the last step and ​new​ with the name of your new directory:

.. code-block:: bash 

	$ for f in ​dir​/*; do mafft --thread 1 --retree 2 --maxiterate 0 $f >​ new/​${f#*/}; done

While this is running, have a look at the `manual for mafft <https://mafft.cbrc.jp/alignment/software/manual/manual.html>`_. Have a look at the different methods for alignment and think about what might be best for these genes [#f1]_.

Once it’s complete, pick one of your alignments and download it to your computer. Use an alignment viewer, such as AliView, to open the alignment.

* How does it look? Is the reading frame maintained?

* Are all of the start and stop codons present and complete for all sequences, are they at the beginning or end of the sequences, and are they aligned properly? What might it mean if they aren’t?
 
* Are there any sequences that look very out of place. If there were, what could this mean?

Sequence alignment is a big topic, beyond the scope of this course. There is a wide range of software out there: two other commonly-used alignment tools are MUSCLE and CLUSTAL. We find MAFFT to be very versatile and fast for all sorts of alignment tasks. If doing this with your own data, you would generally try to optimise the gap opening parameters for each gene in order to generate an optimum alignment, and you might manually edit your alignment. Manual editing is used to remove sequencing errors, correct obvious misalignments and most importantly to check start/stop codons and ensure that codon positions are correctly maintained across the alignment.

Now we can :ref:`concatenate our alignments!<concat_alignments>`

.. rubric:: Footnotes

.. [#f1] We generally would use a global alignment, usually the GINSI method, optimising gap opening and extension penalties for each gene to reduce gap formation. Sometimes the LINSI method works better on poorly-aligning genes.