.. _more_variable:

.. role:: var

==================================================
Extension: What if we have a more variable region?
==================================================

What if we have a coding region like CO1 where we expect no single-base indels, but overall the region is more variable (or we have a wider range of taxa) and we might see real established whole-codon insertions or deletions?

.. admonition:: Exercise
	
	* First, think about how we might specify a filter for this - assuming the same target length of 418bp, what lengths might we allow?

As it happens, it doesn’t seem that there are any programs out there that do this filtering already. One way to do it is filter by each length separately, and then concatenate the results.

.. admonition:: Exercise
	
	* Can you design a command or set of commands that can do this from what we've already covered? 
	* Bonus points if you can do it in a loop, but it's not necessary!
	

.. admonition:: Solution
	:class: toggle
	
	We filter for each length, one at a time, and join the results into a single file.
	
	.. parsed-literal::
		
		vsearch --fastx_filter :var:`input.fasta` --fastq_minlen 415 --fastq_maxlen 415 --fastaout output415.fasta
		vsearch --fastx_filter :var:`input.fasta` --fastq_minlen 418 --fastq_maxlen 418 --fastaout output418.fasta
		vsearch --fastx_filter :var:`input.fasta` --fastq_minlen 421 --fastq_maxlen 421 --fastaout output421.fasta
		cat output415.fasta output418.fasta output421.fasta > :var:`output.fasta`
	
	Of course, we could also do this in a loop:
	
	.. parsed-literal::
		
		for l in 415 418 421;
		do
			vsearch --fastx_filter :var:`input.fasta` --fastq_minlen $l \\
			--fastq_maxlen $l --fastaout output_${l}_ctrim.fasta;
		done &&
		cat \*ctrim.fasta > :var:`output.fasta`
	
	When we're running loops, we want to make sure it worked properly, so let's check the number of sequences in the relevant files:
	
	.. parsed-literal::
		
		grep -c "^>" \*ctrim.fasta
