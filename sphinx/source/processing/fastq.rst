====================================
Fundamentals: FASTQ files
====================================

Let’s review a few basic points about sequence file structure and exploring these files using the command line. If you have experience working with fastq files you can move onto the :ref:`demultiplexing section<demultiplexing>`. 

Change into the directory and list its contents, showing sizes:

.. code-block:: bash

	$ cd 0_rawsequences/

	$ ls -lh

We can see how many lines in each file using the word count function, specifying we want the number of lines:

.. code-block:: bash

	$ wc -l *.fastq

The ​:samp:`*.fastq` here means we want all of the fasta files in the directory. We could replace this with a single
file name.
We would like to review the structure of these files. We could print the whole file to the terminal using the cat command, but these files are over 35000 lines. We expect them to be the same structure all through the file, so the first 10 lines should be fine. Run the following command, replacing ​file with one of the ``file`` names.


.. code-block:: bash

	$ head -n 10 ​file

You will see the fastq format comprising header, sequence and quality scores. A useful point to note is the structure of the file header, specifically that it starts with “@D00”. If the structure of this file is completely new to you, take a few minutes to read the first section on the wikipedia page on `fastq format <https://en.wikipedia.org/wiki/FASTQ_format>`_.

To get specific lines from a file, use the sed function:

.. code-block:: bash 

	$ sed -n ‘4,8p’ ​file # prints lines 4-8

* Use this to have a look at some files. If it doesn’t work - well you might have copied and pasted the command, which has formatted quotation marks. You need to type this out.

Note that the R1 and R2 files from the same library have the same read headers, apart from a 1 or 2 in the second part of the name. Reads with the same header were read from the same location on the sequencer, so they are assumed to be the forward and reverse read of the same fragment - these are called **​mate pairs​.** It’s important to ensure that both the forward and reverse read for each fragment are always kept present (“in sync”) for some future processes.

While we can divide the results of our wordcount function above by four to get the number of sequences, it is quicker to use ``​grep`` ​. This is a powerful tool that searches for text in a file using regular expressions, and we can use it to search for all the headers and return a count of them, as follows:

.. code-block:: bash

	$ grep -c "^@D00" ​file

The ​:code:`^@D00` is a regular expression - the ​^ character is a special symbol in regex meaning “the beginning of a line”. So this regex searches for lines beginning with ``​@D00`` We use more than just ``​@`` because it is also the symbol for a quality score of 31. Any sequences where the first base has a score of 31 will be counted twice - once for the header, once for the quality string, as they are two different lines starting with ``​@`` ​. Hence using multiple characters.

Like the ​wc -l function above, we can run grep on all of our files at once to get the total read numbers for each of our libraries:

.. code-block:: bash 

	$ grep -c "^@D00" *.fastq

We can see that we’re dealing with about 9000 reads per library.

* Do all the libraries have the same R1 and R2 read numbers?

You're now ready to move onto the first step of our pipeline, :ref:`demultiplexing.<demultiplexing>`