.. _pair_merging:

==================================
Pair merging
==================================

.. toctree::
	:hidden:

	extensions/pair_concat

These reads were sequenced such that 300bp of our fragment was read from each end. There should be 418bp of sequence between the primer pair.

* You know from previous sections how much index and primer sequence was trimmed from each end. How much sequence should we have left in each direction?

* How much should these sequences overlap?

This overlap between these is definitely enough to be able to confidently assemble each pair together, and each pair of the primer-trimmed files can now become one, by merging the mate pairs together by finding where the sequence overlaps.


An important consideration when pair merging is that, in general, sequence reads decline in quality along their length. This quality information is stored in the FASTQ file - it would be a lot of work to check all of our sequences manually, but there are some ways to summarise the quality scores. It’s good practice to do this with your reads at this point

One very popular option is to use the program FastQC. You can run it on a single file like this:

.. code-block:: bash 

	$ fastqc ​in.fastq

You can view the output of FastQC by using your FTP software (e.g. FileZilla) to access the server, navigating to the directory in which you ran fastqc and opening the html file with the same name as your file. There are lots of useful graphs, but the first one is key here.

If you don’t want to have to use your FTP software, one fun way of checking a file’s quality with output on the command line is fastqe:

.. code-block:: bash 

	$ fastqe --bin ​in.fastq


The ends away from the primer are the parts that the merging algorithm is attempting to match, and you’ll notice these tend to be lower quality. This leads to two considerations:

1. It is important to be aware of quality scores when merging, since erroneous sequence could cause the merging of reads that are not the same fragment, forming a chimera

2. However, merging can actually provide some validation of quality and improve quality scores for the overlap region if it matches.

As always, check out the helpfile for PEAR:

.. code-block:: bash 
	
	$ pear --help

Not too many options. Try running PEAR on a single pair of your primer-trimmed files from the previous section, after creating a new directory to hold merged files. The output should be the first part of the name - PEAR will add to this for the output files

.. code-block:: bash 

	$ pear -f ​in_R1.fastq​ -r ​in_R2.fastq​ -o ​merged/out

PEAR gives us some really informative information on the terminal, make sure to review it. As you’ll have seen from the helpfile, there are many different thresholds that can be applied to the merging.

* Run your command again, applying a sensible minimum overlap based on what we calculated earlier.

* Run your command again, trying out some different p values and quality thresholds. The former is the threshold probability of an overlap being incorrect, the latter is the threshold score for trimming off low quality read ends.

I generally set the quality threshold for trimming low quality ends to 26, and the minimum overlap to a value around 20-30 bases less than the presumed overlap length. These sequences are pretty good quality so these settings won’t reject much more than the default in this case. Clean up your experimentation.

Like with cutadapt, we can run PEAR in a loop to apply it to all of our samples: again, we list our files, find our unique samples, then loop on these and use each sample name to run an iteration of PEAR. Here my command assumes your files are in a directory called 2_trimmed and you’re outputting to a directory called 3_merged - you should modify these as necessary:

.. code-block:: bash 

    $ while read l; do pear -f 2_trimmed/${l}_R1.fastq -r 2_trimmed/${l}_R2.fastq -o 3_merged/$l -q 26 -v 100; done < <(ls 2_trimmed/ | cut -d_ -f1 | sort | uniq)

Make sure to review those terminal outputs! Then list the contents of your merged directory, you’ll see files for the assembled, unassembled and discarded reads. We don’t need the latter two, so let’s clean up:

.. code-block:: bash 

	$ cd 3_merged
	$ rm *discarded* *unassembled* && rename -e "s/assembled\.//" *
	$ cd ../

The ``&&`` here runs both commands on this line one after the other. The ``rename`` command uses regular expressions to remove the “assembled followed by a full stop” part from any files with that in the name.

In our example our read lengths are long enough compared to our fragment length so that they overlap. This isn't always the case. If there is no overlap then the sequnces are concatenated 
not merged. If you'd like to know more about this look at the :ref:`pair concatenation extension<pair_concatenation>`.

