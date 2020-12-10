.. _data_concat:

===================================
4. Data concatenation
===================================

Introduction
============

At this point we have a set of sequence reads for each sample with extraneous sequence removed and read pairs brought together. Metabarcoding works on all sequence reads from across the dataset to find OTUs, and it’s more efficient if we do the following steps with all reads compiled into one file. 

.. sidebar:: Pipeline design choices
	We present this step here because it allows us to separate two distinct themes: the processing of raw sequence reads into samples, in this section, and the filtering of processed sequence reads to remove errors, in the next section. However, when performing metabarcoding bioinformatics it may be more efficient to perform this task after quality filtering, since quality filtering substantially reduces the data size. We detail this alternative `here <>` TODO

Performing concatenation
========================
We could simply use the ``cat`` command to concatenate all the individual sample files into one big file, but then we’d lose information about what reads come from what sample and this is important later. 

So we add the sample name to the header of each read prior to concatenation using the following command. Before you run this, make sure you’re in the directory containing your merged sequences.

.. code-block:: bash 

	$ for f in * \
	> do \                     # ​↓​ the space here should be included!
	> 	sed -e "s/\(^@D00.*\) .*$/\1;sample=${f%.*};/" $f \
	> 	>> ../mbc_concat.fastq \
	> done

This command loops through all the files in the directory. For each file, the ``sed`` command uses regular expression substitution to add a string to the end of each header line containing the sample name, and adds the entire file to the end of a single file in the parent directory called ``​mbc_concat.fastq​``. See :ref:`here <sed>` to learn more about ``sed``.

Note the ``>>`` symbol. We use this to *append* to a file, rather than overwriting it. This allows to add to it every iteration of the loop. Be careful though: the first iteration of the loop will create this file if it doesn't exist, but if it already exists it will just add to it. So if you make a mistake and need to re-run this loop, you should delete the output file (``rm ../mbc_concat.fastq``) so you don't just keep adding to one huge file.

.. admonition:: Exercise
	Return to the parent directory, use ``grep`` to count the number of sequences in ``​mbc_concat.fastq`` ​and view the ``​head​`` of the file.
	

Next Steps
==========

We have generated a master file containing all sequences from across all of our samples. These sequences still contain quality data, which will be useful for filtering in the next section.

To read about the next section, we recommend starting with the `introduction to filtering amplicon data <filtering>`. 

If you've read this before, you can skip directly to the next step: `1. Quality filtering <quality_filtering>`
