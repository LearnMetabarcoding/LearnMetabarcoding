.. _primer_removal:

.. role:: var

============================================
2. Primer removal
============================================

.. toctree::
	:hidden:

	extensions/quality_settings_extension

Introduction
============

When performing demultiplexing, **cutadapt** removed the indices from our samples. You can check this using the ``grep`` command from the previous tutorial. Alternatively, you can use the following command to explore the length distribution of the sequences. Run this on a pre- and post- demultiplexed file.

.. parsed-literal::

	sed -n '2~4p'​ :var:`input.fastq​` | while read l; do echo ${#l} ; done | sort | uniq -c

.. admonition:: How this command works
	:class: togglegreen

	The ``sed`` command ​p​rints only every 4th line, starting at the 2nd. This is sent to a ``while`` loop, which reads each line and stores it in ``l`` ​. The loop outputs the number of characters in the ``l`` variable, one per line. These are then sorted into alphanumeric order, and then each unique number is counted to get the distribution. 

You should see that the average sequence length has reduced by 6.

We can also use **cutadapt** to remove primers. Unlike indices, which are not valid DNA sequences but artificial sequences we added, primer regions reflect real DNA sequence data. However, because we used degenerate primers, we cannot be certain that the amplified region of the primer sequence is exactly identical to that region on our source DNA, because primers do not always bind perfectly. So this region must be discarded.

.. admonition:: Data and software
	:class: green

	The input data for this section is a directory of FASTQ format file pairs, one pair per sample, with primer sequences at (or near) the beginning of each read. If you're following along step-by-step, this was produced in :ref:`the previous tutorial<demultiplexing>`. Alternatively, the ``1_demux`` directory within the :ref:`sectionA archive<sectionAdata>` can be used as example data.
	
	This tutorial uses the :ref:`cutadapt software <cutadapt>`.

Performing primer removal
=========================

This process is very similar to demultiplexing, except we only have one sequence to remove, rather than three, and we only want one output file for each input file. The power of **cutadapt**'s paired-file-aware approach is that again, we can filter out any mate pairs that don’t have both primers - this is definitely a mark of a sequencing error! 

.. admonition:: Exercise

	First, create another new directory in our parent directory for the trimming output.
	
	Making sure you’re in the parent directory, try and adapt our demultiplexing command to trim the primers (the sequences are given again below) from one of the demultiplexed file pairs. You will want to add the parameter ``--discard-untrimmed`` ​. We could have added this to demultiplexing to remove all "unknown" files as well.
	
	**Forward(R1)**

	.. parsed-literal::

		CCNGAYATRGCNTTYCCNCG
		
	**Reverse (R2)**

	.. parsed-literal::

		TANACYTCNGGRTGNCCRAARAAYCA
		
	**Cutadapt** is aware of ambiguous bases so it’s fine to use the primer sequences as-is. The primers should have been consecutive with the indices, so now must be at the start of the reads: thus you can use ​^ to anchor the sequence as before. You don’t need to name the primer sequences (``XX=``), and you don’t need to use ``{name}``  in the output - the file name will do. Try running  your command, if it doesn’t work, check the solution below.

.. admonition:: Solution
	:class: toggle
	
	Make sure you change ``output`` in the command below to the name of the new directory you created to store these files in. We're assuming the directory with your files is named ``1_demux``, if it isn't, make sure to change that below as well.
	
	.. parsed-literal::

		cutadapt -g ^CCNGAYATRGCNTTYCCNCG -G ^TANACYTCNGGRTGNCCRAARAAYCA \\
		-o :var:`output`/T11_R1.fastq -p :var:`output`/T11_R2.fastq --discard-untrimmed \\
		1_demux/T11_R1.fastq 1_demux/T11_R2.fastq

Make sure to look over the output from **cutadapt** because this is very informative. You’ll notice now that some errors are being allowed, since these sequences are longer and so the default 10% allows 2 errors in these primers. Additionally you’ll notice that unlike with the indices, the length of sequence removed has varied slightly. We’ll come back to this.

We want to run this on all of our files, ideally without writing the command over and over. We can put this in a loop using bash. Since we need all of the unique samples, we first need to design a command for listing these:

.. parsed-literal:: 
	
	ls 1_demux/ | cut -d\_ -f1 | sort | uniq

This extracts the part of each name before the first ​``_`` and finds the unique ones. We can then store this list of library names in a bash variable, and check it's contents with ``echo``:

.. parsed-literal:: 
	
	samples=$(ls 1_demux/ | cut -d\_ -f1 | sort | uniq)
	echo $samples

We can then loop on the contents of this variable using ``for``

.. parsed-literal:: 

	for s in $samples;
	do
		cutadapt -g ^CCNGAYATRGCNTTYCCNCG -G ^TANACYTCNGGRTGNCCRAARAAYCA \\
		-o :var:`output`/${s}_R1.fastq -p :var:`output`/${s}_R2.fastq --discard-untrimmed \\
		1_demux/${s}_R1.fastq 1_demux/${s}_R2.fastq \\
	done

Remember that you can write this as a single line without the ``\`` if you want:

.. parsed-literal::

	for s in $samples; do cutadapt -g ^CCNGAYATRGCNTTYCCNCG -G ^TANACYTCNGGRTGNCCRAARAAYCA -o :var:`output`/${s}_R1.fastq -p :var:`output`/${s}_R2.fastq --discard-untrimmed 1_demux/${s}_R1.fastq 1_demux/${s}_R2.fastq done

The read command reads from the piped list command, and the while command works through this bit-by-bit. The ``​$s`` therefore refers to each sample name in turn - note that ``​${s}`` is used where we want to add a ​_ immediately after, otherwise bash will look for a variable called ``$s_R1``.

Check your trimmed directory to make sure you have all of your files, and check back through the terminal output to make sure that you didn’t miss any errors. As always, review your read numbers.

.. warning::

	To run these loops, we generated a list of our unique sample names by listing our files and then editing the text to remove file extensions and direction information, as reprinted below.
	
	.. parsed-literal:: 
		
		samples=$(ls 1_demux/ | cut -d\_ -f1 | sort | uniq)
	
	If you have your own data, your file names are likely to be different and the exact code used above may not work! You will need to come up with your own version. If you have multiple underscores in your file names, but the number of underscores is consistent, you could simply tweak the number given to ``cut -f``. Otherwise, you might need to use ``sed`` to remove parts of the names, or even use ``rename`` to rename the files to something that will work.
	

Next steps
==========

We have generated another set of files, with the primers trimmed and some mate pairs rejected for not having the primer sequence present. 

If you want to explore more about the quality settings of primer removal, there are some further exercises :ref:`here<quality_settings>`, but this isn't necessary for the next step.

Next we join these mate pairs together into single reads representing individual amplicon sequences: :ref:`3. Pair merging<pair_merging>`.

