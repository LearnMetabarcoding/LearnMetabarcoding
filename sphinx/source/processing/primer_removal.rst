.. _primer_removal:

============================================
2. Primer removal
============================================

.. toctree::
	:hidden:

	extensions/quality_settings_extension

Introduction
============

As well as demultiplexing, cutadapt removed the indices from our samples. You can check this using the grep command from the previous section. Alternatively, you can use the following command to explore the length distribution of the sequences. Run this on a pre- and post- demultiplexed file.

.. code-block:: bash

	$ sed -n '2~4p'​ file​ | while read l; do echo ${#l} ; done | sort | uniq -c

.. admonition:: How this command works
	:class: toggle
	:class: green
	The ``sed`` command ​p​rints only every 4th line, starting at the 2nd. This is sent to a ``while`` loop, which reads each line and stores it in ``l`` ​. The loop outputs the number of characters in the ``l`` variable, one per line. These are then sorted into alphanumeric order, and then each unique number is counted to get the distribution. 

You should see that the average sequence length has reduced by 6.

We can also use cutadapt to remove primers. Unlike indices, which are not valid DNA sequences but artificial sequences we added, primer regions reflect real DNA sequence data. However, because we used degenerate primers, we cannot be certain that the amplified region of the primer sequence is exactly identical to that region on our source DNA, because primers do not always bind perfectly. So this region must be discarded.

Performing primer removal
=========================

This process is very similar to demultiplexing, except we only have one sequence to remove, rather than three, and we only want one output file for each input file. The power of cutadapt’s paired-file-aware approach is that again, we can filter out any mate pairs that don’t have both primers - this is definitely a mark of a sequencing error! 

.. damonition:: Exercise
	First, create another new directory in our parent directory for the trimming output.
	
	Making sure you’re in the parent directory, try and adapt our demultiplexing command to trim the primers (the sequences are given again below) from one of the demultiplexed file pairs. You will want to add the parameter ``--discard-untrimmed`` ​. We could have added this to demultiplexing to remove all “unknown” files as well.
	.. topic:: Forward(R1)
	.. parsed-literal::
		CCNGAYATRGCNTTYCCNCG
	
	.. topic:: Reverse (R2)
	.. parsed-literal::
		TANACYTCNGGRTGNCCRAARAAYCA
	
	Cutadapt is aware of ambiguous bases so it’s fine to use the primer sequences as-is. The primers should have been consecutive with the indices, so now must be at the start of the reads: thus you can use ​^ to anchor the sequence as before. You don’t need to name the primer sequences (``XX=``), and you don’t need to use ``{name}``  in the output - the file name will do. Try running  your command, if it doesn’t work, check the solution below

.. admonition:: Solution
	:class: toggle
	.. code-block:: bash
		$ cutadapt -g ^CCNGAYATRGCNTTYCCNCG -G ^TANACYTCNGGRTGNCCRAARAAYCA \
		> -o 2_trimmed/T11_R1.fastq -p 2_trimmed/T11_R2.fastq --discard-untrimmed \
		> 1_demux/T11_R1.fastq 1_demux/T11_R2.fastq

Make sure to look over the output from cutadapt because this is very informative. You’ll notice now that some errors are being allowed, since these sequences are longer and so the default 10% allows 2 errors in these primers. Additionally you’ll notice that unlike with the indices, the length of sequence removed has varied slightly. We’ll come back to this.

We want to run this on all of our files, ideally without writing the command over and over. We can put this in a loop using bash. Since we need all of the unique samples, we first need to design a command for listing these:

.. code-block:: bash 
	
	$ ls 1_demux/* | cut -d_ -f1 | sort | uniq

This extracts the part of each name before the first ​_ and finds the unique ones. We can then use this as the basis of a loop:

.. code-block:: bash 

	$ ls 1_demux/ | cut -d_ -f1 | sort | uniq |
	> while read s \
	> do \
	> 	cutadapt -g ^CCNGAYATRGCNTTYCCNCG -G ^TANACYTCNGGRTGNCCRAARAAYCA \
	> 	-o 2_trimmed/${s}_R1.fastq -p 2_trimmed/${s}_R2.fastq --discard-untrimmed \ 
	>	 1_demux/${s}_R1.fastq 1_demux/${s}_R2.fastq \
	> done

Remember that you can write this as a single line, placing ``;`` before ``do`` and ``done``:

.. code-block:: bash
	$  ls 1_demux/ | cut -d_ -f1 | sort | uniq | while read s; do cutadapt -g ^CCNGAYATRGCNTTYCCNCG -G ^TANACYTCNGGRTGNCCRAARAAYCA -o 2_trimmed/${s}_R1.fastq -p 2_trimmed/${s}_R2.fastq --discard-untrimmed 1_demux/${s}_R1.fastq 1_demux/${s}_R2.fastq done

The read command reads from the piped list command, and the while command works through this bit-by-bit. The ``​$s`` therefore refers to each sample name in turn - note that ``​${s}`` is used where we want to add a ​_ immediately after, otherwise bash will look for a variable called ``$s_R1``.

Check your trimmed directory to make sure you have all of your files, and check back through the terminal output to make sure that you didn’t miss any errors. As always, review your read numbers.

Next steps
==========

We have generated another set of files, with the primers trimmed and some mate pairs rejected for not having the primer sequence present. 

If you want to explore more about the quality settings of primer removal, there are some further exercises :ref:`here<quality_settings>`, but this isn't necessary for the next step.

Next we join these mate pairs together into single reads representing individual amplicon sequences: :ref:`3. Pair Merging<pair_merging>`.

