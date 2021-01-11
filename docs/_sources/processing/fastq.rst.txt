.. _fastq:

.. role:: comment

.. role:: var

=========================
Fundamentals: FASTQ files
=========================

Introduction
============

This page reviews a few basic points about sequence file structure and how to explore these files using the command line. If you have experience working with FASTQ files you may want to move straight onto the :ref:`demultiplexing section<demultiplexing>`. 

.. admonition:: Data and software
	:class: green

	This tutorial works with FASTQ format sequence data that contains indices at the beginning of the reads. The example data for this can be found in the ``0_rawsequences`` directory within the :ref:`sectionA archive<sectionAdata>`. If you haven't already, you should copy this directory over to your working directory as follows:
	
	.. parsed-literal::
		:class: codebg
	
		cp -r :var:`path/to`\/exampledata/sectionA/0_rawsequences/ ./

Exploring FASTQ files
=====================

Run the following to change into the directory containing the starting data and list its contents, showing sizes.

.. parsed-literal::
	:class: codebg

	cd 0_rawsequences/
	ls -lh

We can see how many lines in each file using the word count ``wc`` function, specifying we want the number of lines:

.. parsed-literal::
	:class: codebg

	wc -l \*.fastq

The :code:`*.fastq` here means we want all of the files ending in ``.fastq`` in the directory. We could replace this with a single file name if we just wanted to count the lines of a single file. Replace ``file`` in the following command with the name of a single FASTQ file.

.. parsed-literal::
	:class: codebg

	head -n 10 :var:`file`

You will see the FASTQ format comprising header, sequence and quality scores. A useful point to note is the structure of the file header, specifically that it starts with ``@D00``. If the structure of this file is completely new to you, take a few minutes to read the first section on the `FASTQ wikipedia page <https://en.wikipedia.org/wiki/FASTQ_format>`_.

To get specific lines from a file, use the ``sed`` function:

.. parsed-literal::
	:class: codebg

	sed -n '4,8p' :var:`​file`     :comment:`# prints lines 4-8`

:guilabel:`Use this to have a look at some different files`

Note that the R1 and R2 files from the same library have the same read headers, apart from a 1 or 2 in the second part of the name. Reads with the same header were read from the same location on the sequencer, so they are assumed to be the forward and reverse read of the same fragment - these are called **​mate pairs**. It’s important to ensure that both the forward and reverse read for each fragment are always kept present and in the same relative location in the paired files ("in sync") for some future processes.

We can use the ``grep -c`` function to count the number of sequences in a file (again, replace file with the name of one of the files):

.. parsed-literal::
	:class: codebg

	grep -c "^\@D00" :var:`file`

If you want to learn more about ``grep``, see :ref:`here<grep>`.

Like the ``​wc -l`` function above, we can run ``grep`` on all of our files at once to get the total read numbers for each of our libraries:

.. parsed-literal::
	:class: codebg

	grep -c "^\@D00" \*.fastq

We can see that we're dealing with about 10,000 - 12,000 reads per library.

.. admonition:: Exercise

	* Do all the libraries have the same R1 and R2 read numbers?
