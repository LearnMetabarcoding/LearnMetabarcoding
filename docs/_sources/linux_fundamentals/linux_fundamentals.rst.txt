.. _linux_basics:

=====================================
Linux basics
=====================================

If you want to find out more about a function and how it works, you can google it or look up its help pages in the terminal, by running one or more of the following:

.. code-block:: bash


	$ man ​fastqc​     #Returns a scrollable manual if it exists
	$ ​fastqc​ -h      #Outputs a text summary of the function's options 
	$ ​fastqc​ --help  #Same as above

Get familiar with using these, you won't always have us to ask!

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

**Using Nano** 

Nano is a command line text editor which allows you to create, edit and save files. 
If you are new to using the command line, and need to make substantial changes to a document, its recommended to download the file onto your computer and edit in a program you are comfortable with. 

To create a document using nano you simply type ``nano`` followed by the name you would like to give the file. For example:

.. code-block:: bash 

	$ nano example.txt

Creating a file using the above command will open the text editor and your terminal will look something like the image below. 

.. image:: nano.png
	:align: center 

The cursor can be seen in the top left of the editor and options are seen at the bottom. The ``^`` character here is for the ``ctrl`` key. To see all options you can press ``ctrl+g``. The ``M`` in the expanded options list is for the ``alt`` key. 

You can now type whatever you need into this file. To save the file you press ``ctrl+o`` and the exit you press ``ctrl+x``.

To open an existing file you type ``nano`` followed by the file name.

.. code-block:: bash 

	$ nano filename

It will show a similar screen to the image above but with all the text that file contains displayed. You can then go ahead and edit the document. 

You can move your cursor to the text you want to edit by using the arrow keys on your keyboard. Alternatively, you can move your cursor to a specific point by pressing ``ctrl+_`` then typing the line number followed by a comma then the column number. 

Nano also has a search and replace function. If you press ``ctrl+\`` you can search for a word, then type what you want to replace it with. You can then go through each instance of the searched term and decide if you would like to replace it by typing ``Y`` for yes or ``N`` for no. Alternatively you can type ``A`` to replace all. Be careful using this method as there may be times where you do not know how many times some text appears and could be damaging to accidentally replace it all.

**Logging into bastion for the first time**

To access the NHM servers remotely you must connect via bastion (also known as orca). Bastion uses two factor authentication which you will need to set up using the Google Authenticator app so make sure you have this downloaded. The steps to do this are different depending on what operating system you are running so go to the section which applies to you. 

**Logging in with Windows using putty.**

Putty is an SSH client available for Windows that will allow you to connect to bastion. Open putty and type orca.nhm.ac.uk into the Host Name field, then click open. A login screen will then appear which you should use your NHM account credentials to login with. A QR code will then appear which you can scan using the Google Authenticator app to set up two factor authentication. If the QR code doesn't work you can use the secret key displayed instead. Once you are connected you can ssh to the NHM server you require by typing ``ssh`` followed by your ``username@server_address``.  If you wanted to connect to the watson server you would do it like so:

.. code-block:: bash 

	$ ssh username@watson.nhm.ac.uk

**Logging in with Linux or macOS using the terminal**

To connect with terminal you use the ``ssh`` command. Type ``ssh`` followed by your ``username@orca.nhm.ac.uk`` as shown below. 

.. code-block:: bash	

	$ ssh username@orca.nhm.ac.uk 

Then type in your password for your NHM account. A QR code will then appear which you can scan using the Google Authenticator app to set up two factor authentication. If the QR code doesn't work you can use the secret key displayed instead. Once you are connected you can ``ssh`` to the NHM server you require by typing ``ssh`` followed by your ``username@server_address``.  If you wanted to connect to the watson server you would do it like so:

.. code-block:: bash 

	$ ssh username@watson.nhm.ac.uk

It will then ask you for your password for that server.

In the terminal you can also login to your required server through bastion in once command:

.. code-block:: bash

	$ ssh -J username@orca.nhm.ac.uk username@server_address

It will ask you for your bastion password followed by your Google Authenticator verification code, and then for your password for the destination server.

**Transferring files between your machine and server**

There will be times where you need to transfer files from your local machine to a server and vice versa. This section will cover how you do this. Again, there are different ways of doing this for different operating systems so see the section which applies to you. 

**Using the scp command in the terminal in Linux or macOS**

If you run Linux or macOS you can transfer files easily using the ``scp`` command in the terminal. 

An example of using ``scp`` to transfer a file from your local machine to a server is below:

.. code-block:: bash 

	$ scp filename username@server_address:/path/

You type ``scp`` followed by the file name (if you are not in the directory the file is in you will need to write the whole file path) followed by your ``username@server_address`` followed by a colon then the path (from the root) to where you want the copy to go in the destination server.  If you don't know what the path is that you need to type in, remember, you can use ``pwd`` in the directory you want to send the file to and this will return the path of that directory. 

If we are either copying from our local machine to a server via bastion (or the other way round) we need to add to our above command to get it to work. To do this you add the ``-o`` flag followed by ``'ProxyJump username@orca.nhm.ac.uk'`` to the beginning of our command as below. 

.. code-block:: bash 

	$ scp -o 'ProxyJump username@orca.nhm.ac.uk' filename username@server_address:/path/

When you type this command in it will ask you for your bastion password, Google Authenticator verification code and then the password to the server you are sending the copied file to. It will then copy the file. If you get an error it typically is due to a typo (file name incorrect or destination path typed out incorrectly for example).

If you want to copy something from a server to your local machine via orca you use the same command but change the order slightly as shown below. **N.B. this command is still given to your machine, not to the server.**

.. code-block:: bash 

	$ scp -o 'ProxyJump username@orca.nhm.ac.uk' username@server_address:/path/ destination_path

You type ``scp -o`` followed by the proxy jump in the same way. You then type your ``username@server_address`` followed by a colon then the path to the file you want to copy. You then type the path to the directory on your own machine that you want to copy to. It will then ask you for the login credentials for bastion and the destination server and copy the file to your local machine. 

You can transfer directories using scp by adding the ``-r`` flag to the beginning of the command as below:

.. code-block:: bash 

	$ scp -r -o 'ProxyJump username@orca.nhm.ac.uk' username@server_address:/path/ destination_path

**Using WinSCP to transfer files on a Windows machine**

Windows users can use an application called WinSCP to transfer files. It comes with the advantage of having a GUI so you can drag and drop files rather than typing out commands. 

To set this up open WinSCP and follow the below steps.

 1. Change the file protocol drop down menu to SCP
 2. Type the address of the server you want to connect to in the Host Name field (e.g. ``watson@nhm.ac.uk``)
 3. Enter your username and password for the server you want to connect to 
 4. Click advanced
 5. Click tunnel on the left menu
 6. Check the 'Connect through SSH' box
 7. Type ``orca@nhm.ac.uk`` in the Host Name field
 8. Type your username and password for orca in the username and password boxes
 9. Click okay then continue on the authentication banner
 10. Enter your verification code from the Google Authenticator app
 11. Click through the remaining prompts
 12. You can now drag and drop files between your local machine and the server