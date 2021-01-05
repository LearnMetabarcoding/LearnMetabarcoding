.. _how_to_use:

.. role:: var

==========================
How to use these resources
==========================

Each page in these resources forms a short, standalone tutorial on a specific aspect of metabarcoding bioinformatics. Some tutorials will assume you have completed prior tutorials to generate some required data and/or to build upon earlier concepts. The tutorials are grouped into five sections. 

Sections
========

Each section covers a broad topic in metabarcoding bioinformatics comprising a set of tutorials that can be followed one after the other to develop your understanding and gain a broad introduction and set of skills in metabarcoding bioinformatics. The first two sections each consist of a strongly linear set of tutorials, with each tutorial processing the data output from the previous and following these in order is strongly recommended. The latter three sections are broader, giving a range of alternative approaches to key topics including OTU delimitation and OTU classification. While we still recommend you follow through the tutorials in the order shown in the navigation bar to the left, in the later sections you can more freely skip tutorials or try them in a different order as appropriate.

The tutorials
=============

Most tutorials cover a specific aspect, and we recommend for a complete picture you follow through each of these steps. Some tutorials, with "Foundation" at the beginning of the name, are designed for complete beginners, and help to understand basic topics - these can always be skipped. Other tutorials, with "Extension" at the beginning of the name, provide a deeper exploration of a particular topic, but can be skipped without missing any core understanding.

Following along
===============

Introduction
------------

Each tutorial will start with an introduction to the topic. In most cases, this will be followed by a box like this:

.. admonition:: Data and software
	:class: green
	
	This box will tell you what data you will need to perform the steps detailed in this tutorial, and the software you will need installed.

The name of software or software packages will always be in **bold**.

Commands and code
-----------------

Once the topic and software is introduced, the tutorial will suggest running a command to perform a bioinformatic step. Commands are printed like this:

.. parsed-literal::
	
	echo "hello world"
	

Whenever you see this, it is a command that we suggest you run and to do so you would type everything in this box into your terminal, then press Enter (Return). If this is very new to you, you might want to check out the :ref:`UNIX command line introduction <unix_cli>`, which has more information.

Sometimes in these resources we will ask you to run a command that is quite long, and to help you read it easily we will present the command broken over multiple lines. It will look like this:

.. parsed-literal::

	echo \\
	"hello world"

To enter this in the command prompt, we type the first line and then press Enter after typing the ``\`` symbol. This symbol at the end of the command tells the shell that we want to continue typing the same command on the next line. The prompt will change to a ``>``.

We will frequently suggest commands that contain placeholder values that need to be edited before running. The following command has placeholder values:

.. parsed-literal::
	
	head -n :var:`N` sequences.fasta > :var:`output.fasta`
	

The ``N`` and the ``output.fasta`` of this command are formatted differently to show that these are placeholders, and so before you run this command, you **must** replace ``N`` with a number and ``output.fasta`` with the file path of a specific file. So you might decide to show ``10`` lines and call your output ``firstten.fasta``. So you would actually run:

.. parsed-literal::
	
	head -n 10 sequences.fasta > firstten.fasta
	

Don't worry, we'll try to make it really clear what file you should use and how to figure out what number to use. Placeholder file names will often be ``input`` or ``output``, but sometimes we'll use different names, generally where there is more than one input.

As we just did, we may often refer to code within text, such as this: ``head``. Generally this is a reference to a command or part of a command, and we don't necessarily expect you to run exactly the code written as is. For example, we might refer to a specific argument, such as ``-n``, with this special code formatting to make clear we're talking about part of a command. Sometimes, we might suggest you use a common Linux function, such as ``head``, ``more``, ``grep``, etc, by referring to it like this rather than making a code box, suggesting that you figure out the necessary command yourself. See :ref:`here <basic_unix>` for some more information about Linux commands. 

We will also refer to files and directories on your bioinformatics machine using this notation, such as ``Lib1_R1.fastq`` or ``0_rawsequences/``.

Exercises
---------

As part of a tutorial, we will suggest you design a command yourself, or ask you questions about the data to help guide your learning. Short exercises will be formatted like this: :guilabel:`How many lines does the file have?`, and longer ones placed in a box like the below.

.. admonition:: Exercise
	
	* An exercise box might ask a question about the output of a command you've just run, perhaps suggesting you using a :ref:`basic Linux function <basic_unix>` such as ``head`` to interrogate the output data somehow.
	* Alternatively it might suggest you read a helpfile or manual to design a command, sometimes suggesting you use a certain argument such as ``--a``. 
	* You might also find that an exercise box contains a complete command that we suggest you run, such as:
	
	.. parsed-literal::
		
		sed -e "/^>/,s/-//g" :var:`input.fasta` > :var:`output.fasta`
		

Solutions
---------

When we ask you to figure out how to design a command yourself, because we're nice people we'll usually give you the solution in a hidden box like the below:

.. admonition:: Solution
	:class: toggle
	
	.. parsed-literal::
		
		grep -c "^>" :var:`input.fasta`
	

Next steps
----------

Most tutorials will end with a "Next steps" paragraph that summarises the data you've generated in that tutorial and gives you some options of some tutorials that cover topics building on this data.

You will also see :guilabel:`Previous` and :guilabel:`Next` buttons at the end of each page. These work through the pages exactly in the order given in the navigation panel on the left, and while the :guilabel:`Next` page will often be our suggested next step, they don't take account of other options. They will also send you to "Fundamentals" or "Extension" pages where these are present, but these are never required for moving on through the course.
