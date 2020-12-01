==================================
Basic UNIX commands
==================================

--------------------------------
Some commonly used commands
--------------------------------

.. code-block:: bash
	
	$ cd ​./dir          #change location to ​dir​ inside current directory

	$ cd ../            #change location to parent directory

	$ pwd               #show current directory

	$ mkdir ​./dir       #make new directory ​dir​ insider current directory

	$ ls    	    #show the contents of the current directory

	$ ls -lh 	    #show the contents in an ordered list with file sizes

	$ mv fileA ../      #move ​fileA ​to parent directory (in this instance)

	$ cp fileA ../      #copy ​fileA​ to parent directory

	$ mv fileA fileB    #rename ​fileA​ to ​fileB

	$ rm fileA          #delete ​fileA ​(Be careful!)

	$ rm -d dirA        #delete an empty directory

	$ mv file* ./dir    #move all files starting with ​file​ to directory ​dir

	$ rm *.fa	    #delete all files ending with ​.fa ​(Be really careful!)

	$ rm -rf dirA       #delete a directory and contents (Be extremely careful!)

	$ head ​fileB        #display first 10 lines of ​fileB

	$ head -n 20 ​fileB  #display first 20 lines of ​fileB

	$ more ​fileB	     #display ​fileB ​in a scrollable format (press q to quit)

----------------------------------------------------
More detailed examples for beginners
----------------------------------------------------

**Navigating a linux system**

To check where you are in a system you type in ``pwd``. This will show you your present working directory. 
If you need to change directory you can type ``cd`` followed  by the path of the directory you want. 

.. code-block:: bash

	$ cd /directory

If you need to create a new directory you can use the ``mkdir`` command followed by what name you want to give the new directory.

.. code-block:: bash 
	
	$ mkdir new_directory

**Creating a file** 

To create a file you can either use commands ``echo`` or ``touch``, or the nano text editor (described in a later section).
To create an empty file you can use the ``touch`` command followed by the name you want to save the empty file under. 

.. code-block:: bash 

	$ touch filename 

To create a file that has certain contents you can use ``echo`` or ``nano``. 
Lets say you want a file that contains the text "this is a file" and you wanted to name that file ``fileA.txt``. 
You would do this as shown below:   

.. code-block:: bash 

	$ echo "this is a file" > fileA.txt

If you want to create a text file with multiple lines of text from the terminal it will be easier to use nano (see later section).

**Copying files**

You might want to copy a file under a different name so you can edit it but still keep the original. 
To do this we can us the ``cp`` command. Type ``cp`` followed by the name of the file you want to copy then the name you want to give the copy. 
Lets say we wanted to make a copy of ``fileA.txt`` named ``fileB.txt``. The block below shows us how we would do this.

.. code-block:: bash

	$ cp fileA.txt fileB.txt

You can also copy a file into a different directory by putting the target directory path as the second argument followed by a ``/`` and the name you want the copy to be saved under.
For example, if we wanted to copy ``fileA.txt`` to a directory named ``dirB`` that was in our current parent directory and name the copy ``fileB.txt``, we would run the below command:

.. code-block:: bash 

	$ cp fileA.txt ../dirB/fileB.txt 

**Moving files**

If you want to move a file into a different directory without copying it you can use the ``mv`` command. 
You type ``mv`` followed by the name of the file you would like to move then the target directory path.
Lets say we want to move a file named ``fileC.txt`` into a directory named ``dirB`` which is contained within our current parent directory. 
The block below shows us how to do that.

.. code-block:: bash 

	$ mv fileC.txt ../dirB
