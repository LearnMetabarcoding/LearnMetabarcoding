.. _toolbox_pipelines:

==========================
The bioinformatics toolbox
==========================

Pipelines
=========

The course is structured in a linear format to aid learning. In practice, while the final bioinformatic procedure employed by a study will be largely linear, the development of this procedure will be anything but. We strongly recommend against treating the set of tools presented here as a self-contained pipeline that's directly applicable to any metabarcoding. We strongly encourage that the best approach to metabarcoding is to develop a good understanding of the steps required and the tools available first. Then design a pipeline with the principle aim of most appropriately answering your research question, selecting only those steps that are relevant to your research aim and employing them in the most appropriate and efficient manner. There is no one-size-fits-all pipeline for metabarcoding.

The toolbox
===========

Generally, in these resources we present a single software tool to tackle each specific metabarcoding step. A comprehensive comparison of all available software for metabarcoding is simply beyond the scope of these resources, and the focus here is introducing the bioinformatic challenges and helping you develop an understanding of the issues concerning different aspects of metabarcoding. For some steps, such as length filtering, the bioinformatic process is very straightforward and any software should work exactly the same, so software choice doesn't matter. For many steps, such as pair merging, different software works in a largely similar manner and although results might vary slightly between tools, there shouldn't be a huge difference; in these cases, we use a single tool but suggest some alternatives. In some cases, the theoretical basis of different software is considerably different, or different software offers markedly different approaches: in these cases, we discuss and examine at least some of these different approaches.

While we generally have selected the software that we think is most appropriate, this choice should always be made with consideration of your data and research questions. The software and parameters we suggest are those that fit the example dataset well and/or help us to explain the concepts best. While *in general* we would likely recommend the same approach with no knowledge of your data, remember that the principal aim of these resources is to teach the concepts and important considerations, not evangelise any particular pipeline or set of software.

Our software
------------

In producing these resources, we have striven to use software that is widely used by the metabarcoding community, is free and open source, and is well maintained. While we beleive we have largely met this goal, in a few tutorials we use custom scripts and software that we have written. The aim here is not to evangelise our tools and suggest you use them to the exclusion of other approaches out there, but to fill a gap where no other software is actually available. To this end, we always make very clear when a script or software is our own work.

Packages
========

If you're at all familiar with metabarcoding, you'll likely have heard of some of the metabarcoding software packages. Widely used ones include **USEARCH**, **VSEARCH**, **OBITools**, **QIIME** and **mothur**. These are collections of scripts and tools that are grouped together under one umbrella to form a "one stop shop" for metabarcoding bioinformatics. The benefit of using one of these packages is that all of the tools you need are available under one umbrella, with consistent functions and data requirements. They are often (but not always) easier to install than many separate tools.

The downside of these packages is that if you need to think outside the box or develop in a new direction, being used to a specific narrow ecosystem may make this harder, especially for beginners. It is very easy just to follow the package's "tutorial pipeline" and think that this is all you need, whereas your data or research question might be more appropriately addressed using an alternative pipeline or indeed software outside of the package. Furthermore, many packages simply provide a wrapper around other software, which may limit your access (or knowledge) about all available settings for that software and cause inaccurate reporting of the methods used.

In these resources we have avoided staying within a single package's ecosystem so as to use what we believe is the most appropriate software out there, at least for the example data and the concepts we're trying to teach. We have avoided wrapper scripts so that you know exactly what software is actually running whatever process is being implemented. However, you will find that many of the commands we use are from the **VSEARCH** package. **VSEARCH** is a free and open-source implementation of **USEARCH**, is very easy to install and is very full-featured. You will see that we use **VSEARCH** as our general-purpose multi-tool for a lot of relatively basic processing, but where there might be other software that is more appropriate for the task on hand, we never feel bound to use the **VSEARCH** equivalent just because it's there.
