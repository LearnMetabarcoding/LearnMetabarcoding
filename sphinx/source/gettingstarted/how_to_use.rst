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

Commands and code
-----------------

Once the topic and software is introduced, the tutorial will suggest running a command to perform a bioinformatic step. Commands are printed like this:

.. parsed-literal::
	
	echo "hello world"
	

You would enter everything in this box. You would then press Enter (Return) to run the command. If this is very new to you, you might want to check out the :ref:`UNIX command line introduction <unix_cli>`, which has more information.

We will frequently suggest commands that contain placeholder values that need to be edited before running. The following command has placeholder values:

.. parsed-literal::
	
	head -n :var:`N` sequences.fasta > :var:`output.txt`
	

Before you run this command, you would replace ``N`` with a number and ``output.txt`` with the file path of a specific file. Don't worry, we'll try to make it really clear what file you should use and how to figure out what number to use. Placeholder file names will often be ``input`` or ``output``, but sometimes we'll use different names, generally where there is more than one input. Placeholders will always be formatted to make it clear what should be changed, and they should always be changed before running the command.

As in the previous paragraph, we may often refer to code within text, such as this: ``head``. Generally this is a reference to a command or part of a command, and we don't necessarily expect you to run exactly the code written as is. For example, we might refer to a specific argument, such as ``-n``, with this special code formatting to make clear we're talking about part of a command. Sometimes, we might suggest you use a common Linux function, such as ``head``, ``more``, ``grep``, etc, by referring to it like this rather than making a code box, suggesting that you figure out the necessary command yourself. See :ref:`here <basic_unix>` for some more information about Linux commands.

Exercises
---------

As part of a tutorial, we will suggest you run a command, design a command yourself, or ask you questions about the data to help guide your learning. Suggestions of something you should do be formatted like this: :guilabel:`Run this command:`, or placed in an exercise box like the below.

.. admonition:: Exercise
	
	An exercise box might ask a question about the output of a command you've just run, perhaps suggesting you using a :ref:`basic Linux function <basic_unix>` such as ``head`` to interrogate the output data somehow.
	
	Alternatively it might suggest you read a helpfile or manual to design a command, sometimes suggesting you use a certain argument such as ``--a``. 
	
	You might also find that an exercise box contains a complete command that we suggest you run, such as:
	.. parsed-literal::
		
		sed -e "/^>/,s/-//g" :var:`input.fasta` > :var:`output.fasta`
		

Solutions
---------

When we ask you to figure out how to design a command yourself, because we're nice people we'll give you the solution in a hidden box like the below:

.. admonition:: Solution
	:class: toggle
	
	.. parsed-literal::
		
		grep -c "^>" :var:`input.fasta`
	

Next steps
----------

Most tutorials will end with a "Next steps section" that summarises the data you've generated in that tutorial and gives you some options of some tutorials that cover topics building on this data.

You will also see :guilabel:`Previous` and :guilabel:`Next` buttons at the end of each page. These work through the pages exactly in the order given in the navigation panel on the left, and while the :guilabel:`Next` page will often be our suggested next step, they don't take account of other options. They will also send you to "Fundamentals" or "Extension" pages where these are present, but these are never required for moving on through the pipeline.
