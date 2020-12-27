.. _asv_otu_readmap:

===========================
C: ASVs, OTUs and read mapping
===========================

.. toctree:: 
    :hidden:

    asv_otu_readmap/otudelim
    asv_otu_readmap/mapping_reads

Introduction
============

The previous sections have seen you process sequence data from raw reads to a set of unique sequences, ASVs, that ideally represent all of the unique true biological sequences from our locus of interest. Thus these ASVs ideally represent the set of haplotypes present in our samples. These ASVs encompass both intra- and inter-specific variation, and may possibly still contain some errors.

In this section, we will first examine some ways to group ASVs into Operational Taxonomic Units, a process by which ASVs are assigned to OTU groups, and a sequence from one of these ASVs is chosen to represent the whole group. This is covered in the `OTU Delimitation <otudelim>` subsection.

In the second subsection, :ref:`Mapping Reads <mapping_reads>` we will look at how to bring our final set of biological sequences, be they ASVs or OTUs, together with the sample-level read dataset in order to generate read mapping tables, the record of the number of reads for each biological sequence in each of your samples. This data is the primary output of metabarcoding and can be used in place of classic site-by-species tables for downstream ecological analysis. 

.. admonition:: Data
	
	The starting point for this section is a FASTA file comprising ASVs, that is to say unique sequences with errors removed. These sequences must have ``;size=`` tags in the sequence headers to denote the abundance of each sequence in the dataset. You will also need a FASTA file of all reads in your dataset, with sample names in the read headers. 
	
	If you worked through :ref:`the previous section<filtering>`, these data were produced by the :ref:`chimera filtering<chimera_filtering>` and :ref:`quality filtering<quality_filtering>` tutorials respectively.
	
	If you didn't work through the previous section, you can download a zip archive of the data for all of the tutorials in this section `here <sectionCdata>`. Unzip this to a convenient location.

ASVs or OTUS?
=============

In early metabarcoding studies, these ASVs were always grouped together into Operational Taxonomic Units (OTUs), that were treated as equivalent to species. This grouping process aimed to perform two tasks simultaneously: the removal of intra-specific variation to get species-level taxonomic units, and the removal of any remaining erroneous sequences. As new filtering methods have become available, and our ability to remove erroneous sequences has improved, the latter task has dwindled in relevance and while OTU grouping is still widely used, the error rate of ASVs has decreased to the point that we may be able to analyse the haplotype-level dataset with confidence, allowing the exploration of population-level patterns and processes alongside studying the community level. The choice of using ASVs or OTUs largely depends on your research questions and it may well be that both may be appropriate for different aspects of your research.

There are three main points that you should keep in mind if continuing at the ASV level:
1. ASVs are much more sensitive to any errors remaining in your dataset, whereas OTUs will collapse and ignore errors that represent only small variations from real sequences.
2. You may need significantly deeper sampling to adequately capture a sufficiently representative set of ASVs for your study than for OTUs. This will depend a lot on your research question, study community and study taxon.
3. Similarly, you may need significantly deeper sampling to recover representative numbers of reads per ASV per sample in order to generate a realistic picture of ASV distribution across your samples, than for OTUs. Again this will depend on research question, study community and study taxon.

.. _ASV_OTU_read_mapping_nextsteps:

Next Steps
==========

To find out how to group your ASVs into groups, head to the :ref:`OTU Delimitation <otudelim>` subsection.

If you have done OTU delimitation or want to work with ASVs, you can jump to the :ref:`Mapping reads <mapping_reads>` subsection, where we look at how to generate data recording the number of reads per ASV or OTU per sample.

