.. _sed:

======================================
The sed command
======================================

The ``sed`` command is another tool that uses Regular Expressions, see the page on the ``grep`` command for more information on these. ``sed`` is used for performing edits to a text file. Probably the most common use of ``sed`` is to perform find-and-replace type operations, but it can also be used for many other things, in particular printing only specific lines of files.

For a more detailed introduction to sed, you might be interested in reading the `world's best introduction to sed <https://catonmat.net/worlds-best-introduction-to-sed>`_.

------------------------------------
Find-replace using sed
------------------------------------

Let's create a simple text file

.. parsed-literal::
	:class: codebg

	echo -e "lineA\\nlineB\\nlineC" > lines.txt

Let's say we want to replace "line" on each line with "row". We would use the following ``sed`` expression:

.. parsed-literal::
	:class: codebg

	sed -e "s/line/row/" lines.txt > rows.txt
	cat rows.txt

The ``-e`` option tells sed that we want to use a regular expression for editing, and the regular expression in this case takes the form ``s/find/replace/``. The ``s`` tells ``sed`` that we're doing a substitution, and the ``/`` characters delimit our search and replacement. As you can imagine, we could get much more complicated with the regular expressions used to specify what we want to find and how we want to replace it, but we won't go into this here.

Note that if you want to edit a file directly, rather than edit a file and send the edited version to standard output, you would use the ``-i`` (inplace) argument. Be careful with this: you should always test out your regular expression before running it, in case it does things you don't intend! If you have a large file, you can use ``head`` to see just the first 10 lines, then pipe this to ``sed``:

.. parsed-literal::
	:class: codebg

	head file.txt | sed -e "s/find/replace/"

This will allow you to test out your regular expression on a subset of the file. When you're happy, you can run it on the whole file in place:

.. parsed-literal::
	:class: codebg

	sed -i -e "s/find/replace/" file.txt

A final note: by default, ``sed`` replaces the first instance of your search string *per line*. If you want to replace every instance, use ``s///g`` (global).

-------------------------------------
Selecting lines from a file with sed
-------------------------------------

To print a specific line using sed, you use the ``p`` instruction. You pair this with the ``-n`` option, which does not return any lines unless explicitely told to. So, to print the 10th line of a file, you'd do:

.. parsed-literal::
	:class: codebg

	sed -n \'10p\' file.txt

To print lines 56 to 61:

.. parsed-literal::
	:class: codebg

	sed -n \'56,61p\' file.txt

To print every second line, starting with the second line, you'd do:

.. parsed-literal::
	:class: codebg

	sed -n \'2~2p\' file.txt

This last one is a handy way of extracting just the sequences from an (unwrapped) FASTA file.

