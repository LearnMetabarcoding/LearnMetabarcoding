===================================
Data concatenation
===================================

Now have complete set of sequence reads with extraneous sequence removed and read pairs brought together.

Metabarcoding works on all sequence reads from across the dataset to find OTUs, and it’s more efficient if we do the following steps with all reads compiled into one file. In theory this can be done at any point in the pipeline, but this seems like a convenient point.

We could simply use the ``cat`` command to concatenate all the files, but then we’d lose information about what reads come from what sample and this is important later. So we add the sample name to the header of each read prior to concatenation using the following command. Before you run this, make sure you’re in the directory containing your merged sequences.

.. code-block:: bash 

	$ for f in *; do \   # ​↓​ the space here should be included!
	> sed -e "s/\(^@D00.*\) .*$/\1;sample=${f%.*};/" $f \
	> >> ../mbc_concat.fastq; \
	> done

This command loops through all the files in the directory. For each file, the ``sed`` command using regular expression substitution to add a string to the end of each header line containing the sample name, and adds the entire file to the end of a single file in the parent directory called ``​mbc_concat.fastq​``. Regular expressions are a very powerful part of coding that I suggest you learn at some point if you don’t know about them already. There are plenty of tutorials on the internet.

Return to the parent directory, use ``grep`` to count the number of sequences in ``​mbc_concat.fastq`` ​and view the ``​head​`` of the file. We will use this file in the next practical.
