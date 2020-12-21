.. _OTU_ASV_read_mapping:

===========================
OTUs, ASVs and Read Mapping
===========================

.. toctree:: 
    :hidden:

    otu_asvs_readmapping/otudelim
    otu_asvs_readmapping/mapping_reads

Introduction
============

The previous sections have seen you process sequence data from raw reads to a set of unique sequences, ASVs, that ideally represent all of the unique true biological sequences from our locus of interest. Thus these ASVs ideally represent the set of haplotypes present in our samples. These ASVs encompass both intra- and inter-specific variation, and may possibly still contain some errors.

In this section, we will first examine some ways to group ASVs into Operational Taxonomic Units, a process by which ASVs are assigned to OTU groups, and a sequence from one of these ASVs is chosen to represent the whole group. This is covered in the `OTU Delimitation <otudelim>` subsection.

In the second subsection, :ref:`Mapping Reads <mapping_reads>` we will look at how to bring our final set of biological sequences, be they ASVs or OTUs, together with the sample-level read dataset in order to generate read mapping tables, the record of the number of reads for each biological sequence in each of your samples. This data is the primary output of metabarcoding and can be used in place of classic site-by-species tables for downstream ecological analysis. 

OTUs or ASVs?
=============

In early metabarcoding studies, these ASVs were always grouped together into Operational Taxonomic Units (OTUs), that were treated as equivalent to species. This grouping process aimed to perform two tasks simultaneously: the removal of intra-specific variation to get species-level taxonomic units, and the removal of any remaining erroneous sequences. As new filtering methods have become available, and our ability to remove erroneous sequences has improved, the latter task has dwindled in relevance and while OTU grouping is still widely used, the error rate of ASVs has decreased to the point that we may be able to analyse the haplotype-level dataset with confidence, allowing the exploration of population-level patterns and processes alongside studying the community level. The choice of using ASVs or OTUs largely depends on your research questions and it may well be that both may be appropriate for different aspects of your research.

There are three main points that you should keep in mind if continuing at the ASV level:
1. ASVs are much more sensitive to any errors remaining in your dataset, whereas OTUs will collapse and ignore errors that represent only small variations from real sequences.
2. You may need significantly deeper sampling to adequately capture a sufficiently representative set of ASVs for your study than for OTUs. This will depend a lot on your research question, study community and study taxon.
3. Similarly, you may need significantly deeper sampling to recover representative numbers of reads per ASV per sample in order to generate a realistic picture of ASV distribution across your samples, than for OTUs. Again this will depend on research question, study community and study taxon.

.. _OTU_ASV_read_mapping_nextsteps:

Next Steps
==========

To find out how to group your ASVs into groups, head to the `OTU Delimitation <otudelim>` subsection. You will need a FASTA of ASVs, i.e. unique sequences, with your chosen level of error filtering, and with ``;size=`` tags in the sequence headers. If you have run through the `Filtering <filtering>` section with our toy dataset, the final output from the last step is what you need. If you only want to try this section and you don't have your own data, you can download the equivalent file to test with from XXXXX.

If you have done OTU delimitation or want to work with ASVs, you can jump to the `Mapping Reads <mapping_reads>` subsection. You will need a FASTA file of OTU sequences or of ASV sequences as described above. You will also need a FASTA file containing all reads from your project, with ``;sample=XXX`` tags in the read headers detailing the source of each read. If you've followed the `Filtering <filtering>` section, this would be the final output from the `Quality Filtering <quality_filtering>` subsection.

