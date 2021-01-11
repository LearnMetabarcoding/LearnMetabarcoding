.. _id_using_megan:

.. role:: var

======================================
1. Classification with GenBank & MEGAN
======================================

.. toctree::
	:hidden:

	extensions/megan_settings

Introduction
============

One of the most straightforward automated ways of assigning taxonomy to OTUs is to **BLAST** the OTUs against the GenBank nucleotide database. GenBank is the largest database of publicly accessible sequence data in the world and by looking at the hits we get, we may be able to draw some conclusions about the taxonomy of a sequence. You can `search sequences online <https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome>`_, but a much more efficient way is to download a copy of GenBank to your local machine and use the **BLAST** command line software.

While we could simply look at the hits we get from a **BLAST** search to estimate taxonomy, this wouldn't be very consistent. A standardised way is to process the results using a Lowest Common Ancestor algorithm. This process looks at the taxonomy of all of the results for a single sequence and estimates what taxon is the most likely Lowest Common Ancestor for all of the results, assigning the sequence that taxon. This is implemented in the program **MEGAN**.

.. admonition:: Data and software
	:class: green
	
	The input data to this tutorial is a FASTA file of sequences that you want to classify. If you've been following along step-by-step, you can use ASVs or OTUs you produced in previous sections. Alternatively, you can use the file ``otus_greedy_0.97.fasta`` within the :ref:`sectionD archive <sectionDdata>` can be used as example data.
	
	You will also need a local copy of the GenBank nucleotide (nt) database. If you're working with your own data, you can find out how to download this `here <ftp://ftp.ncbi.nlm.nih.gov/blast/documents/blastdb.html>`_. If you are working with the example data, we have created a mini version of the nt database designed to rapidly produce results **for this dataset only**. This is in the directory ``blastdb`` within the :ref:`sectionD archive <sectionDdata>`.
	
	This tutorial uses the :ref:`BLAST<blast>` software. You should also have the software `MEGAN <https://uni-tuebingen.de/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/algorithms-in-bioinformatics/software/megan6/>`_ installed on your personal computer.

Running BLAST
=============

Running **BLAST** is fairly straightforward, although there are a lot of options, some of which are fairly obscure. Be sure to check out the `documentation <https://www.ncbi.nlm.nih.gov/books/NBK279684/#_appendices_Options_for_the_commandline_a_>`_ at some point. We will use the following **BLAST** command to search our sequences against a local copy of the GenBank nt database (see the Data and software box above for details of acquiring this database). Run this command, making sure to specify the correct path to the blastdb directory and replacing the other file names with the name of your OTU sequences and a sensible output name.

.. parsed-literal::
	
	blastn -db :var:`path/to/`\blastdb/nt -query :var:`input.fasta` -outfmt 5 -out :var:`output.xml` -evalue 0.001

This command generates a very large XML file containing the full record of all the alignments BLAST has found for our OTUs. You should transfer this to your personal computer for the next step, but to save bandwidth, let's first compress the xml using zip:

.. parsed-literal::

	zip :var:`file.xml.zip` :var:`file.xml`

Using your FTP client, or whatever file transfer method you like, transfer the zipped XML file to your computer and extract it.

Running MEGAN
=============

We will use **MEGAN** to parse the BLAST results and assign taxonomy to our OTUs. This is one of many algorithms out there for doing this - we introduce it here because it has a handy GUI interface and you’re probably bored of looking at the terminal.

Open up **MEGAN**. It usually takes a little while to open because it has to load the entire NCBI taxonomy into memory and display it. I bet you miss the efficiency of the terminal already.

**MEGAN** works through each OTU and find the location on the NCBI taxonomy tree for each GenBank sequence the OTU had a hit against. It then uses the LCA algorithm to assign taxonomy to each OTU.

Once **MEGAN** has opened and loaded the tree, you should see a very high-level cladogram of living organisms. This is the entire NCBI taxonomy. To map the OTU BLAST data onto this, you need to load the XML. Go to :menuselection:`File --> Import From BLAST`. In the Files tab of the window that appears, use the button to the right of the first box to browse to and select your XML file. **MEGAN** will automatically fill the third box. It should look something like this:

.. image:: megan_screenshot.png
	:align: center

Go to the :menuselection:`LCA Params` tab at the top. Here you will see the parameters that **MEGAN** uses when assigning taxonomy using its lowest common ancestor algorithm. For now we'll leave these as default and just press :menuselection:`Apply`. It will take a little while to process your BLAST results (longer if you have a large dataset and/or increased the number of hits returned in your **BLAST** command.

Once **MEGAN** has finished you should see a reduced version of the taxonomy tree. It may not be very detailed: at the top bar, select :menuselection:`Rank` and choose :menuselection:`Species`. 

:guilabel`Have a look at the tree. Are all the OTUs Coleoptera?`

Each circle on the tree is one or more OTUs that have been assigned to a node. The larger the circle, the more OTUs have been assigned to that node. If you click on a node, you’ll see two values. :menuselection:`Assigned` is the number of OTUs assigned to that node, :menuselection:`Summed` is the number of OTUs assigned to that node and all child nodes. If you ​right click on a node and click :menuselection:`Inspect`, you can see more details about that node and the OTU(s) assigned to it, as well as all the BLAST information. The greyed out BLAST hits are those that aren’t taken into account in the LCA analysis.

.. admonition:: Exercise
	
	You’ll notice that many OTUs have been assigned to internal nodes (i.e. not species). :menuselection:`Inspect` some of these.
	
	* Why do you think the algorithm has assigned them to internal nodes?
	* Do you think algorithm is always correct?

To output the taxonomic assignment for all of the OTUs for use in analysis, we need to select all of the nodes. You can do this by going to :menuselection:`Select --> All Nodes`. Then go to :menuselection:`File --> Export --> Text (CSV) Format`. For the :menuselection:`Choose data to export:` field, select :menuselection:`readName_to_taxonPath`, click OK and select your output location. This generates a comma-separated table with the OTU name and full NCBI taxon path of the assigned node. 

Next steps
==========

The major downside to this method is that it relies on GenBank being a) comprehensive and b) accurate. Some OTUs may be able to be classified to family or genus level if that family or genus is well represented in GenBank (for the locus we're using) and the identifications of the sequences on GenBank are both accurate and complete to the necessary taxonomic level. However, many other OTUs may not be able to be classified below the class or order level if there are insufficient close sequences available to match to, or if the available sequences are incorrectly identified or identified only to the class or order level. 

These impact of these issues can be somewhat ameliorated with careful tweaking of some of the LCA settings. If you want to experiment with different LCA settings in MEGAN, you could look at the :ref:`Extension: MEGAN LCA parameters <megan_settings>`

To deal with the accuracy issue, you could use a curated database. These are usually subsets of GenBank that have carefully checked the accuracy of the taxonomy for a subset of sequences, usually based on a specific locus. We look at how to use one of these, with a variety of different classification methods, in the next tutorial: :ref:`2. Classification with curated databases <id_curated>`.
