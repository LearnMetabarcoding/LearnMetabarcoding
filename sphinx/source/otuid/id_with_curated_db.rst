.. _id_curated:

==========================================
2. Identifiation using a curated database 
==========================================

BLAST is not fundamentally designed as a taxonomic assignment tool, and MEGAN is forced to work with BLAST’s alignment and matching summary outputs to assign taxonomy. There are other tools out there that are specifically designed for the assignment of taxonomy to anonymous sequences. Rather than comparing a sequence against a database one-by-one, these methods use k-mer approaches to place a sequence within the whole set of references. Then, they use an approach broadly analogous to MEGAN’s LCA method to probabilistically assign taxonomy, generally assigning confidence scores to different taxonomic levels. Such methods include PROTAX, SINTAX, SPINGO and RDPclassifier. It should be noted that like much of the software available for metabarcoding, these tools are often written for use on 16S. It should always be considered whether other loci may not be treated as expected by such tools.

The other downside to the prior method is that GenBank is not necessarily authoritative - it is well known that many sequences available on GenBank are misidentified. This would not be an issue if we were working with a well-known taxon, but when our survey lineages are likely to be poorly covered in GenBank, yet we require a relatively detailed identification, searching against all of GenBank is likely to be less successful. Some researchers have taken sections of GenBank and curated the sequences, removing sequences that are poor quality or unlikely to be correct.

One issue with using these more advanced classification tools is that they often require quite specific reference database structures. Thankfully, many curated database authors have released their databases in these formats.

For CO1, the MIDORI database (Machida, 2017, doi: 10.1038/sdata.2017.27) is a curated version of GenBank’s CO1 sequences. The authors have taken the useful step of creating a server for searching sequences against MIDORI using three of the above classifiers. You can access the server `here. <http://reference-midori.info/server.php>`_ 

You can see that you can select a program, paste or upload your sequences, and select a database and searching parameters. We don’t want to overload their server with redundant searches, so we’ve already done this step for you. We ran the 3% OTUs against the MIDORI CO1 database using RDP and SINTAX, and you can find the resulting files in ``/AMM/resources/metabarcoding/taxassign/`` under the different program names. We ran SPINGO too, but its outputs require more processing to be comparable, so we’ll just consider RDP and SINTAX. Copy the files to your directory. RDP outputs two files, the “hier_outfile” is a summary and the “usga_classified” is the individual OTU taxonomies.

To quickly get an idea of how many Coleoptera OTUs we have, run the following command on the SINTAX file, the RDP classified file, and the MEGAN output you uploaded:

.. code-block:: bash 

	$ grep -c “Coleoptera”

* Do the different assignment programs agree?

Download these files to your computer using your FTP client and open them up in a text editor or spreadsheet software. The exact format varies, but all they output broadly similar information: the name of the OTU, some taxonomy and a confidence for each taxonomic level. They are fairly intuitive. Compare the MEGAN, RDP and SINTAX classifications for some different OTUs.

* Which programs provide lower-level identifications?

* Are species level identifications likely to be accurate?

* What levels of confidence are given to the order level identifications? Might this be very conservative? Why?

* What other taxa do we apparently have? You will see that we have some obvious non-Coleoptera OTUs, but also some OTUs that have been assigned to other Insect orders. How consistent are these identifications between methods? Are we confident that these really are not Coleoptera?

Note that it’s perfectly feasible that there could have been non-Coleoptera Insect DNA in these samples.

Now lets see how we would do identification with a local database in the :ref:`next step.<id_local>`