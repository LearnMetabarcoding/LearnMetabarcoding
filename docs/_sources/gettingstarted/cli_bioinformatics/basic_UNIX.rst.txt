.. _basic_unix:


.. role:: var

==================================
Basic UNIX commands
==================================

Some commonly used commands
===========================

The following are some basic commands you might use to navigate around and manipulate files on a linux computer using the command line interface. You can read more about some of these commands below.


Print the current working directory

.. parsed-literal::
	
	pwd

Make a new directory ​called ``dir​`` inside the working directory

.. parsed-literal::
	
	mkdir ​./dir

Change working directory to a directory named to ​dir​ that is inside the working directory

.. parsed-literal::
	
	cd ​./dir

Change working directory to the parent of the working directory

.. parsed-literal::
	
	cd ../

Show the contents of the working directory

.. parsed-literal::
	
	ls

Show the contents in an ordered list with file sizes

.. parsed-literal::
	
	ls -lh

Create a blank file called ``fileA``

.. parsed-literal::
	
	touch fileA

Move ``fileA`` ​to the parent of the working directory

.. parsed-literal::
	
	mv fileA ../

Copy ``fileA`` from the parent of the working directory to the working directory

.. parsed-literal::
	
	cp ../fileA ./

Rename ``fileA`` to ``fileB``

.. parsed-literal::
	
	mv fileA fileB

Delete ``fileA`` (be careful!)

.. parsed-literal::
	
	rm fileA

Delete an empty directory called ``dirA``

.. parsed-literal::
	
	rm -d dirA

Move all files starting with ``file`` in the current directory to directory ``dir``

.. parsed-literal::
	
	mv file\* ./dir

Delete all files ending with ``.fasta`` (be really careful!)

.. parsed-literal::
	
	rm \*.fasta

Delete the directory called ``dirA`` and its contents (be extremely careful!)

.. parsed-literal::
	
	rm -rf dirA

Display first 10 lines of ``fileB``

.. parsed-literal::
	
	head ​fileB

Display first 20 lines of ``fileB``

.. parsed-literal::
	
	head -n 20 ​fileB

Display ``fileB`` in a scrollable format (press :menuselection:`q` to quit)

.. parsed-literal::
	
	more ​fileB


More detailed examples for beginners
====================================

Navigating a linux system
-------------------------

To check where you are in a system you type in ``pwd`` and press Enter (Return). This will show you your current working directory. 
If you need to change directory you can type ``cd`` followed by the path of the directory you want. 

.. parsed-literal::

	cd :var:`path/to/directory`

If you need to create a new directory you can use the ``mkdir`` command followed by what name you want to give the new directory.

.. parsed-literal:: 
	
	mkdir :var:`new_directory`

Creating a file
---------------

To create a file you can either use commands ``echo`` or ``touch``, or the nano text editor (described in a later section).
To create an empty file you can use the ``touch`` command followed by the name you want to save the empty file under. 

.. parsed-literal::

	touch :var:`filename`

To create a file that has certain contents you can use ``echo`` or ``nano``. 
Lets say you want a file that contains the text "this is a file" and you wanted to name that file ``fileA.txt``. 
You would do this as shown below:

.. parsed-literal::

	echo "this is a file" > fileA.txt

If you want to create a text file with multiple lines of text from the terminal it will be easier to use nano (see later section).

Copying files
-------------

You might want to copy a file under a different name so you can edit it but still keep the original. 
To do this we can us the ``cp`` command. Type ``cp`` followed by the name of the file you want to copy then the name you want to give the copy. 
Lets say we wanted to make a copy of ``fileA.txt`` named ``fileB.txt``. The block below shows us how we would do this.

.. parsed-literal::

	cp fileA.txt fileB.txt

You can also copy a file into a different directory by putting the target directory path as the second argument followed by a ``/`` and the name you want the copy to be saved under.
For example, if we wanted to copy ``fileA.txt`` to a directory named ``dirB`` that was in our current parent directory and name the copy ``fileB.txt``, we would run the below command:

.. parsed-literal::

	cp fileA.txt ../dirB/fileB.txt 

Moving files
------------

If you want to move a file into a different directory without copying it you can use the ``mv`` command. You type ``mv`` followed by the name of the file you would like to move then the target directory path. Lets say we want to move a file named ``fileC.txt`` into a directory named ``dirB`` which is contained within our current parent directory:

.. parsed-literal::

	mv fileC.txt ../dirB/

Renaming files
--------------

The simplest way to rename files is to use the ``mv`` command. This might seem strange, but think of the path of a file as being simply a longer version of the file name. Thus moving files between directories is essentially just a matter of changing their name. So you can rename a file by "moving" it to another file name. So say you wanted to change the name of ``fileA.txt`` to ``fileD.txt``:

.. parsed-literal::
	
	mv fileA.txt fileD.txt

It's that simple!
