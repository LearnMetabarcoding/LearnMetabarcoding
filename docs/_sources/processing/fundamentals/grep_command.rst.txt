.. _grep_command:

=============================
Fundamentals: Grep command 
=============================

We can use ``grep`` to illustrate the location of these indices on the sequences. We take the output of the ``head`` command (from the previous section) to show only the first three sequences in a file, send this to the next function using the pipe (​|​) command. The next function is ``grep`` ​, which we use to search for an index sequence using regex. The ``|$`` at the end of the regex means “or the end of the line” - we use this to print every line, but only highlight the parts of interest.

.. code-block:: bash 

	$ head -n 12 ​file​ | grep -E "​INDEX​|$"

E.g.

.. code-block:: bash 

	$ head -n 12 Lib4_R1.fastq | grep -E "AACACC|$"

We’re going to be seeing a lot of pipes, so make sure you understand what they mean. Google “linux pipe tutorial” if you don’t understand.
