.. _remote_access:

======================================
Accessing linux servers
======================================

If you have access to a remote linux server this section covers how to connect to it remotely. Depending on the operating system you are running and the version of this operating system there is a few different ways of doing this. Look at the appropriate section below for your operating system. 

----------------------------------
Using teminal in MacOS
----------------------------------

If you are using a mac then connecting to a server is simple using an SSH (secure shell). Open your terminal application (if you haven't used this before you can access it by using spotlight search or by navigating to the application using launchpad). You then type an SSH command which looks like this: 

.. code-block:: bash

	$ ssh username@server_address

You will need to replace the username in the above command with your username for the server. You'll also need to replace the server_address with the actual address of the server you are connecting to. If it is your first time connecting it will ask you if you trust the server then will usually ask you for a password. 

----------------------------------
Using windows subsystem for linux
----------------------------------

If you are running an upto date version of windows then you can use the windows subsystem for linux (WSL) to connect to the remote server. To get WSL up and running you can follow the documentation on `microsofts site. <https://docs.microsoft.com/en-us/windows/wsl/install-win10>`_
You should then be able to connect to your remote server using SSH as below: 

.. code-block:: bash

	$ ssh username@server_address


You will need to replace the username in the above command with your username for the server. You'll also need to replace the server_address with the actual address of the server you are connecting to. If it is your first time connecting it will ask you if you trust the server then will usually ask you for a password. 

----------------------------------
Using PuTTY in older windows OS
----------------------------------

If you are running an older windows OS that doesn't support WSL then you can use a program called PuTTY which is an SSH client for windows. Open PuTTY and type the server address in the host name field. Then click open. This will then bring up the login screen. Enter your credentials and it will give you access to the server. 
