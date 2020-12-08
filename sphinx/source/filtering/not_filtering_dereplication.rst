.. _dereplication:

==========================================
2) Not Filtering: Dereplication
==========================================

Now that we’re down to just sequences, we can compress our dataset somewhat. This is because we should have many duplicate reads in this concatenated file due to PCR. It is important to retain our current file, because it keeps track of which reads came from which sequence, but now we are gradually preparing for finding the OTUs, which is a whole-dataset problem.

The subsequent steps are much faster if we remove these duplicates; we will record in the file headers how many copies there are of each sequence for later use.

VSEARCH has a dereplication function, which we will use here:

.. code-block:: bash 

	$ vsearch --derep_fulllength ​in.fasta​ --output ​out.fasta​ --sizeout --relabel uniq

* Use ``head`` to see how the sequence headers are formatted.

* Use ``grep`` to count up how many unique sequences we have.

We renamed these because the original names became meaningless once we dereplicated, so we might as well save space. Very importantly, we’ve included a “size” annotation that specifies how many copies each sequence had in the original dataset.

Make sure to keep the input file with all unique sequences! The dereplicated file has lost all of the information linking sequences to samples, but this remains in the input file, and we will use this much later. **For now we will use the dereplicated file for the next step​.** 
Now we can move onto the next step, :ref:`indel filtering.<indel_filtering>`
