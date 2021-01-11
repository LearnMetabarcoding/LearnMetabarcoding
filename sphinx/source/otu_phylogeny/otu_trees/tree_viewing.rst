.. _tree_viewing:

===========================
Fundamentals: Viewing trees
===========================

Introduction
============

In this tutorial we will look at how you can view phylogentic trees using the free software **Dendroscope**. If you are familiar with **Dendroscope** or a similar software feel free to skip this. 

.. admonition:: Software and data
    :class: green

    This section uses the software **Dendroscope**, which you can download from `here <https://uni-tuebingen.de/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/algorithms-in-bioinformatics/software/dendroscope/>`_

Viewing tree in Dendroscope
===========================

To open your tree in **Dendroscope** you can click on the open file icon in the top menu or navigate to :menuselection:`File --> Open` and then browse and select your file. Your tree will then load and you should see it on your screen (see below example).

.. image:: dendroscope_open.png
    :align: center

Once your tree has loaded you can click and drag the tree to move it around the screen. Scrolling will stretch or narrow the tree. Pressing control and + or - will zoom the node labels in or out.

You can select different layouts for your tree using the buttons on the top bar. You can also use the various arrow buttons to help zoom the tree in or out. To the right, there are also buttons that you can use to ladderise your tree - these are particularly helpful after rerooting.

Rerooting a tree in Dendroscope
===============================

To reroot a tree you in Dendroscope you must first select the branch that you want to set as root. If you already have something selected, clear it by going to :menuselection:`Select --> Deselect All`. Then select the branch you want to set as root with your cursor. The below screenshot shows an example of a selected branch.

.. image:: dendroscope_selected.png
    :align: center

Then to reroot your tree navigate to :menuselection:`Edit --> Reroot` as shown in the below screenshot and your tree will be rerooted. 

.. image:: dendroscope_reroot.png
    :align: center

Next steps
==========

If you haven't already you can check out the tutorial on :ref:`viewing alignments <alignment_viewing>`. You can also check out the :ref:`Barcode tree with references <reference_otu_tree>` extension or the :ref:`OTU comparison tree <otu_comparison_tree>` extension.

Alternatively, you can proceed to the next tutorial, :ref:`Phylogenetic placement. <phylogenetic_placement>`
