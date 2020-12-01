======================================
UNIX command line
======================================

--------------------------------
The command prompt
--------------------------------

Whether you are using SSH to access a remote linux server, using Terminal on a Mac or Windows Linux subsystem, you will be presented with a window of text awaiting your command. Depending on the computer and how it is configured, this exact nature of the promt will vary, but most commonly it will say your username, machine name and/or current directory, followed by a :code:`$` sign, like this:

.. code-block:: bash

	user@server:~/file/path$

When you see this :code:`$` sign, this means the shell is expecting a new command. We will emulate this in the instructions in this resource, with any commands we suggest you run looking like this:

.. code-block:: bash

	$ echo "hello world"

You would enter everything *after* the :code:`$`, but never the :code:`$` itself. You would then press Enter (Return) to run the command. In this case, it would print the text `hello world` and then the instruction would finish, returning to the prompt.

If your command prompt is ever a different symbol, such as :code:`>`, this probably means that the shell is waiting for you to finish a command you've previously entered. This functionality allows you to write commands over multiple lines if they're very long. However, it's easy to accidentally enter this mode if you fail to close a parenthesis (:code:`()`) or quotation marks :code:`"` in a command, then try to run it.

Try running the following:

.. code-block:: bash
 	
     $ echo "hello

You should be met with a :code:`>` symbol. Finish the command by typing :code:`world"` and pressing Enter.

Sometimes in these resources we will ask you to run a command that is quite long, and to help you read it easily we will present the command broken over multiple lines. It will look like this:

.. code-block:: bash

	$ echo \
	> "hello world"

To enter this in the command prompt, we type the first line (excluding the :code:`$`) and then press Enter after typing the ``\`` symbol. This symbol at the end of the command tells the shell that we want to continue typing the same command on the next line. The prompt will change to a :code:`>`. We then type the second line, *excluding the* :code:`>` *symbol*. 

Finally, the shell will ignore anything on a line after the first :code:`#` symbol it encounters. This is to allow for comments, and these resources will sometimes use this to comment lines of code. For example, you could type everything after the :code:`$` symbol of the following command into the terminal and run it:

.. code-block::bash

	$ echo "hello world"  # prints "hello world"

The output would be identical to the first command on this page.

.. seealso:: We suggest that the best way to learn is to type out the commands as they are shown in these resources. This might cause you more errors, but it gives you a chance to learn from them. If you copy and paste, you should do so line by line for multiline commands, in order to ensure that you always remove the :code:`$` or :code:`>` at the beginning of any lines.

--------------------------------
Learning about programs
--------------------------------

If presented with a new function that you have no idea how to use, don't panic! There are lots of resources to help you understand them. The vast majority of functions should have some sort of help file. For example, these are the different ways you could find help for the :code:`echo` function:

.. code-block:: bash


	$ man ​fastqc​      # Returns a scrollable manual if it exists
	$ ​fastqc​ -h       # Outputs a text summary of the function's options
	$ ​fastqc​ --help   # Same as above

If these don't help you figure out how to use the tool (which is understandable, sometimes they're very brief!), try searching google. There are lots of people out there who've probably tried to figure out the tool before. The trick is including the right search terms. Be specific, but not too specific, and include important context. For example, I might search "linux command line how to use echo", or "bash print text to terminal echo", or "terminal write string ubuntu".s
