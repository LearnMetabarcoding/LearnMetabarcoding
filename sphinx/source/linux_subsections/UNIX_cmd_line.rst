======================================
UNIX command line
======================================

--------------------------------
The command prompt
--------------------------------

Whether you are using SSH to access a remote linux server, using Terminal on a Mac or Windows Linux subsystem, you will be presented with a window of text awaiting your command. Depending on the computer and how it is configured, this exact nature of the promt will vary, but most commonly it will say your username, machine name and/or current directory, followed by a ``$`` sign, like this:

.. code-block:: bash

	user@server:~/file/path$

When you see this ``$`` sign, this means the shell is expecting a new command. We will emulate this in the instructions in this resource, with any commands we suggest you run looking like this:

.. code-block:: bash

	$ echo "hello world"

You would enter everything *after* the ``$`, but never the ``$`` itself. You would then press Enter (Return) to run the command. In this case, it would print the text `hello world`` and then the instruction would finish, returning to the prompt.

If your command prompt is ever a different symbol, such as ``>``, this probably means that the shell is waiting for you to finish a command you've previously entered. This functionality allows you to write commands over multiple lines if they're very long. However, it's easy to accidentally enter this mode if you fail to close a parenthesis (``()`) or quotation marks ``"`` in a command, then try to run it.

Try running the following:

.. code-block:: bash
 	
     $ echo "hello

You should be met with a ``>`` symbol. Finish the command by typing ``world"`` and pressing Enter.

Sometimes in these resources we will ask you to run a command that is quite long, and to help you read it easily we will present the command broken over multiple lines. It will look like this:

.. code-block:: bash

	$ echo \
	> "hello world"

To enter this in the command prompt, we type the first line (excluding the ``$``) and then press Enter after typing the ``\`` symbol. This symbol at the end of the command tells the shell that we want to continue typing the same command on the next line. The prompt will change to a ``>`. We then type the second line, *excluding the* ``>`` *symbol*. 

Finally, the shell will ignore anything on a line after the first ``#`` symbol it encounters. This is to allow for comments, and these resources will sometimes use this to comment lines of code. For example, you could type everything after the ``$`` symbol of the following command into the terminal and run it:

.. code-block::bash

	$ echo "hello world"  # prints "hello world"

The output would be identical to the first command on this page.

.. note:: We suggest that the best way to learn is to type out the commands as they are shown in these resources. This might cause you more errors, but it gives you a chance to learn from them. If you copy and paste, you should do so line by line for multiline commands, in order to ensure that you always remove the ``$`` or ``>`` at the beginning of any lines.

--------------------------------
Working directories and paths
--------------------------------

When you use a graphical file explorer, like Explorer on Windows or Finder on Mac, you are always in a directory (folder), and can move between directories. It's exactly the same on the command line, at any point in time you are always within some directory or another. The directory you're currently in is known as the *working directory*, and just like with a graphical explorer you can easily move to a different *working directory* using the change directory ``cd`` command. 

Unless you say otherwise, any command you run will look for any files you specify within your current working directory, and output any files you generate into the current working directory. To say otherwise, you specify the *path* to the file. This is simply giving an address to the terminal for it to find the file you want within the directory structure. A path can be relative (directions to the location relative to the current working directory) or absolute (directions to the location relative to the root of the filesystem - the root is like the master parent directory which contains everything else in the computer).

You can see examples of these commands on the :ref:`basic UNIX commands<basic_UNIX>` page.

--------------------------------
Input/output and pipes
--------------------------------

Many linux commands have three standard methods for input and output, called standard input (or STDIN), standard output (STDOUT) and standard error (STDERR). This standardised communication framework allows us to chain commands together, called piping.

The terminal is the default destination for standard output and standard error. For example, when we used the ``echo`` command above without specifying anything else, the standard output was printed to the terminal. However, we can specify that we want the standard output to be stored in a file using the ``>`` symbol.

.. code-block::bash

	$ echo "hello world" > hello.txt

When we run this, nothing is printed to the terminal, instead it is directed to a file. We can see the contents of this file using the ``cat`` command:

.. code-block::bash

	$ cat hello.txt

Because we didn't specify an output location with ``>`` after the ``cat`` command, the contents were written to the terminal. 

Some functions expect information to be supplied to them on standard input. For this we would use the ``<`` command. This works with ``cat`` for example:

.. code-block::bash

	$ cat < hello.txt

Often this ``<`` symbol can be omitted, but where there is abiguity about what the input is, it's useful to be able to specify. Because many functions are able to read from the standard input and output to the standard output, this gives us access to a very powerful command line ability called piping. We can chain together commands using the ``|`` symbol, taking the standard output from one command and feeding it directly into the standard input of the next command, rather than storing it in a file. For example, let's create a three-line text file, sort the lines alphabetically, then find the unique lines. Note that when we use ``echo`` to create the file, we add a ``-e``. This is an optional parameter which we use to tell ``echo`` to *evaluate* the contents of the string, converting the special character ``\n`` into newlines.

.. code-block::bash

	$ echo -e "line2\nline1\nline2" > lines.txt
	$ sort lines.txt > linessorted.txt
	$ uniq linessorted.txt > linesunique.txt

Let's view all these files

.. code-block::bash

	$ cat lines.txt
	$ cat linessorted.txt
	$ cat linesunique.txt

Now let's do all of that in one command:

.. code-block::bash

	$ echo -e "line2\nline1\nline2" | sort | uniq > linesunique2.txt
	$ cat linesunique2.txt

This is obviously a very trivial example, but we will use this a lot.

--------------------------------
Learning about programs
--------------------------------

If presented with a new function that you have no idea how to use, don't panic! There are lots of resources to help you understand them. The vast majority of functions should have some sort of help file. For example, these are the different ways you could find help for the ``echo`` function:

.. code-block:: bash


	$ man ​fastqc​      # Returns a scrollable manual if it exists
	$ ​fastqc​ -h       # Outputs a text summary of the function's options
	$ ​fastqc​ --help   # Same as above

If these don't help you figure out how to use the tool (which is understandable, sometimes they're very brief!), try searching google. There are lots of people out there who've probably tried to figure out the tool before. The trick is including the right search terms. Be specific, but not too specific, and include important context. For example, I might search "linux command line how to use echo", or "bash print text to terminal echo", or "terminal write string ubuntu".
