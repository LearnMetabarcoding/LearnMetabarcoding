.. _phred_scores:

==========================
Fundamentals: Phred Scores
==========================

We have seen that the strings of letters in FASTQ files stand for quality values, but what do these values actually mean? Phred scores are not just some arbitrary values. They are actually logarithmically related to the probability of a base calling error. Given a phred score :math:`S`, the probability of the base being incorrect :math:`P` is:

.. math:: 

	P=10^{^{-S}/_{10}}

So a phred score of :math:`S=10` gives :math:`P=0.1`, meaning there is a 10% chance of error. A score of :math:`S=20` means a 1% chance of error (:math:`P=0.01`), and :math:`S=30` means a 0.1% chance of error (:math:`P=0.001`).

Given this knowledge, we can use the Phred scores to calculate the number of expected errors over a sequence, by converting each base’s quality score into a probability and then summing the probabilities.

.. admonition:: Exercise

	Given the below FASTQ, convert the phred scores to probabilities (look up the :math:`S` values for each character on the FASTQ wikipedia page), then calculate the number of expected errors.

	.. parsed-literal::
		
		\@sequence1
		AGTACTGCGC
		+
		\@EB>9:7/.(&

.. admonition:: Solution
	:class: toggle
	
	.. math::
		
		S = {31,36,33,29,24,25,22,15,14,8,5}
		
		P = {0.0008, 0.0003, 0.0005, 0.001, 0.004, 0.003, 0.006, 0.03, 0.04, 0.2, 0.3}
		
		E = 0.56
	

You can now continue with the rest of the :ref:`quality filtering tutorial<quality_filtering>`.
