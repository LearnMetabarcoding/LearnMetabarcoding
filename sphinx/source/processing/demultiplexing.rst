.. _demultiplexing:

========================================
1. Demultiplexing
========================================

.. toctree::
	:hidden:

	fundamentals/grep_command
	extensions/cutadapt_extension

There are many ways in which metabarcoding libraries may be sequenced. We are going to work here with a library preparation pipeline that involved indexing amplicons during initial PCR, such that each sample had a different 6-base index within a library. Once sequenced, we need to use these index sequences to separate out different samples. This process is called ​**demultiplexing​.** In this case, the amplicons were sequenced using paired-end sequencing, meaning the two ends of each fragment were read, working inwards. We have eight sequence files received from our sequencing facility, one for each read direction for each of four libraries.

Each of these libraries is actually three different metabarcoding samples. Each sample within each library was amplified with a different 6-base index. You can see these indices in the indices.txt file:

.. code-block:: 
	
	$ cat indices.txt

The ``​cat`` command simply outputs the entire contents of the files it is given, one after the other. Here we’re using it to just output the content of one file, but look out for this command later!

When we did PCR, the index was part of the primers used, so that the reaction added this sequence to our amplicons when copying them. The primers used for this metabarcoding reaction were:

:Forward (R1): ``​CCNGAYATRGCNTTYCCNCG``
:Reverse (R2): ``TANACYTCNGGRTGNCCRAARAAYCA``

Note the presence of non ATCG bases - these are ambiguities added to the primers to allow them to be less specific and bind to a greater variety of taxa.


.. topic:: Do this
	Use the grep command above to search for the primer sequence in a file. If you are unfamilliar with the grep command, see :ref:`here<grep_command>`. Note that ambiguities (any base apart from ATCG) should be replaced with a ​``.`` (full stop) which is a special regex symbol meaning "any character".
	
	Try writing the command yourself before looking at the answer in the footnote below [#f1]_.

	Look at a few different libraries, both forward and reverse, both index and primer.

.. admonition:: Solution
	:class: .toggle
	
	``$ head -n 12 ​in_R1.fastq​ | grep -E "CC.GA.AT.GC.TT.CC.CG|$"``
	``$ head -n 12 ​in_R2.fastq​ | grep -E "TA.AC.TC.GG.TG.CC.AA.AA.CA|$"``


You’ll probably see that there are occasions where no index or primer is highlighted on a sequence. This means there was a sequencing error. Look closely and you’ll see that a base is missing or inserted, or just wrong.

We want to split each of these libraries up by index into a separate pair of files for each of the 12 samples, and remove the index sequences. We will do this using the tool `cutadapt. <https://cutadapt.readthedocs.io>`_ This versatile tool allows separating files by index and removal of these indices and primers. It can allow for some error in the index sequence, and can keep read pairs in sync (more on this later).

As ever with a new tool, first cast your eye over the help, either online or buy running: 

.. code-block:: bash 
	
	$ cutadapt --help

It’s quite long, but at least read the first section. It’s helpful to think about exactly what our data is and what we want to do:

* We have paired data

* Our indices are at the beginning of the reads

* We have multiple indices (cutadapt calls them ‘adapters’)

* We want to output a different file for each index


Cutadapt has settings for all of these situations. It will allow reading two files as input, and will ensure that pairs of reads in these files are kept in sync. Indices at the beginning of reads are specified using ``-g`` ( ``​-G`` for the second file of reads), and we can specify these multiple times, and give different adapters names. We also specify that the adapters are right at the beginning, with no gaps, using a ``^`` symbol. We can specify that we want output files depending on the combination of adapters found using the ``​-o`` and ``​-p`` options for the first and second files respectively.

Referring to the indices.txt file, we can now construct a command that demultiplexes our Lib1. To avoid a mess of files, I strongly suggest returning up to the parent directory and creating a new directory [#f2]_ . Call this something appropriate.

This following commands assume that you are in the directory containing the "0_rawsequences" directory and an empty directory called "1_demux". Let's first try and demultiplex a single file. Reminder: we used the ``​\`` to split the command over multiple lines. You can either type this and press enter afterwards, or you can just ignore it and continue typing the command at the beginning of the next line.

Carefully examin the following command and make sure you're clear on what each of the arguments is doing. Then, run the command and inspect the terminal output and make sure you understand what it's saying.

.. code-block:: bash 

	$ cutadapt -g T4=^AAGAGG -g T9=^AATCGC -g T11=^AGCTAC \
	> -G T4=^AAGAGG -G T9=^AATCGC -G T11=^AGCTAC \
	> -o 1_demux/{name1}-{name2}_R1.fastq -p 1_demux/{name1}-{name2}_R2.fastq \ 
	> 0_rawsequences/Lib1_R1.fastq 0_rawsequences/Lib1_R2.fastq

TODO: update this command to use internal indices.

.. topic:: Questions

	Before you check, think: how many files do you expect to get out of this command?

List the files in the demux directory, and run the grep command from the previous section to see the read numbers per file [#f3]_ . More than you expected?

This is because the command has looked for all adapter combinations. When we have 3 different forward indices and 3 different reverse indices, there are 9 different combinations possible. Add on top of this that there are 6 possibilites where only a forward *or* a reverse index is used, plus the possibility where *no* indices are used. Some researchers use this to efficiently apply few indices to identify many many different samples. However, this makes it much harder to spot errors. We don't have any valid sequences that use different forward and reverse indices, yet the demultiplexer has found many: these are errors in the sequencing. The sequencer has mistakenly associated some reads as the same fragment when they aren’t - they actually come from two different samples, hence some files with two different sample names. And in some cases, no index can be found on one or both of a paired read, probably due to a sequencing error. These are marked as unknown. Happily, all of these errors are in a distinct minority, and the majority of reads have been allocated to files for our samples. If we had used all 9 combinations, we wouldn't have been able to spot many of these errors!

If you add everything up, you’ll notice we’re missing some reads from our original files: these had no mate pair and were completely discarded.

.. topic:: Do this

	Construct three more cutadapt commands to demultiplex the other three libraries, placing the outputs into the same demux directory.

You should now have lots of files in that demux directory. It’s good practice to keep track of how demultiplexing performed: you could put the output of a grep command into a file to keep a record [#f4]_.

Let’s get rid of the files we don’t need. You’ve doubled the amount of storage you’re using - here the files aren’t very large but if you were doing this with a standard dataset, directories would fill up quickly. Navigate to the demux folder, very carefully copy the following command and run it. It works through the files, extracting the first and second sample name, then deletes the file if they don’t match. You do not need to type any ​``#comments​``, or add the extra spaces - this is just to make it clearer.

.. code-block:: bash 

	$ for f in * \			# loop through files
	> do \
	>	s1=${f%-*} \
	>	s2=${f%_*} \		# extract sample names
	>	s2=${s2#*-} \
	>	if [ $s1 != $s2 ] \	# check if different
	>	then
	>		rm $f; \	# delete if different
	>	else
	>		mv $f ${f#*-} \	# keep if same
	>	fi \ 			# end if clause
	> done 				# end loop 

An explanation for this code is below. This isn’t a crucial bioinformatics step, it’s just to tidy things up. You don’t need to understand everything about this command, although the loop syntax is going to crop up frequently.

Then also run:

.. code-block:: bash 

	$ rm unknown*

This will delete the files beginning with unknown. These contain the sequences for which no index was identified - we’re not interested in them.

In the above command, the ​for part sets up a loop that works through each file name in the directory, using ​f to store the current name. It then uses something called parameter substitution to strip the names down to the first and second sample names, storing these in two variables. It then asks if the two sample names are different - if so, the current file is deleted, otherwise (i.e. they’re the same), the file is renamed (moved from one name to another), again using parameter substitution to strip out the unneeded parts of the name. You do not need to understand this.

If you'd like to explore more cutadapt parameters check out this extension task: :ref:`cutadapt extension<cutadapt_extension>`. Otherwise, move on to 
our next step :ref:`primer removal.<primer_removal>`

.. rubric:: Footnotes 


.. [#f1] ``$ head -n 12 ​in_R1.fastq​ | grep -E "CC.GA.AT.GC.TT.CC.CG|$"`` 
	     
		 ``$ head -n 12 ​in_R2.fastq​ | grep -E "TA.AC.TC.GG.TG.CC.AA.AA.CA|$"`` 
.. [#f2] ``$ cd ../``
		 
		 ``$ mkdir 1_demux``
.. [#f3] ``$ ls 1_demux/*``
		 
		 ``$ grep -c "^@D00" 1_demux/*`` 
.. [#f4] ``$ ​grep -c "^@D00" 1_demux/* > demuxlog.txt``
