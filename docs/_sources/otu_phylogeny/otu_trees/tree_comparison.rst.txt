.. _otu_comparison_tree:

==================================
Extension: Comparing OTU methods
==================================

Now that we’ve learned a quick method of building trees, we can use this knowledge to compare our OTUs from different methods.

First, let’s create a folder for this little side project, just to be organised

Second, we need to create copies of our OTU files with names added to the headers in order to differentiate OTUs from different methods. For each OTU file, run the following command, replacing method with a description of the method used to create OTUS, e.g. "greedy97pc" (text or numbers only, no spaces or other characters!):

.. code-block:: bash 

	$ sed -e "s/\(^>.*$\)/\1method/" file > newfolder/file

Next, concatenate these OTU files into one file - you’ll need to be inside your new folder for this:

.. code-block:: bash 

	$ cat * > allotus.fasta

You can now run FastTree on this file and look at how different OTUs match up.
