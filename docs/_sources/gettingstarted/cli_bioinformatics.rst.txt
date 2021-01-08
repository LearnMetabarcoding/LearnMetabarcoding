.. _cli_bioinformatics:

==========================================================
Command line bioinformatics
==========================================================

.. toctree::
	:hidden: 
	
	cli_bioinformatics/UNIX_cmd_line
	cli_bioinformatics/basic_UNIX
	cli_bioinformatics/nano
	cli_bioinformatics/grep
	cli_bioinformatics/sed
	cli_bioinformatics/loops
	cli_bioinformatics/cheatsheet
	cli_bioinformatics/keeping_organised

The command line interface (CLI) provides a versatile low-level environment for processing DNA sequence data. The majority of the software used in bioinformatic pipelines are written for the Linux command line, so understanding how to use this interface is important for mastering metabarcoding bioinformatics. In this section we will introduce you to the command line interface and give an overview of the basic commands you need to navigate a Linux operating system. We will discuss some common Linux tools that can be applied to DNA sequence data. It is important to be familiar with the concepts covered in this section before progressing with the bioinformatic sections: understanding the command line will make the syntax and context of later sections much clearer, and aid you in troubleshooting if something doesn't work.

Linux is a family of operating system distributions based on UNIX and sharing the same fundamental operating system functioning. The command line interface is a text-based interface for sending commands to the operating system and recieving information back. This is performed in a special piece of software called a terminal, which runs a certain type of interface layer on top of the operating system, called a shell. These resources assume that you are running the bash shell (one of the most common Linux shells) and are written for Ubuntu Linux (one of the most common Linux distributions). However, you can access a shell in any operating system: Apple Macs, for example, are also built on UNIX and while the MacOS shell is not strictly bash, it is similar and you can use the Terminal on MacOS to perform many of the same commands we will cover here. Windows runs on a completely different system, and while you can use a CLI interface on Windows, called PowerShell, it is completely different and the standard commands differ. However, Microsoft has recently released the `Linux Subsystem for Windows <https://docs.microsoft.com/en-us/windows/wsl/about>`_, which creates a kind of virtual computer within Windows that runs Linux and provides access to a bash shell on Windows.

