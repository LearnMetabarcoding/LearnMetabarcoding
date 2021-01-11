.. _demultiplexing:

.. role:: var

.. role:: comment 

=================
1. Demultiplexing
=================

.. toctree::
	:hidden:

	extensions/cutadapt_extension

Introduction
============

There are many ways in which metabarcoding libraries may be sequenced. If you are using the example data, we are going to work here with a library preparation pipeline that involved indexing amplicons during initial PCR, such that each sample had a different 6-base index within a library. Once sequenced, we need to use these index sequences to separate out different samples. This process is called **demultiplexing**. In this case, the amplicons were sequenced using paired-end sequencing, meaning the two ends of each fragment were read, working inwards. We have eight sequence files received from our sequencing facility, one for each read direction for each of four libraries.

.. admonition:: I don't have multiplexed data!
	:class: togglegreen
	
	If you are following along with your own data, this step only applies if the sequence files you have contain data from multiple samples. Generally this happens if you multiplex your samples together during first-round PCR as well as the multiplexing that happens as part of library preparation. The sequencer generally demultiplexes library preparation multiplexing, so if you did *not* multiplex during first round PCR, you can probably skip this step and go straight to :ref:`2. Primer removal<primer_removal>`

.. admonition:: Data and software 
	:class: green
	
	This tutorial works with raw FASTQ-format sequence data that contains indices at the beginning of the reads. The example data for this can be found in the ``0_rawsequences`` directory within the :ref:`sectionA archive<sectionAdata>`. You should copy this directory over to your working directory as follows:
	
	.. parsed-literal::
		:class: codebg
		
		cp -r :var:`path/to`\/exampledata/sectionA/0_rawsequences/ ./
		
	
	If you are completely new to sequence data, you might at this point want to :ref:`review the FASTQ format <fastq>`
	
	This tutorial uses the :ref:`cutadapt <cutadapt>` software.
	


Primers and indices
===================

Each of these libraries is actually three different metabarcoding samples. Each sample within each library was amplified with a different 6-base index. You can see these indices in the ``indices.txt`` file within the ``0_rawsequences/`` directory. First, change into the ``0_rawsequences/`` directory and then view the file:

.. parsed-literal::
	:class: codebg
	
	cd 0_rawsequences/
	cat indices.txt

The ``​cat`` command simply outputs the entire contents of the files it is given, one after the other. Here we're using it to just output the content of one file, but look out for this command later!

We can use the ``grep`` command to check for indices in a file (see :ref:`here<grep>` for more detail on this). Select any of the starting FASTQ files and run the following on it to search for the ``AAGAGG`` index

.. parsed-literal::
	:class: codebg
	
	head -n 24 :var:`file.fastq` | grep -E "AAGAGG|$"

You should see the index sequence bolded at the beginning of a sequence. You might also see it elsewhere in sequences - it's such a short base sequence it's completely possible that real sequence reads contain this motif. If you see no bolded text, try a different FASTQ file.

When we did PCR, the index was part of the primers used, so that the reaction added this sequence to our amplicons when copying them. The primer binding sequences used for this metabarcoding reaction were (don't run these!):

.. topic:: Forward(R1)

	.. parsed-literal::

		\CCNGAYATRGCNTTYCCNCG

.. topic:: Reverse (R2)

	.. parsed-literal::

		\TANACYTCNGGRTGNCCRAARAAYCA

Note the presence of non ATCG bases - these are ambiguities added to the primers to allow them to be less specific and bind to a greater variety of taxa. The indices are **not** shown here: they would go at the start of the primer binding sequence.

.. admonition:: Exercise
	
	* Use the grep command to search for the primer sequence in a file. Note that ambiguities (any base apart from ATCG) should be replaced with a ``.`` (full stop) which is a special character in Regular Expressions meaning "any character".
	* Look at a few different libraries, both forward and reverse, both index and primer.
	
	If you get stuck, look at the solution below.

.. admonition:: Solution
	:class: toggle
	
	.. parsed-literal::
		:class: codebg

		head -n 24 :var:`input_R1.fastq` | grep -E "CC.GA.AT.GC.TT.CC.CG|$"
		head -n 24 :var:`input_R2.fastq` | grep -E "TA.AC.TC.GG.TG.CC.AA.AA.CA|$"

You'll probably see that there are occasions where no index or primer is highlighted on a sequence. This means there was a sequencing error. Look closely and you'll see that a base is missing or inserted, or just wrong.

Demultiplexing
==============

We want to split each of these libraries up by index into a separate pair of files for each of the 12 samples, and remove the index sequences. We will do this using the tool **cutadapt**. This versatile tool allows separating files by index and removal of these indices and primers. It can allow for some error in the index sequence, and can keep read pairs in sync (more on this later).

As ever with a new tool, first cast your eye over the help, either online or by running: 

.. parsed-literal::
	:class: codebg
	
	cutadapt --help

It's quite long, but at least read the first section to get acquainted with it. Don't worry, we're going to give you a command shortly, but before we do it's helpful to think about exactly what our data is and what we want to do:

* We have paired data
* Our indices are at the beginning of the reads
* We have multiple indices (cutadapt calls them 'adapters')
* We want to output a different file for each index

**Cutadapt** has settings for all of these situations. It will allow reading two files as input, and will ensure that pairs of reads in these files are kept in sync. Indices at the beginning of reads are specified using ``-g`` (or ``​-G`` for the second file of reads), we can specify these multiple times, and name different adapters. We also specify that the adapters are right at the beginning, with no gaps, using a ``^`` symbol. We can specify that we want output files depending on the combination of adapters found using the ``​-o`` and ``​-p`` options for the first and second files respectively.

To avoid a mess of files, :guilabel:`make sure you're in the parent directory, then create a new directory`. Call this new directory something appropriate. If you're unsure how to do this check the solution box below.

.. admonition:: Solution
	:class: toggle

	.. parsed-literal::
		:class: codebg

		cd ../        :comment:`# Change working directory to the parent of the current working directory`
		mkdir 1_demux :comment:`# Create a new directory called 1_demux`

Referring to the indices.txt file, we can now construct a command that demultiplexes our Lib1. The following commands assume that you are in the directory that contains the ``0_rawsequences`` directory and an empty directory called ``1_demux``. Let's first try and demultiplex a single file. :guilabel:`Carefully examine the following command and look at the help file to make sure you're clear on what each of the arguments is doing`.

Then, type in the command. Reminder: we used the ``​\`` to split the command over multiple lines. You can either type this and press enter afterwards, or you can just ignore it and continue typing the command all in one long line (without pressing Enter until you're done). Finally, run the command and inspect the terminal output and make sure you understand what it's saying. Note that if you didn't call your directory ``1_demux``, you should change those parts of the command.

.. parsed-literal::
	:class: codebg

	cutadapt -g T4=^AAGAGG -g T9=^AATCGC -g T11=^AGCTAC \\
	-G T4=^AAGAGG -G T9=^AATCGC -G T11=^AGCTAC \\
	-o 1_demux/{name1}-{name2}_R1.fastq -p 1_demux/{name1}-{name2}_R2.fastq \\
	0_rawsequences/Lib1_R1.fastq 0_rawsequences/Lib1_R2.fastq

.. admonition:: Exercise
	
	* Before you check the output files, think: how many files do you expect to get out of this command?
	* List the files in the demux directory, and run the grep command to see the read numbers per file. Check the solution below if you're not sure how to do this.

.. admonition:: Solution
	:class: toggle
	
	.. parsed-literal::
		:class: codebg
	
		ls 1_demux/\*
		grep -c "^\@D00" 1_demux/\*

Are there more files than expected? This is because the command has looked for all adapter combinations. When we have 3 different forward indices and 3 different reverse indices, there are 9 different combinations possible. Add on top of this that there are 6 possibilites where only a forward *or* a reverse index is used, plus the possibility where *no* indices are used. Hence you should have 16 file pairs.

.. admonition:: Note
	:class: green
	
	Some researchers use all of these different combinations to efficiently apply few indices to identify many many different samples. However, this makes it much harder to spot errors. We don't have any valid sequences that use different forward and reverse indices, yet the demultiplexer has found many: these are errors in the sequencing. The sequencer has mistakenly associated some reads as the same fragment when they aren't - they actually come from two different samples, hence some files with two different sample names. And in some cases, no index can be found on one or both of a paired read, probably due to a sequencing error. These are marked as unknown. 

Happily, all of these errors are in a distinct minority, and the majority of reads have been allocated to files for our samples. If we had used all 9 combinations, we wouldn't have been able to spot many of these errors!

If you add all of the read counts up, you'll notice we're missing some reads from our original files: these had no mate pair and were completely discarded.

.. admonition:: Exercise
	
	* Construct three more cutadapt commands to demultiplex the other three libraries, placing the outputs into the same demultiplexing output directory as for the first library.
	* List the contents of the directory and check the read numbers per file again
	

Cleaning up
===========

You should now have lots of files in your output directory. It's good practice to keep track of how demultiplexing performed: you could :guilabel:`try to write a command that saves the output of your previos grep command into a file` to keep a record (see the solution box below if you're not sure how to do this). 

.. admonition:: Solution
	:class: toggle

	.. parsed-literal::
		:class: codebg
	
		grep -c "^\@D00" 1_demux/\* > :var:`output.txt`

Let's get rid of the files we don't need. You've doubled the amount of storage you're using - here the files aren't very large but if you were doing this with a standard dataset, directories would fill up quickly. Navigate to the demux folder, very carefully copy the following command and run it. It works through the files, extracting the first and second sample name, then deletes the file if they don't match. You do not need to type any ``#comments``, or add the extra spaces - this is just to make it clearer.

.. parsed-literal::
	:class: codebg

	for f in \*;			:comment:`# loop through files`
	do
		s1=${f%-\*};
		s2=${f%_\*};		:comment:`# extract sample names`
		s2=${s2#\*-};
		if [ $s1 != $s2 ];	:comment:`# check if different`
		then
			rm $f;		:comment:`# delete if different`
		else
			mv $f ${f#\*-};	:comment:`# keep if same, removing first part of name`
		fi; 			:comment:`# end if clause`
	done 				:comment:`# end loop`

.. sidebar:: Alternatives
	
	The approach we've used for demultiplexing here doesn't scale well to larger datasets: the aim is to help you understand what demultiplexing involves. There is an alternative way of specifying the index sequences in **cutadapt** using a fasta file of indices, `see the cutadapt documentation <https://cutadapt.readthedocs.io/en/stable/guide.html#demultiplexing>`_ for more information.
	
	We use **cutadapt** because it is very versatile and has many useful options. However, there are other tools out there. **OBITools** has the `obigrep <https://pythonhosted.org/OBITools/scripts/obigrep.html>`_ and `ngsfilter <https://pythonhosted.org/OBITools/scripts/ngsfilter.html>`_ scripts, the latter of which seems designed for bulk demultiplexing but doesn't have anywhere near the sensitivity and customisability of **cutadapt**. **QIIME** has the `split_libraries <http://qiime.org/scripts/split_libraries.html>`_ script which seems to have more features. Our approach is to use a wrapper script for **cutadapt** that reads a table of index sequences and a set of cutadapt arguments that automatically builds the cutadapt command.

This isn't a crucial bioinformatics step, it's just to tidy things up. You don't need to understand everything about this command, although the loop syntax is going to crop up frequently. If you're keen to try and figure this out, you might want to review the page on :ref:`loops in bash<loops>`, making sure to read about :ref:`parameter substitution<parameter-substitution>`

Finally, to remove the files beginning with ``unknown``, run:

.. parsed-literal::
	:class: codebg
	
	rm unknown\*

These files contain the sequences for which no index was identified - we're not interested in keeping them.

Next steps
==========

We have generated a set of paired files, each containing the forward or reverse reads of the sequences we are confident belong to a specific sample.

If you'd like to explore more **cutadapt** parameters, there are some further cutadapt exercises :ref:`here<cutadapt_extension>`, but this isn't necessary for the next step.

Next we remove the primers from the sequences in these files: :ref:`2. Primer removal.<primer_removal>`
