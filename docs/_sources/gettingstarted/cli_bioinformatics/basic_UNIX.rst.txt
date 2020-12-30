.. _basic_unix:


.. role:: comment

==================================
Basic UNIX commands
==================================

--------------------------------
Some commonly used commands
--------------------------------

The following are some basic commands you might use to navigate around and manipulate files on a linux computer using the command line interface. 

.. parsed-literal::

	pwd               :comment:`# print the current working directory`

	mkdir ​./dir       :comment:`# make a new directory ​called dir​ inside the working directory`

	cd ​./dir          :comment:`# change working directory to a directory named to ​dir​ that is inside the working directory`

	cd ../            :comment:`# change working directory to the parent of the working directory`

	ls                :comment:`# show the contents of the working directory`

	ls -lh            :comment:`# show the contents in an ordered list with file sizes`

	touch fileA       :comment:`# create a blank file called fileA`

	mv fileA ../      :comment:`# move ​fileA ​to the parent of the working directory`

	cp ../fileA ./    :comment:`# copy ​fileA​ from the parent of the working directory to the working directory`

	mv fileA fileB    :comment:`# rename ​fileA​ to ​fileB`

	rm fileA          :comment:`# delete ​fileA ​(be careful!)`

	rm -d dirA        :comment:`# delete an empty directory called dirA`

	mv file\* ./dir    :comment:`# move all files starting with ​file​ in the current directory to directory ​dir`

	rm \*.fasta        :comment:`# delete all files ending with ​.fasta ​(be really careful!)`

	rm -rf dirA       :comment:`# delete the directory called dirA and its contents (be extremely careful!)`

	head ​fileB        :comment:`# display first 10 lines of ​fileB`

	head -n 20 ​fileB  :comment:`# display first 20 lines of ​fileB`

	more ​fileB        :comment:`# display ​fileB ​in a scrollable format (press q to quit)`

----------------------------------------------------
More detailed examples for beginners
----------------------------------------------------

**Navigating a linux system**

To check where you are in a system you type in ``pwd``. This will show you your current working directory. 
If you need to change directory you can type ``cd`` followed  by the path of the directory you want. 

.. parsed-literal::

	cd directory

If you need to create a new directory you can use the ``mkdir`` command followed by what name you want to give the new directory.

.. parsed-literal:: 
	
	mkdir new_directory

**Creating a file** 

To create a file you can either use commands ``echo`` or ``touch``, or the nano text editor (described in a later section).
To create an empty file you can use the ``touch`` command followed by the name you want to save the empty file under. 

.. parsed-literal::

	touch filename 

To create a file that has certain contents you can use ``echo`` or ``nano``. 
Lets say you want a file that contains the text "this is a file" and you wanted to name that file ``fileA.txt``. 
You would do this as shown below:   

.. parsed-literal::

	echo "this is a file" > fileA.txt

If you want to create a text file with multiple lines of text from the terminal it will be easier to use nano (see later section).

**Copying files**

You might want to copy a file under a different name so you can edit it but still keep the original. 
To do this we can us the ``cp`` command. Type ``cp`` followed by the name of the file you want to copy then the name you want to give the copy. 
Lets say we wanted to make a copy of ``fileA.txt`` named ``fileB.txt``. The block below shows us how we would do this.

.. parsed-literal::

	cp fileA.txt fileB.txt

You can also copy a file into a different directory by putting the target directory path as the second argument followed by a ``/`` and the name you want the copy to be saved under.
For example, if we wanted to copy ``fileA.txt`` to a directory named ``dirB`` that was in our current parent directory and name the copy ``fileB.txt``, we would run the below command:

.. parsed-literal::

	cp fileA.txt ../dirB/fileB.txt 

**Moving files**

If you want to move a file into a different directory without copying it you can use the ``mv`` command. 
You type ``mv`` followed by the name of the file you would like to move then the target directory path.
Lets say we want to move a file named ``fileC.txt`` into a directory named ``dirB`` which is contained within our current parent directory. 
The block below shows us how to do that.

.. parsed-literal::

	mv fileC.txt ../dirB
