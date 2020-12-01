==========================================================
Introduction to the linux command line
==========================================================

.. toctree::
	:hidden: 
	
	linux_fundamentals/linux_fundamentals

Much of the work you will undertake will involve using the linux command line (aka terminal) on the linux server. A summary of useful commands can be found at the end of this section. A note on nomenclature. In this handout, code to enter in the terminal will be displayed as in the following example:

.. code-block:: bash


	$ fastqc ​inputfile.fq [-o ​./fastQCout]​

Anything in italics will be ​an example of what you could input, \ **​you will need to replace it** \ with the appropriate file path, value or some other input information. Sometimes this will need to be a specific file, for example an output from a previous command; sometimes, any file will do, if it’s just exploring some sort of file property. Anything in normal upright text should definitely be entered, except that anything in square brackets is optional, if you choose to use it you would not include the square brackets. The ​$ specifies that this is code to enter on the command prompt, / **​you don't need to enter the ​$​.** 

Sometimes on the terminal, we enter long commands on multiple lines. You would start typing your command, then type a ​\ ​and press return. The command prompt will change to a ​>​. We duplicate this formatting for some commands in this document. You can either copy the way the command is formatted when you type it out, or simply omit the ​\ and newlines and just type the command as one long string. Just remember,  **​you don’t need to enter the ​> at the beginning of any lines where the previous line started with ​\​.**

**Please avoid** copying and pasting the commands into the terminal, and if you must do this only copy from a basic text editor like notepad. If you copy commands from word or acrobat you risk also copying non-visible characters that can still be seen by the terminal and may screw up your instruction.

If you are new to the linux command line or would like to refresh your memory on basic linux functions see this :ref:`page<linux_basics>`. 
If you are feel comfortable enough with linux you can move straight onto the the :ref:`read processing<read_processing>` section. 

