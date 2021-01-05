.. _installing_software:

.. role:: comment

=====================
Software installation
=====================

Here we detail how to install all Linux command-line software used in these resources. Note that if you are setting up a server from scratch, for example if you are using a :ref:`cloud server<cloud_servers>`, you should also ensure that you perform any necessary administration tasks and install and configure any necessary security software you need.

These commands are written for Ubuntu Linux. They will probably work fine on any Ubuntu or Debian machine, and on most Linux machines with the appropriate package manager changes.

We supply these instructions with absolutely no guarantee or warranty. If you break a machine following these instructions, it's not our fault. If you fail to properly secure a cloud server and have it compromised and used to spam people or launch crippling viruses, it's not our fault. If in doubt, seek expert advice.

These commands use the most recent software versions as of December 2020, where the code points to a specific version you should make sure to look up the most recent version and edit accordingly.

Setup
=====

The following commands install some general purpose Linux tools and libraries. 
.. parsed-literal::
	
	:comment:`# Setup directories`
	sudo mkdir /usr/local/deb/
	
	:comment:`# Install general tools`
	sudo apt update && sudo apt upgrade -y
	sudo apt install build-essential pkg-config autoconf python3-pip unzip groff libgsl-dev rename default-jre zip -y
	
	:comment:`# Install programming languages and language modules`
	sudo apt install bioperl libdbd-sqlite3-perl libjson-perl perl-doc python3-biopython python-scipy libarray-utils-perl -y

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _alan:

ALAN
----

Commandline alignment viewer. `Github<https://github.com/mpdunne/alan>`_

.. parsed-literal::
	
	sudo wget -P /usr/local/bin/ https://raw.githubusercontent.com/mpdunne/alan/master/alan
	sudo chmod a+x /usr/local/bin/alan

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _blast:

BLAST
-----

Widely used sequence searching software. `Documentation. <https://www.ncbi.nlm.nih.gov/books/NBK279690/>`_

.. parsed-literal::
	cd /usr/local/src/
	
	BLAST_VERSION="2.11.0" :comment:`# Change as appropriate`
	sudo wget "ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/${BLAST_VERSION}/ncbi-blast-${BLAST_VERSION}+-x64-linux.tar.gz"
	sudo tar -zxf ncbi-blast-${BLAST_VERSION}+-x64-linux.tar.gz
	sudo cp ncbi-blast-${BLAST_VERSION}+/bin/\* /usr/local/bin/

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _bPTP:

bPTP
----

Bayesian phylogeny-based species delimitation. `Website. <https://github.com/zhangjiajie/PTP>`_

.. parsed-literal::
	
	cd /usr/local/src
	sudo git clone https://github.com/zhangjiajie/PTP
	cd PTP
	sudo -H python3 -m pip install -r requirements.txt
	cd /PTP/bin
	for f in \*.py; do sed -i "1s/python$/python3/" $f; done
	sudo ln -s /usr/local/src/PTP/bin/bPTP.py /usr/local/bin/bPTP
	sudo ln -s /usr/local/src/PTP/bin/PTP.py /usr/local/bin/PTP

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _catfasta2phyml:

catfasta2phyml
--------------

Script for concatenating alignments into a supermatrix. `Website. <https://github.com/nylander/catfasta2phyml>`_

.. parsed-literal::
	
	sudo wget -O /usr/local/bin/ https://raw.githubusercontent.com/nylander/catfasta2phyml/master/catfasta2phyml.pl
	sudo chmod a+x /usr/local/bin/catfasta2phyml.pl

Installation not necessary: you could simply download it to your working directory and run it using ``perl``:

.. parsed-literal::
	
	wget /usr/local/bin/ https://raw.githubusercontent.com/nylander/catfasta2phyml/master/catfasta2phyml.pl
	perl catfasta2phyml.pl

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _crop:

CROP
----

Bayesian OTU delimitation. `Github<https://github.com/tingchenlab/CROP>`_

.. parsed-literal::
	
	sudo apt install libgsl-dev :comment:`# (installed above)`
	
	cd /usr/local/src
	sudo git clone https://github.com/zhangjiajie/PTP
	cd PTP
	sudo -H python3 -m pip install -r requirements.txt
	sudo -H python3 -m pip install python-nexus
	sudo sed -i "1s/python$/python3/" bin/bPTP.py
	sudo ln -s /usr/local/src/PTP/bin/bPTP.py /usr/local/bin/bPTP

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _cutadapt:

Cutadapt
--------

Versatile adapter sequence removal. `Documentation<https://cutadapt.readthedocs.io/en/stable/>`_

.. parsed-literal::
	
	sudo -H python3 -m pip install cutadapt

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _extract_genes:

extract_genes
-------------

Script for extracting individual gene sequences from GenBank files. `Github<https://github.com/tjcreedy/biotools>`_

.. parsed-literal::
	
	sudo wget -O /usr/local/bin/ https://raw.githubusercontent.com/tjcreedy/biotools/master/extract_genes.pl
	sudo chmod a+x /usr/local/bin/extract_genes.pl

Installation not necessary: you coul simply download it to your working directory and run it using ``perl``:

.. parsed-literal::
	
	wget https://raw.githubusercontent.com/tjcreedy/biotools/master/extract_genes.pl
	perl extract_genes.pl

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _fasttree:

FastTree
--------

Fast maximum likelihood phylogenetic inference. `Website<http://www.microbesonline.org/fasttree/>`_

.. parsed-literal::
	
	cd /usr/local/bin/
	sudo wget http://www.microbesonline.org/fasttree/FastTree
	sudo wget http://www.microbesonline.org/fasttree/FastTreeMP
	sudo chmod a+x FastTree\*

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _fastqc:

FastQC
------

Raw sequence quality assessment. `Website<https://www.bioinformatics.babraham.ac.uk/projects/fastqc/>`_

.. parsed-literal::
	
	cd /usr/local/src/ 
	sudo wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
	sudo unzip fastqc_v0.11.9.zip
	sudo chmod a+x FastQC/fastqc
	sudo ln -s /usr/local/src/FastQC/fastqc /usr/local/bin/fastqc

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _fastx_toolkit:

FASTX Toolkit
-------------

Various handy tools for dealing with FASTA and FASTQ files. A little out of date though, requires patching to work in modern Ubuntu (all done in the below commands). `Website<http://hannonlab.cshl.edu/fastx_toolkit/index.html>`_ 

.. parsed-literal::
	
	cd /usr/local/src/
	
	sudo wget https://github.com/agordon/libgtextutils/releases/download/0.7/libgtextutils-0.7.tar.gz
	sudo tar -xzf libgtextutils-0.7.tar.gz
	cd libgtextutils-0.7
	sudo sed -i '47s/input_stream/static_cast<bool>(input_stream)/' src/gtextutils/text_line_reader.cpp
	sudo ./configure
	sudo make
	sudo make install
	cd ../
	
	sudo wget https://github.com/agordon/fastx_toolkit/releases/download/0.0.14/fastx_toolkit-0.0.14.tar.bz2
	sudo tar -xjf fastx_toolkit-0.0.14.tar.bz2
	cd fastx_toolkit-0.0.14
	sudo wget https://github.com/agordon/fastx_toolkit/files/1182724/fastx-toolkit-gcc7-patch.txt
	sudo patch -p1 < fastx-toolkit-gcc7-patch.txt
	sudo ./configure
	sudo make
	sudo make install
	cd ../

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _mafft:

MAFFT
-----

Sequence alignment. `Website<https://mafft.cbrc.jp/alignment/software/>`_

.. parsed-literal::
	
	sudo wget -P /usr/local/deb/ https://mafft.cbrc.jp/alignment/software/mafft_7.475-1_amd64.deb
	sudo apt install /usr/local/deb/mafft_7.475-1_amd64.deb

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _metamate_install:

metaMATE
--------

Tool for exploring detailed read frequency filtering thresholds. `Github<https://github.com/tjcreedy/metaMATE>`_
Requires :ref:`BLAST<blast>`, :ref:`MAFFT<mafft>` and :ref:`R<r>`


.. parsed-literal::
	
	sudo -H python3 -m pip install metaMATE
	sudo Rscript -e "install.packages(c('getopt', 'ape', 'fastcluster'), repos = 'https://cloud.r-project.org')"

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _pairfq:

Pairfq
------

Ensures paired read files are syncronised. `Github<https://github.com/sestaton/Pairfq>`_

.. parsed-literal::
	
	sudo apt install libdbd-sqlite3-perl  :comment:`# (installed above)`
	sudo curl -sL cpanmin.us | sudo perl - git://github.com/sestaton/Pairfq.git

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _pear:

PEAR
----

Paired end read merger. `Website<http://www.exelixis-lab.org/pear>`_
You must sign up for a PEAR academic licence and you will receive an email with a link to download the installation files. The command here assumes you've downloaded the file to your home directory.

.. parsed-literal::
	
	cd /usr/local/src/
	sudo cp ~/pear-0.9.11-linux-x86_64.tar.gz ./   :comment:`# Change the source path if necessary`
	sudo tar -xzf pear-0.9.11-linux-x86_64.tar.gz
	cd pear-0.9.11-linux-x86_64
	sudo cp bin/pear /usr/local/bin/
	sudo gzip man/pear.1
	sudo cp man/pear.1.gz /usr/share/man/man1/

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _r:

R
-

Versatile data handling language. `Website<https://cran.r-project.org/`_

.. parsed-literal::
	
	sudo apt install apt-transport-https
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
	sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
	sudo apt install r-base

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _swarm:

swarm
-----

Linkage-based OTU delimitation. `Github<https://github.com/torognes/swarm>`_

.. parsed-literal::
	
	
	cd /usr/local/src

	sudo git clone https://github.com/torognes/swarm.git
	cd swarm/
	sudo make
	sudo cp bin/swarm /usr/local/bin/

	cd ~/
	gzip -c /usr/local/src/man/swarm.1 > swarm.1.gz
	sudo mv swarm.1.gz /usr/share/man/man1/

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _vsearch:

VSEARCH
-------

Open-source implementation of USEARCH with more versatility. VSEARCH is a software package specifically designed for metabarcoding, based on the USEARCH package but completely free and open source. `Github<https://github.com/torognes/vsearch>`_

.. parsed-literal::
	
	sudo apt install autoconf groff :comment:`# (installed above)`
	
	cd /usr/local/src
	
	sudo wget https://github.com/torognes/vsearch/archive/v2.15.1.tar.gz
	sudo tar xzf v2.15.1.tar.gz
	cd vsearch-2.15.1
	sudo ./autogen.sh
	sudo ./configure
	sudo make
	sudo make install
	cd ../

..#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.. _phylostuff:

phylostuff
----------

A set of scripts for doing stuff to phylogenies, including relabelling and inferring taxonomy. `Github<https://github.com/tjcreedy/phylostuff>`_
Requires :ref:`R<r>`.

.. parsed-literal::
	
	cd /usr/local/src
	sudo rm -r phylostuff
	sudo git clone https://github.com/tjcreedy/phylostuff.git
	cd phylostuff
	sudo ./install.sh

Installation not necessary: you could simply download the script you want to your working directory and run it using ``Rscript``, for example with **phylabel**:

.. parsed-literal::
	
	wget https://raw.githubusercontent.com/tjcreedy/phylostuff/master/phylabel.R
	Rscript phylabel.R
	

Or just open them in Rstudio and use them as a guide!

