.. _pair_merging:

==================================
3. Pair merging
==================================

.. toctree::
	:hidden:

	extensions/pair_concat

Introduction
============

These metabarcoding libraries were sequenced such that 300bp of our fragment was read from each end. When we designed our primers from complete mitochondrial genome sequences, we examined the expected amplicon and we know that there should be **418bp** of sequence between the primers. Given that this is much shorter than :math:`2 * 300`, there should be overlap between the forward and reverse fragments, and we can use this to assemble the complete amplicon sequence 

.. admonition:: Exercise
	* You know from previous sections how much index and primer sequence was trimmed from each end. How much sequence should we have left in each direction?
	
	* How much should these sequences overlap?

.. admonition:: Solution
	:class: toggle
	
	The forward primer is 20 bases long, plus a 6 base index gives 26 bases. Thus the forward reads should be :math:`300 - 26 = 274` bases long now
	The reverse primer is 26 bases long, plus a 6 base index gives 32 bases. Thus the reverse reads should be :math:`300 - 32 = 268` bases long now
	
	The total amount of read sequence is therefore :math:`274 + 268 = 542` bases. Since the fragment was only 418 bp, this leaves :math:`542 - 418 = 124` overl apping bases.
	
	For further illustration, consider this miniture version: here our reads are 10 bases long and the overall sequenced region is 14 bases. The length of the overlap is :math:`10 + 10 - 14`
	
	.. parsed-literal::
		**R1**  AACGTAGCAA
		**R2**      TAGCAAGCAT

The overlap between our reads is definitely enough to be able to confidently assemble each pair together, and each pair of the primer-trimmed files can now become one.

Sequence quality
================

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

Pair Merging with PEAR
======================

We will use PEAR for merging. As always, check out the helpfile for PEAR:

.. code-block:: bash 
	
	$ pear --help

Not too many options. Try running PEAR on a single pair of your primer-trimmed files from the previous section, after creating a new directory to hold merged files. The output should be the first part of the name - PEAR will add to this for the output files

.. code-block:: bash 

	$ pear -f ​in_R1.fastq​ -r ​in_R2.fastq​ -o ​merged/out

PEAR gives us some really informative information on the terminal, make sure to review it. As you’ll have seen from the helpfile, there are many different thresholds that can be applied to the merging.

.. admonition:: Exercise

	1. Run your command again, applying a sensible minimum overlap based on what we calculated earlier. 

	2. Run your command again, trying out some different p values and quality thresholds. The former is the threshold probability of an overlap being incorrect, the latter is the threshold score for trimming off low quality read ends.

I generally set the quality threshold for trimming low quality ends to 26, and the minimum overlap to a value around 20-30 bases less than the presumed overlap length. These sequences are pretty good quality so these settings won’t reject much more than the default in this case. 

Clean up your experimentation by removing the output files

Running PEAR in a loop
======================

Like with cutadapt, we can run PEAR in a loop to apply it to all of our samples: again, we list our files to find our unique samples, then loop on these and use each sample name to run an iteration of PEAR. Here my command assumes your files are in a directory called 2_trimmed and you’re outputting to a directory called 3_merged - you should modify these as necessary:

.. code-block:: bash 

	$ samples=$(ls 2_trimmed/ | cut -d_ -f1 | sort | uniq)
	$ for s in $samples \
	> do \
	>	pear -f 2_trimmed/${s}_R1.fastq -r 2_trimmed/${s}_R2.fastq \
	>	-o 3_merged/$s -q 26 -v 100 \
	> done

Make sure to review those terminal outputs! Then list the contents of your merged directory, you’ll see files for the assembled, unassembled and discarded reads. We don’t need the latter two, so let’s clean up:

.. code-block:: bash 

	$ cd 3_merged
	$ rm *discarded* *unassembled* && rename -e "s/assembled\.//" *
	$ cd ../

The ``&&`` here runs both commands on this line one after the other. We could use ``;`` instead, but ``&&`` only runs the second command if the first one succeeds. This is important because the ``rename`` command uses regular expressions to remove the "assembled followed by a full stop" part from any files with that in the name. If we hadn't removed any files with "unassembled" in the name, then that would have renamed them too!

.. sidebar:: Alternatives to PEAR
	Read merging is a very important and very sensitive step in the pipeline, so it is important to select software that is sufficiently feature-rich and has been developed with careful consideration to the problem. 
	
	We use PEAR because it's a standalone read merging tool with a probabilistic approach to the merging task, and it works well for our data. However, it can sometimes be a little temperamental if your reads aren't precisely paired up or if you have any extraneous very short reads present in your data. Usually in these cases it just fails with a vague error - which isn't great but is better than doing something wrong.
	
	An alternative to pair is the ``fastq_mergepairs`` tool within the VSEARCH and USEARCH packages. This has some fewer features but is very widely used. Another tool frequently used is `FLASH <http://ccb.jhu.edu/software/FLASH/>`_

Sequence loss
=============

You may have noticed that we lose a large number of sequences here. This is completely normal: we must be very strict at the pair merging step to ensure that: 

1. We correctly merge a true read pair so as not to generate spurious sequence or erroneously remove sequence
2. We do not incorrectly merge a false read pair causing a chimeric sequence

We achieve this by using strict quality and overlap settings, and thus the quality of your sequence data will play a large role in the extent to which sequences, and indeed complete samples, may be lost at this stage. However, as always, the strictness of the parameters we choose should be guided by our research question and context. For example, if you have a comprehensive reference set for your target species, you could perhaps be more lax here, as you can filter out errors later on by strict comparison to your references. Generally though, the most rigourous approach is to be as conservative in your settings as you can.

Next Steps
==========

We've generated complete amplicon sequence reads now, so we're getting close to being done with Read Processing.

In our example our read lengths are long enough compared to our fragment length so that they overlap. This isn't always the case. If there is no overlap then one option is to concatenate the mate pairs instead of merging. The other option would be to use only one of the directions, or to split the pipeline here and analyse each direction separately. If you'd like to know more about concatenation, then take a look at the :ref:`pair concatenation extension<pair_concatenation>`. This is not necessary for the next steps.

The next step is :ref:`4. Data Concatenation<data_concat>`.

