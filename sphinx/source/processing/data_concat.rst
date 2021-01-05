.. _data_concat:

.. role:: var

=====================
4. Data concatenation
=====================

Introduction
============

At this point we have a set of sequence reads for each sample with extraneous sequence removed and read pairs brought together. Metabarcoding works on all sequence reads from across the dataset to find OTUs, and it’s more efficient if we do the following steps with all reads compiled into one file. 

.. admonition:: Data and software
	:class: green
	
	The input data for this section is a directory of FASTQ (or FASTA) format files, one per sample, with primer and index sequences removed and mate pairs merged or concatenated. If you're following along step-by-step, this was produced in :ref:`the previous tutorial<pair_merging>`. Alternatively, the ``3_merged`` directory within the :ref:`sectionA archive<sectionAdata>` can be used as example data.
	
	This tutorial uses the :ref:`cutadapt software. <cutadapt>`
	

.. admonition:: Note
	:class: green
	
	If you're following along step-by-step, we present this step at this stage because it allows us to separate two distinct themes: the processing of raw sequence reads into samples, in section A, and the filtering of processed sequence reads to remove errors, in the section B. In this case, your input files would be FASTQs, so you'd use the first part of this tutorial.
	
	However, when performing metabarcoding bioinformatics it may be more efficient to perform this task after quality filtering, since quality filtering substantially reduces the data size. If you wanted to do this, the input files would be FASTAs, so you'd use the second part of this tutorial.

Performing concatenation
========================

We could simply use the ``cat`` command to concatenate all the individual sample files into one big file, but then we’d lose information about what reads come from what sample and this is important later. So, as part of the concatenation we will also modify the headers of each of our files to contain the file name.

FASTQ files
-----------

If you're following along step-by-step, we'll be working on a set of FASTQ files. As we've seen previously using ``grep``, it's not necessarily straightforward to identify the lines corresponding to headers in FASTQ files, because quality lines can also start with ``@``. However, in this case we know that our headers start with ``@D00`` and we can use this to our advantage. If you're using your own data, you should use ``head`` to check what your headers start with. 

To run the following command, your working directory should be the directory containing the sequences you want to concatenate, namely the directory of FASTQ files that have indices and primers removed, and pairs merged.

:guilabel:`Run the following command, making sure to replace ``output.fastq`` with a sensible name`

.. parsed-literal::

	for f in \*;
	do                       # ​↓​ the space here should be included!
		sed -e "s/\\(^\@D00.\*\\) .\*$/\\1;sample=${f%.\*};/" $f \\
		>> ../:var:`output.fastq`;
	done

.. admonition:: How this command works
	:class: togglegreen
	
	This command loops through all the files in the directory. For each file, the ``sed`` command uses regular expression substitution to add a string to the end of each header line containing the sample name, and adds the entire file to the end of a single file in the parent directory called ``output.fastq​``. See :ref:`here <sed>` to learn more about ``sed``.
	
	
	Note the ``>>`` symbol. We use this to *append* to a file, rather than overwriting it. This allows to add to it every iteration of the loop. Be careful though: the first iteration of the loop will create this file if it doesn't exist, but *if it already exists it will just add to it*. So if you make a mistake and need to re-run this loop, you should delete the output file (``rm ../output.fastq``) so you don't just keep adding to one huge file.
	

.. admonition:: Exercise

	Return to the parent directory, use ``grep`` to count the number of sequences in output file ​and view the ``​head​`` of the file to check that we've correctly added the sample names to the headers.

FASTA files
-----------

If you instead have a directory of FASTAs, the command is pretty much the same, but we don't have to worry about FASTQ header format. Again, to run this command your working directory should be the directory containing the sequences you want to concatenate.

.. parsed-literal::

	for f in \*;
	do                     # ​↓​ the space here should be included!
		sed -e "s/\\(^>.\*\\) .\*$/\\1;sample=${f%.\*};/" $f \\
		>> ../:var:`output.fasta`;
	done

:guilabel:`Can you spot the difference?`

Next Steps
==========

We have generated a master file containing all sequences from across all of our samples. These sequences still contain quality data, which will be useful for filtering in the next section.

If you're following along step-by-step, we recommend heading to the next section: :ref:`B. Filtering amplicons <filtering>`. 
