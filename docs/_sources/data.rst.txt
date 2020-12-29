.. _data:

============
Example data
============

Introduction
============

In 2014 and 2015, we sampled arthropod communities from the canopies of rainforest trees in Cusuco National Park, Honduras. These samples were processed at the Natural History Museum, London, where we homogenised the samples and carried out metabarcoding amplification for a 418bp section of the CO1 Folmer "barcode" region. These were sequenced on an Illumina HiSeq using a 2x300bp read metric.
e
We have taken a few of these samples and modified them to reduce their size while preserving realistic sequence variation and errors. These samples form the example dataset we provide for you to use as you work through the different sections of these resources.

Getting the data
================

We provide the data in five zip archives, one for each section. Each section's data archive provides starting data for most or all tutorials in that section, so you can choose to use just the starting data for the first tutorial, processing it yourself and then using your own results for each subsequent tutorial, or you can pick and choose what tutorials you want to work on and the pre-processed starting data will be there for you. Each tutorial page clearly details which data you should use for that tutorial.

There are two possible ways you can acquire the data:

1. Download the data using the links below to your personal computer, then if you're using a remote server for your bioinformatics you can transfer the files using FTP or another transfer protocol
2. Copy the links below and use the ``wget`` or ``curl`` commands in Linux to download the file directly to the server you're using, as shown in the example below.

Data URLs
=========


.. _sectionAdata:
Section A: Read processing
--------------------------


.. _sectionBdata:
Section B: Filtering amplicon data
----------------------------------


.. _sectionCdata:
Section C: ASVs, OTUs and read mapping
--------------------------------------


.. _sectionDdata:
Section D: Building OTU phylogeny
---------------------------------


.. _sectionEdata:
Section E: Identifying OTU sequences
------------------------------------



Downloading the data in Linux
=============================

First, create and navigate to the folder where you want to store the downloaded data. For example, we'll make this a folder called ``exampledata``

.. parsed-literal::
	
	mkdir exampledata
	cd exampledata

Download the data, unzip it and list the contents

.. parsed-literal::
	
	wget URL
	unzip SectionA.zip
	ls SectionA

We suggest actually working through the tutorials in a separate directory, so as to keep the example data from getting mixed up with the data that you produce. For example, you might decide to work through the tutorials in a directory called ``tutorialwork``. The below code shows how you would set this up and copy over the data for the very first tutorial. Note that the first data is a directory of files, so we use ``cp -r``.

.. parsed-literal::
	
	cd ../  # Return up to the main directory
	mkdir tutorialwork
	cd tutorialwork
	cp -r ../exampledata/SectionA/0_rawsequences/ ./

