.. _remote_access:

.. role:: var

======================================
Accessing linux servers
======================================

If you have access to a remote linux server this section covers how to connect to it remotely. Depending on the operating system you are running and the version of this operating system there is a few different ways of doing this. Look at the appropriate section below for your operating system. 

----------------------------------
Using teminal in MacOS
----------------------------------

If you are using a mac then connecting to a server is simple using an SSH (secure shell). Open your terminal application (if you haven't used this before you can access it by using spotlight search or by navigating to the application using launchpad). You then type an SSH command which looks like this: 

.. parsed-literal:: 

	ssh :var:`username@server_address`

You will need to replace the username in the above command with your username for the server. You'll also need to replace the server_address with the actual address of the server you are connecting to. If it is your first time connecting it will ask you if you trust the server then will usually ask you for a password. 

----------------------------------
Using windows subsystem for linux
----------------------------------

If you are running an upto date version of windows then you can use the windows subsystem for linux (WSL) to connect to the remote server. To get WSL up and running you can follow the documentation on `microsofts site. <https://docs.microsoft.com/en-us/windows/wsl/install-win10>`_
You should then be able to connect to your remote server using SSH as below: 

.. parsed-literal:: 

	ssh :var:`username@server_address`


You will need to replace the username in the above command with your username for the server. You'll also need to replace the server_address with the actual address of the server you are connecting to. If it is your first time connecting it will ask you if you trust the server then will usually ask you for a password. 

----------------------------------
Using PuTTY in older windows OS
----------------------------------

If you are running an older windows OS that doesn't support WSL then you can use a program called PuTTY which is an SSH client for windows. Open PuTTY and type the server address in the host name field. Then click open. This will then bring up the login screen. Enter your credentials and it will give you access to the server. 

---------------------------------------------------
Transferring files between local machine and server
---------------------------------------------------

There will be instances where you need to transfer files between your machine and a remote server. There are different ways to do this depending on your operating system and preferences. 

--------------------------------------------------------
Using the scp command in the terminal in Linux or macOS
--------------------------------------------------------

If you are running macOS or Linux you can transfer files from local machine to server using the ``scp`` command in the terminal. 

An example of using ``scp`` to transfer a file from your local machine to a server is below: 

.. parsed-literal::

	scp :var:`filename` :var:`username@server_address:/path/`

You type ``scp`` followed by the file name (if you are not in the directory the file is in you will need to write the whole file path) followed by your `username@server_address` followed by a colon then the path (from the root) to where you want the copy to go in the destination server. If you don't know what the path is that you need to type in, remember, you can use pwd in the directory you want to send the file to and this will return the path of that directory. 

To transfer from the server to your local machine you simply swap the order of your file paths i.e. server address and filepath then local file path. 

.. warning::

	The ``scp`` command is always given from your local machines terminal.

-----------------------
Using WinSCP on windows
-----------------------

Windows users can use an application called WinSCP to transfer files. It comes with the advantage of having a GUI so you can drag and drop files rather than typing out commands. 

Follow the below steps to set up WinSCP: 

1. Change the file protocol drop down menu to SCP
2. Type the address of the server you want to connect to in the Host Name field
3. Enter your username and password for the server you want to connect to 
4. Click login
5. Click through the remaining prompts
6. You can now drag and drop files between your local machine and the server

---------------------------
Using a FTP client in macOS
---------------------------

If you are using macOS and would rather use a GUI application there are a few to choose from such as FileZilla or Cyberduck. The instructions below are for FileZilla but they are all fairly similar.

Follow the steps below:

1. Open FileZilla
2. Enter the server address in Host field
3. Enter your username and password in the correct fields
4. Press quick connect
5. You can now drag and drop files between your local machine and the server
