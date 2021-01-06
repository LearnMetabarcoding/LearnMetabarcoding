.. _using_your_own_machine:

======================
Using your own machine
======================

While using a high performance Linux server would be ideal for bioinformatics, using your own machine is possible assuming your computer is relatively modern. We would suggest at least a quad-core processor and 4GB of RAM, ideally much more. You should be aware that depending on the size of your dataset, some commands will take substantial time to run - potentially days on a less powerful machine.

Linux
=====

Linux is the optimal operating system for running bioinformatic analyses. The vast majority of software written for metabarcoding is primarily aimed at Linux, so if you already use Linux you're set. Note that the instructions here assume Ubuntu Linux, but if you're running a different distribution then everything will probably work fine, and you probably already know enough to modify anything that doesn't.
If you don't already use Linux, it is completely free and open source, it is widely used and you might be surprised how much of your favourite software is available on Linux nowadays. If you would like to try Linux, we would recommend the Ubuntu distribution as one that is very user friendly and widely supported. You can search google to find many excellent tutorials on how to install Linux either overwriting Windows/Mac or as a dual-boot system, although you should always read any warnings carefully and be happy that you're aware of the risks of modifying your operating system.

Mac OS
======

Like Linux, Mac OS is based on UNIX and runs a very similar fundamental architecture. This means that a lot of command line software will run on Mac OS, although you may find that you need to use different commands to install software, and some programs may not work at all. If this is something you want to try, we suggest you start with learning about `homebrew <https://brew.sh/>`_, a package manager for Mac, and then try to :ref:`install software <installing_software>` using ``brew`` instead of ``apt``. However we doubt all software will install smoothly.

Windows
=======

Windows is a completely different operating system to UNIX-based systems and it is not possible to install most of the command line software in the native Windows environment. However, Microsoft has recently released the `Linux Subsystem for Windows <https://docs.microsoft.com/en-us/windows/wsl/about>`_, which creates a kind of virtual computer within Windows that runs Linux. Once installed and activated, you may be able to use this to install the software needed and run bioinformatics commands, although it may not work perfectly.


