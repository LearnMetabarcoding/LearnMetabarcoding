.. _chimera:

==================================
6. Chimera filtering 
==================================

You might have noticed that earlier, while running denoising, we noticed some chimeras. We left these in because we used the ``--ampout`` argument, so time to remove them.

We’re still using trusty VSEARCH:

.. code-block:: bash 

	$ vsearch --uchime3_denovo ​in.fasta​ --nonchimeras ​out.fasta

It’s that simple. And with that, we have a file that ideally contains only true biological sequences.

Now we have filtered our sequences we can finaly move onto :ref:`OTU delimitation!<otu_delim>`


