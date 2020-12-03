==================================
Loops in bash
==================================

Sometimes we want to run a command multiple times, for example if we're processing many files using the same tool. This is where loops become very useful, and we will use these extensively in this resource.

Loops in bash are a big topic and we're only going to cover the basics here. For more information, you could look at some other resources:

* A nice 5-minute introduction from `linuxize <https://linuxize.com/post/bash-for-loop/>`_
* A bit more of a technical introduction from `ryanstutorials <https://ryanstutorials.net/bash-scripting-tutorial/bash-loops.php>`_

-----------------------------------
For loops
-----------------------------------

We use a ``for`` loop when we have a predefined list contained in a variable. For example, say I have a directory called ``inputs`` with five fasta files in it. You could create a variable containing a list of these files as follows:

.. code-block:: bash

	$ files=$(ls inputs/)
	$ echo "$files"

Note how we list the directory, then enclose that command in ``$()``. This allows us to create the variable ``$files`` containing the output of the ``ls`` command. We can check what that variable contains by ``echo`` ing it.

Now we run a simple ``for`` loop where we run ``sed`` on each file. The sed expression adds ";tag;" to the end of each header line (i.e. lines beginning with ``>``).

.. code-block:: bash

	$ for f in $files \
	> do \
	>	sed -i -e "/^>/,s/$/;tag;/" $f \
	> done

The ``for`` loop essentially says "for each item in ``$files``, call that item ``f`` and do the following to it". The ``do`` and ``done`` terms surround the expression(s) to be run within the loop. We can also run this in a more compact form:

.. code-block:: bash

	$ for f in $files; do sed -i -e "/^>/,s/$/;tag;/ $f; done

See how we use ``;`` to separate expressions in a single line.

-------------------------------------
While read loops
-------------------------------------

A ``while`` loop is largely the same as a ``for`` loop. If you looked at the resources above, you'll see the main difference is that it runs continuously for as long as a condition is true. For our purposes, we're going to harness this to use it to parse files, applying an expression to each line of a file. For example, let's assume we have a list of sequence indices in a file:

.. code-block:: bash

	$ echo -e "ATCGCA\nTAACGA\nTACAGA\nATTCAT" > indices.txt

Say as above we have a directory called ``inputs`` with five fasta files in it, and we want to search all files for each of these indices, returning a count of the times they were matched. This is the command we used

.. code-block:: bash

	$ while read i \
	> do \
	> 	grep -c "$i" inputs/*.fasta
	> done < indices.txt

Again, there's a one-liner format.

.. code-block:: bash

	$ while read i; do grep -c "$i" inputs/*.fasta; done < indices.txt

Notice that we use the ``<`` symbol to set indices.txt as the standard input. As the ``while read`` syntax operates on the standard input, we can also use ``while`` loops on data we've piped from previous commands. Imagine we wanted to add a ``T`` base to the end of every input index before we search them: one way of doing this is as follows:

.. code-block:: bash

	$ sed -e "s/$/T/" indices.txt | while read i; do grep -c "$i" inputs/*.fasta; done



