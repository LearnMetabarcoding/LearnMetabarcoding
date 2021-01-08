.. _analysis:

=====================
Analysing read tables
=====================

Introduction
============

Detailed guidance for cleaning and analysing read tables is beyond the scope of these resources, but we want to give you a broad introduction to the problems and some pointers for how to deal with them. The previous subsections detail how we can generate a reads table that records the number of reads for each of a set of ASVs or OTUs in each of a collection of samples. This table is analagous to the classic community matrix of community ecology, and is the community output from metabarcoding. However, while we have done our best to clean our sequence data to remove errors in the set of ASVs, there may well remain erroneous records within this community data table. Just because an ASV or OTU is valid for the entire dataset, does not mean that the individual counts per sample of that ASV or OTU necessarily accurately reflect biological reality.


Remaining sources of error
==========================

The reads table may be biased by several sources of error that inflate or deflate read counts such that comparisons between samples are not valid. One major concern is false positives, where an ASV or OTU is recorded in a sample when it is not actually present. This may be due to contamination or sequencing errors, particularly sequencing errors in the indices used for multiplexing. Contamination is very difficult to control for, especially if it occurs pre-PCR, as it is very challenging to know what occurences are valid or invalid from unknown samples. Here, negative controls comprised of no material, and positive controls comprised of a known set of specimens (ideally with reference barcodes) can help to identify widespread contamination. On the other hand, cross-talk, where multiplexing indices are mis-sequenced leading to incorrect read-to-sample assignment, may be somewhat ameliorated by looking at the frequency distribution of reads within an ASV or OTU and within a sample. As cross-talk is likely to happen at an overall low rate, very low occurences are likely to be errors.

Another major source of error is PCR bias and sequencing depth. In theory, the number of reads of an ASV or OTU should approximately reflect a function of the occurence and biomass of the source species or haplotype in the community, but both variation in primer affinity and stochastic variation in amplification and sequencing between different species and taxa may mean that relative read counts between ASVs and OTUs no longer reflect real variation. Furthermore, variation in the number of reads attained by different samples can result in substantial differences in the number of ASVs or OTUs recovered in different samples.

Cleaning read tables
====================

There are several possible approaches for removing erroneous occurences from a table. One very common one is to remove any singleton record, i.e. if an ASV or OTU occurs with only a single read in a given sample, change this to 0. Another approach is to use a threshold of proportion of reads per sample, which may be more appropriate given that different samples may have substantially different total read counts. We would strongly suggest this latter approach, but caution that the threshold to be applied should not just be copied from another paper but should be carefully decided on based on the read count distributions of your data. In particular, we find that much lower thresholds are appropriate for very diverse datasets, while higher thresholds suit less diverse datasets. Positive and negative controls can be very helpful here. It is important to remember that false records observed within positive and negative controls are not necessarily evidence of widespread contamination, and simply removing an ASV or OTU completely if it is found in a negative control (or a positive control when it shouldn't be) may be needlessly throwing away data. Instead, this may be evidence of cross-talk, and it may be that the reads of a valid ASV or OTU have been accidentally assigned to a positive or negative control from another sample with a similar index. This can be determined by careful examination of read count patterns across a dataset, keeping track of the indices used. 

Standardising read counts
=========================

We know that the more deeply we sample, the more species we recover until our count levels off - this is the classic species accumulation pattern. The same is true of sequencing; for a given sample, the more we sequence, the more OTUs or ASVs we will see, and this will level off. The concern is that if different samples have been sequenced with different depths through chance variation in the sequencing process, different samples will have reached different points on this species accumulation curve, and will therefore not be comparable for the purposes of community ecology.

One approach to deal with this is rarefaction, which randomly removes reads from a sample until a target number of reads is met. In doing so, ASV or OTUs will be removed from a sample, but the theory is then that all of the samples in the dataset will have the same number of reads thus have reached the same effort in the species accumulation curve and the ASV or OTU counts will be comparable. Generally, this process will require some dropping of samples (that fail to meet the target number of reads) and loss of some ASVs or OTUs (that have all of their reads removed from all samples). This method is very good for producing statistically comparable data, and is very useful for studies undertaking methodological questions where precise comparison of appropriately comparable communities is required, with relatively little importance placed on the extent to which the inferred communities are representative of the real source communities. This method is also useful in highly diverse and poorly-known communities, such as microbiome studies, where reaching asymptotic richness requires very considerable sequencing and the classic accumulation pattern may not necessarily apply.

However, rarefaction neglects the reality of ecological communities and may lead to limited or even invalid analyses, particularly when considering metazoan or plant communities with well-understond accumulation patterns. There is no guarantee that ASV or OTU richness values at the arbitrary cut-off read target are consistent representations of true haplotypic or species richness of a sample, and different accumulation trajectories may intersect and thus have variable ratios of richness along the read axis (TODO: figure?). Furthermore, multivariate analyses of community composition become hampered when real shared species are dropped from one sample or another, leading to incorrect assessmets of community similarity. By rarefying a community, you arbitrarily reduce the effort you put in to characterise that community and reduce the scope and accuracy of your dataset. Instead, an alternative approach simply assesses all samples by calculating expected asymptotic species richness (using parametric extrapolation of the accumulation curve, or through non-parametric estimators such as the Chao index), and calculating the proportion of expected richness each sample achieved. If samples failed to meet a threshold proportion, they are discarded from the dataset (and ideally re-sequenced to achieve more reads and more ASVs/OTUs). The remaining samples are considered valid community samples and no removal of reads in performed. Generally a threshold in the region of 90% of expected richness is employed.

In either case, the majority of metabarcoding studies convert the reads table into presence-absence after using the read numbers for the above filtering. This reflects the fact that read counts in general are not accurate counts of relative ASV/OTU abundance, and it would be inappropriate to employ ecological analyses that treat these values as counts. 

Summary
=======

In conclusion, we recommend the following steps be performed to further filter the reads table before performing ecological analysis:

1. Examine read count distributions by sample and by ASV/OTU to identify thresholds of relative read count
2. Convert read counts under a threshold proportion of reads per sample to 0
3. Convert singleton read counts to 0
4. Standardise read counts either through
5. Rarefaction to a target read count, removing samples with reads below this target.
6. Calculation of expected ASV/OTU richness per sample, removing samples with observed richness less than a threshold proportion of expected. 
7. Convert all read counts to presence-absence (i.e. any values >1 changed to 1)

The majority of these steps are relatively straightforward to perform in R.


