.. _grep:

.. role:: var

================
The grep command
================

The ``grep`` command is a very powerful tool for searching and subsetting a text file. The ``grep`` command performs searching using a standardised search language called Regular Expressions, or regex. Regular expressions are short code expressions that detail how to search for some text, generally in order to include varying or unknown sections of text.

.. admonition:: Note
	:class: green
	
	Learning Regular Expressions in detail is beyond the scope of these resources, but there are plenty of great tutorials on the web.
	
	* `RegexOne <https://regexone.com/>`_ provides a great interactive tutorial for learning the basics of Regular Expressions
	* `regular-expressions.info <https://www.regular-expressions.info/>`_ is a good reference site to look up particular expressions
	* `regex101.com <https://regex101.com/>`_ is a really handy tool to test your RegEx

Here we'll cover some basic ways we can use ``grep`` to help us with bioinformatics. There are two important facts to remember about how ``grep`` operates by default:

* ``grep`` searches line by line for a match to the search term
* any lines that match the term are returned

.. admonition:: Data
	:class: green
	
	If you want some FASTQ files to test the below commands on, you can use any of the files in the ``0_rawsequences/`` directory of the :ref:`sectionA archive <sectionAdata>`.

Finding a sequence motif
========================

We can use grep to find instances of a particular sequence in a sequence file. For example, we can search these files for a particular index sequence, e.g. ``AACACC``. Remember, replace ``file.fastq`` with the name of a FASTQ file.

.. parsed-literal::
	:class: codebg

	grep "AACACC" :var:`file.fastq`

This will print lots and lots of lines, because this is a very common motif. This is too much to handle, so let's instead just count the number of lines that have a match:

.. parsed-literal::
	:class: codebg

	grep -c "AACACC" :var:`file.fastq`

In this specific case, this index is used for demultiplexing, so we might want to review some sequences to check that it's in the right place. We'll just look at the first three sequences (first 12 lines) using the ``head`` command, then send that to grep. We're going to add ``|$`` to our regular expression. ``|`` in regular expressions means "or", and ``$`` means "the end of a line". So we're searching for either our sequence of interest, or the end of a line. This means that every line will match (since every line ends), but only our sequenc of interest will be highlighted. The ``-E`` tells grep to use extended regular expressions, which is needed to make this search work.

.. parsed-literal::
	:class: codebg

	head -n 12 file.fastq | grep -E "AACACC|$"

Note that the ``|`` between the head and grep commands means that the output of the head command is being piped (sent) to the input of the grep command. This is a completely different meaning to the use of ``|`` as "or" in the regular expression.

Counting sequences
==================

We saw the ``-c`` option earlier - this is really useful for counting up the number of sequences in a FASTA or FASTQ file. This is because the structure of these files is very predictable. Each sequence will have one and only one header line, and this line will start with ``>`` for FASTA files and ``@`` for FASTQ files. So for FASTA files, we can count the number of sequences by counting the number of lines that start with ``>``:

.. parsed-literal::
	:class: codebg

	grep -c "^>" :var:`file.fasta`

The ``^`` symbol means "the start of a line". So the regex ``^>`` means "the start of a line immediately followed by ``>``.

For FASTQ files it's a little more tricky, because ``@`` is also a symbol used to denote a base quality score, and it's possible that the first base of a sequence has this score. So if we just searched for the number of lines starting with ``@``, we'd risk overestimating because we'd be counting all of the header lines *and* all of the quality score lines starting with ``@``. However, if the sequences you're working with are sequence reads, it's likely that they have very similar headers, because the sequence matchine has named them. Check this by looking at the first 20 lines of a FASTQ file: you'll see that they probably all start with the same string, often a sequence machine identifier code.

.. parsed-literal::
	:class: codebg

	head -20 :var:`file.fastq`

You can then add this to the regular expression to search more accurately. For example, say our sequence headers all start with ``D00``

.. parsed-literal::
	:class: codebg

	grep -c "^@D00"

Note that this isn't infallable - with millions of reads, it's possible that you might have one that has a quality score starting with ``@D00`` - all of these characters are quality score values. If you need to be 100% certain, it's better to use a tool that explicitely parses FASTQ files.
