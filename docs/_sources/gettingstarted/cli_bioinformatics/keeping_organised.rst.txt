.. _keeping_organised:

===========================
Keeping your data organised
===========================

Introduction
============

Command line bioinformatics has a much more restricted interface to your data and directory tree, and learning all of the different software and commands can take so much energy that keeping organised gets forgotten. However, lots of different files get created as you work through a bioinformatic pipeline, and keeping these organised is very very important. This is most crucial when you want to backtrack in your pipeline and try an alternative approach, or you need to track down the cause of an error or a major shift in your data structure.

To this end, we strongly recommend two useful tips:
1. Keep a very clear and consistent naming convention and directory tree
2. Keep a well organised record of the final commands you use

Naming conventions
==================

If you make sure your files are clearly named using a consistent convention, you will save yourself so much time. It might be easy to keep track of an arbitrary naming system during a day's work, but come back to it after the weekend or when your advisor suggests doing something differently a month later and you'll be lost! 

There are lots of ways of naming directories and files, this is our method which isn't necessarily the best but works well for use. Hopefully this will help you think of the best method for you. Remember that Linux always sorts files alphabetically when you list the contents of a directory.

Our method
----------

Each pipeline is in its own directory, named clearly with the pipeline name and a date (in ISO format, i.e. 2020-12-25, for easier sorting)

Each pipeline directory contains a ``commands.txt file`` that lists the commands used to generate the files in that directory (see below)

When a step draws on or creates multiple files that should be treated as a group, these are always in their own directory and that directory is treated as if it's a complete file for naming purposes. The files within successive directories never change their names unless they are split up or merged together.

Each file or directory of files is named using a serial number at the beginning of the file, which increments for each step that modifies the composition or format of the data at that step. 

So, for example, the starting example data is a set of fastq files with the name of the sequencing library. These are placed in a directory called ``0_rawsequences/``. When these are demultiplexed, we call the output directory ``1_demux/`` to show that this is the next set of data in order, and that the step used to produce them was demultiplexing.

Note that ``11`` comes before ``2`` in alphabetical sorting, so if you expect to have more than 10 stages you may want to use ``00``, ``01``, etc for successive stages, or use the first number for major versions and the second number for minor versions.

Command records
===============

As you work through a bioinformatics pipeline, you will try out lots of different commands and in between major steps perhaps carry out some reorganisation of your data or renaming. It is really useful to keep a record of your "final" commands for each step, absent any test runs, so that in theory you can completely rerun your entire pipeline from the beginning just by copy-and-pasting your list of "final" commands. This is really helpful to record your methodology, and to easily implement tweaks or changes to your pipeline - you can simply create a new commands file, create a new directory for the altered pipeline, copy across your starting data, then run your altered commands.


