.. _database_classification:

=======================
Database classification
=======================

.. toctree::
    :hidden:

    id_with_megan
    id_with_curated_db


Introduction
============

While it's generally a great idea to barcode a reference set of specimens expected to form part of your metabarcoding samples, it isn't always possible to generate a comprehensive set of references. Furthermore, the use of degenerate primers often means that many taxa outside of your taxon of interest get co-amplified alongside your targets, either as bycatch from sampling, food, endosymbionts or parasites, of the target, or just environmental DNA. It is therefore a major part of most metabarcoding pipelines to try and assign some taxonomic information to our OTUs using publicly available databases. Once this has been performed, it is often useful to use this taxonomic classification to filter our OTU sequences by taxonomy, reducing the OTU sequences to those belonging to to our taxon of interest.

There are two major issues when trying to classify sequences using databases: **accuracy** and **completeness**. While we all try to do our best, other researchers might misidentify something that then subsequently sequence and share on a public database. Alternatively, the sequencing itself may have gone wrong, either through contamination or sequencing error, so the sequence shared may in part or wholly not match the taxonomy name it is stored under. The coverage of different lineages on GenBank varies substantially, with some commonly- or easily- studied taxa having many thousands of sequences per species, with other taxa having only a handful for a family or order. Depending on your taxonomic focus, therefore, you may find that the available reference data is sparse, inconsistent or inaccurate. These two issues work synergistically - a few inaccurate sequences in a well-studied taxon are rarely an issue, as you can easily draw a parsimonous conclusion about the most valid data. However, the less sequencing has been performed on a taxon, the less we are able to spot errors. Small errors can be impossible to identify without more data.

The impact of these issues must be considered carefully when performing taxonomic classification of unknown sequences. Generally in metabarcoding, we have some a priori assumption about the taxonomic groups covered by our sampling, and this is useful for first-pass validation of searches. However, it is very common that classification will give unexpected results, and you must carefully decide whether these unexpected results are simply false positives - misidentifications - or are instead a real but unexpected finding. The best way to do this is to ensure that you are familiar with the coverage of your taxa of interest, and that you use at least two but ideally multiple classification methods to draw upon multiple lines of evidence. Furthermore, for taxonomically broad studies, you must carefully think about the impact of varying coverage and accuracy. Using arthropods as an example, there is considerable variation in the coverage of taxa, largely correlated with geographic location. Anonymous sequences deriving from tropical arthropod samples may therefore be able to be easily classified to family or genus for cosmopolitan if the sequence belongs to a cosmopolitan group, but it may be challenging to get even an order-level assignment for other sequences where the true species is from a more localised or poorly-studied taxon. This variation in classification depth must be carefully considered when using this data for downstream analyses, as the distribution of classification depth is non-random and so subsetting your data by classification depth for detailed analyses may introduce substantial biases.

In these tutorials, we will look at several different methods for taxonomic classification. We would strongly suggest that you employ multiple methods for taxonomic classification, and carefully validate the results. For example, the inclusion of positive control samples, or the classification of a set of known reference sequences, can help to validate the accuracy of these methods. Moreover, we would strongly suggest to treat the results of taxonomic classification as conservatively as possible. Even if a method gives genus- or species-level classifications to many OTUs, carefully consider whether these are likely to be valid by researching the coverage and accuracy of those taxa in the database you use, and consider whether you should discard these and consider only family-level classifications to answer the same questions. Of course, these recommendations will vary in relevance depending on your research questions and exact study taxa.

Next steps
==========

First, we will look at classification using a global public database, GenBank, and parsing this classification in :ref:`Classification with Genbank & MEGAN <id_with_megan>`. 

Next we will look at classification with a curated database, and a variety of algorithms that can be applied to curated databeses in :ref:`Classification with curated databases <id_with_curated_db>`.
