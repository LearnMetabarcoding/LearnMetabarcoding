.. _cloud_servers

=============
Cloud servers
=============

Put simply, a cloud server (also known as a Virtual Private Server, VPS) is a virtual computer that exists in a remote data centre. You rent the computational resources from a cloud services provider, and are given access to this computer that you can use however you like. Depending on the provider, you might pay a fixed amount every month, or you may pay only for what you use. The benefits of this approach is that, with careful configuration, you only pay for what you use and you gain access to as much computational resources as you like (and can pay for). So rather than spending thousands on a high-powered machine, you can effectively rent one for a week just to do your bioinformatics.

There are many many cloud services providers out there, with different pricing structures and entry levels. We don't have the scope here to give detailed recommendations and tutorials, however we can make some general recommendations. 

Choosing a provider
===================

We would recommend that first time users choose one of the major VPS providers because they will have the most comprehensive and beginner friendly documentation. These providers include Amazon Web Services (in particular their beginner-friendly service Lightsail), Google Cloud Services, Digital Ocean (who have excellent user guides), and Microsoft Azure. It is very hard to know what sort of computational resources you might need for a project, but we would recommend starting out with around 4 CPUs, 8GB of RAM and storage space equal to 10-15 times the data size of your raw sequences (a MiSeq run generates 4-6 GB of data). You could use this requirement to compare prices from different providers. If you are only running the server to learn from these resources using our example dataset, you can probably get away with 2 CPUs, 4GB of RAM and 15GB of storage.

Configuration
=============

Search google for beginner's tutorials for your chosen provider, which will help walk you through the first steps of selecting VPS configuration, e.g. "set up lightsail server ubuntu". Select Ubuntu Linux as the operating system, choosing one of the LTS versions (18.04 or 20.04). All of the command line software in this resource will work on these versions. Use the computational resources above as a starting point, although you may choose to increase them if you have a large dataset or are trying to do something computationally intensive (e.g. running `BLAST <id_using_MEGAN` or `metaMATE <metamate>`, or doing `phylogenetics <phylogeny>` might need more CPUs and/or RAM). We suggest choosing a configuration which allows you to easily change computational resources without having to rebuild your server from scratch.

Setting up
==========

Once you have your server running, you will need to log into it using SSH. We have some general instructions for this :ref:`here <remote_access>`, but there will be variations depending on the provider, so we suggest you look for a tutorial for your specific provider and the operating system of your personal computer, e.g. "SSH access to azure VPS from mac OS". If you're completely new to the linux command line environment, you might want to check out some `introductory help <unix_cli>`. Once you have accessed the server, you should ensure that you configure and administration and security software and settings - again, search for a tutorial for your specific provider, for example "set up digital ocean firewall and user accounts".

You can then go ahead and install the software you will need for bioinformatics. You can either just install all the software as detailed on :ref:`the software page <installing_software>`, or you can just go ahead and start working through these resources and install software as you need it: each tutorial clearly states which software is required and links to the relevant installation instructions.

Finally, you will want to send your data to the server. You can do this by downloading it directly from your sequencing provider's website or FTP server using `wget` or `ftp`. Alternatively you can upload it from your personal computer using :ref:`FTP software <remote_access>`.

Next steps
==========

Once you have the server up and running, you can continue reading through the :ref:`Getting Started <gettingstarted>` section, then when you feel ready you can start on the tutorials with the :ref:`Read processing <read_processing>` section.
