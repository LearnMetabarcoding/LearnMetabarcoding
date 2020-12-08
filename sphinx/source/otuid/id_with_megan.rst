.. _id_using_megan:

==========================================
2) Identification using GenBank and MEGAN
==========================================

.. toctree::
	:hidden:

	extensions/megan_settings

The most straightforward automated way of assigning taxonomy to OTUs is to BLAST the OTUs against the GenBank nucleotide database. The server has a subset of this database, and the blast executables.

Select one of your OTU files and blast it against nt using the following command:

.. code-block:: bash 
	
	$ blastn -db /AMM/blastdb/nt -query ​in.fasta​ -outfmt 5 -out ​out.xml​ -evalue 0.001

This command generates a very large XML file containing the full record of all the alignments BLAST has found for our OTUs. We need to transfer this to our computer for the next step, but to save bandwidth, let’s first compress the xml using zip:

.. code-block:: bash

	$ zip ​out.xml.zip in.xml

Using your FTP client, or whatever file transfer method you like, transfer the zipped XML file to your computer and extract it.

We will use the software MEGAN to parse the BLAST results and assign taxonomy to our OTUs. This is one of many algorithms out there for doing this - we introduce it here because it has a handy GUI interface and you’re probably bored of looking at the terminal.

Open up MEGAN. It usually takes a little while to open because it has to load the entire NCBI taxonomy into memory and display it. I bet you miss the efficiency of the terminal already.

MEGAN works through each OTU and find the location on the NCBI taxonomy tree for each GenBank sequence the OTU had a hit against. It then uses a Lowest Common Ancestor algorithm to estimate the most appropriate location on the tree for an OTU, and assigns the OTU the appropriate taxonomy.

Once MEGAN has opened and loaded the tree, you should see a very high-level cladogram of living organisms. This is the entire NCBI taxonomy. To map the OTU BLAST data onto this, you need to load the XML. Go to ​File > Import From BLAST​. In the Files tab of the window that appears, use the button to the right of the first box to browse to and select your XML file. MEGAN will automatically fill the third box. It should look something like this:

.. image:: megan_screenshot.png
	:align: center

Go to the ​LCA Params tab at the top. Here you will see the parameters that MEGAN uses when assigning taxonomy using its lowest common ancestor algorithm. For now we’ll leave these as default and just press Apply​.

Once MEGAN has finished you should see a reduced version of the taxonomy tree. It may not be very detailed: at the top bar, select Rank and choose Species. Have a look at the tree.

* Are all the OTUs Coleoptera?

Each circle on the tree is one or more OTUs that have been assigned to a node. The larger the circle, the more OTUs have been assigned to that node. If you click on a node, you’ll see two values. ​Assigned is the number of OTUs assigned to that node, ​Summed is the number of OTUs assigned to that node and all child nodes. If you ​right click on a node and click ​Inspect​, you can see more details about that node and the OTU(s) assigned to it, as well as all the BLAST information. The greyed out BLAST hits are those that aren’t taken into account in the LCA analysis.

You’ll notice that many OTUs have been assigned to internal nodes. Inspect some of these.

* Why do you think the algorithm has assigned them to internal nodes?

* Do you think algorithm is always correct?

To output the taxonomic assignment for all of the OTUs for use in analysis, we need to select all of the nodes. You can do this by going to ​Select > All Nodes​. Then go to ​File > Export > Text (CSV) Format​. For the Choose data to export: field, select ​readName_to_taxonPath​, click OK and select your output location. This generates a comma-separated table with the OTU name and full NCBI taxon path of the assigned node.

Use your FTP client to send this file to your directory on the server. We’ll come back to it later.

Here we have gone with the default settings on MEGAN. To learn how we can edit these, look at this :ref:`extension task<megan_settings>`
Alternatively, head over to the next section on :ref:`identifiction using curated databases<id_curated>`.