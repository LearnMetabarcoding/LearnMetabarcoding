=================================
Cheatsheet of useful commands
=================================

Here are some useful bash commands for doing command-line bioinformatics. These draw upon some of the basics described in other pages in this section.

---------------------------------
Unwrapping FASTA files
---------------------------------

A lot of software outputs wrapped FASTA files, where sequence lines are truncated at a certain number of characters and continued on the following line, like this:

.. parsed-literal::
	
	>sequence1
	ATACGACGATAAGCAGACTAGACATATT
	CGCCCGATTGACCG
	>sequence2
	ACGCGCTGAAAAGCAGACTTTTTACACG
	CGCGTAAACAACGC

This can be really annoying for quick and easy command line bash bioinformatics, because the number of lines for each sequence is unpredictable. The following perl one-liner, from `this biostars answer <https://www.biostars.org/p/9262/#118460>`_, easily unwraps a fasta file:

.. parsed-literal::
	
	perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' input.fasta > output.fasta

This command is great because it can easily be used within a pipe.

---------------------------------
Replacing bases
---------------------------------

You may sometimes have sequence data that isn't quite appropriate for a piece of software, for example you have an alignment but the software won't accept it, or you have ambiguity codes but the software only accepts A, T, C, G or N. You can use ``sed`` to remove or replace all offending bases, but you must be careful only to do so on non-header lines - you don't want to edit your sequence headers by accident! We do this by adding a line specifier, ``/^[^>]/,`` before the substitution command. This specifies that we want to only operate on lines that do not start with ``>``.

Degap an alignment (i.e. de-align):

.. parsed-literal::

	sed -e "/^[^>]/,s/-//g" input.fasta > output.fasta

Replace any ambiguities with ``N``:

.. parsed-literal::

	sed -e "/^[^>]/,s/[YRWSKMDVHBX]/N/g" input.fasta > output.fasta

---------------------------------
Getting sequence lengths
---------------------------------

Here we delete header lines, delete gaps then count how many characters each line has. 

.. parsed-literal::

	sed -e "/^>/d" -e "s/-//g" input.fasta | awk '{ print length }' > lengths.txt

The FASTA file must be unwrapped - if it's not, you could add the perl one-liner above to the beginning of the pipe.

.. parsed-literal::

	perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' input.fasta | 
	sed -e "/^>/d" -e "s/-//g" | awk '{ print length }' > lengths.txt

What to with these lengths? Well, we can get a rough idea of the distribution by counting the number of each unique length:

.. parsed-literal::

	sed -e "/^>/d" -e "s/-//g" input.fasta | 
	awk '{ print length }' | 
	sort | uniq -c | sort -hr

Or we could use an R one-liner to count the mean and standard deviation

.. parsed-literal::

	sed -e "/^>/d" -e "s/-//g" input.fasta | 
	awk '{ print length }' | 
	Rscript -e 'd<-scan("stdin", quiet=TRUE);print(c(round(mean(d),0), round(100 * mean(c(mean(d)-min(d),max(d)-mean(d)))/mean(d), 1)));'

---------------------------------
Generating a random FASTA
---------------------------------

Sometimes we want some dummy data to test on. This command makes 30 sequences, each 300 bases long:

.. parsed-literal::

	paste -d '\n' <(for i in {01..30}; do echo ">seq$i"; done) <( cat /dev/urandom | tr -dc 'ATCG' | fold -w 300 | head -n 30 )

---------------------------------
Get the headers of a FASTA
---------------------------------

There are two ways to do this:

.. parsed-literal::

	grep "^>" input.fasta | sed -e "s/>//" > headers.txt
	grep -oP "(?<=^>).*$" > headers.txt

The second one uses a fancy Regular Expression term called a "positive lookbehind".

---------------------------------
Extract information from tables
---------------------------------

Say I have a table, data.csv, that looks like this:

.. parsed-literal::

	seq1,Coleoptera,425
	seq2,Diptera,256
	seq3,Hemiptera,786

If I wanted to find the sequence names that are Coleoptera, I could do this:

.. parsed-literal::

	grep "Coleoptera" data.csv | cut -d, -f1 > headers.txt

Or the sequences where column three is greater than 500:

.. parsed-literal::

	awk -F',' ' $3 > 500 ' data.csv | cut -d, -f1 > headers.txt

The functions ``awk`` or ``grep`` do the searching, while ``cut`` extracts the first column from the result. If your table is tab-delimited, you can skip the ``-F`` argument in ``awk`` and the ``-d`` argument in ``cut``, tab-delimited is the default for both.

--------------------------------
Extract sequence by header
--------------------------------

Say we have a list of sequence headers in headers.txt and we want only those sequences from a larger (unwrapped!) fasta called sequences.fasta.

.. parsed-literal::

	grep --no-group-separator -A1 -f -F headers.txt sequences.fasta > output.fasta

By default grep prints only lines that match, the ``-A1`` adds one line after each match as well (this is why it must be unwrapped!). The ``-f`` means the search looks for fixed text strings, not RegEx, and the ``-F`` looks for a list of search terms supplied in a file.

We can of course pipe this with some of our previous examples. Note that the standard input to ``grep`` is the file to be searched, so we need to redirect standard input elsewhere:

.. parsed-literal::

	grep "Coleoptera" data.csv | cut -d, -f1 | grep --no-group-separator -A1 -f -F /dev/stdin sequences.fasta > output.fasta

---------------------------------
Aliasing frequent commands
---------------------------------

Some commands I use a lot, but are a little fiddly to write, so I save them under an `alias <https://tldp.org/LDP/abs/html/aliases.html>`_ to my bash profile. This is like a shortcut to a command. A prime candidate for this is the FASTA unwrapping perl one-liner. 

.. parsed-literal::

	echo "alias unwrap=\"perl -pe '$. > 1 and /^>/ ? print \"\n\" : chomp'\"" >> ~/.bashrc

The ``>>`` is very important: don't use a single ``>``. You might need to change ``.bashrc`` to ``.bash_profile`` or something else depending on your system.
