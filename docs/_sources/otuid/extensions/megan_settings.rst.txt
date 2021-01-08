.. _megan_settings: 

====================================
Extension: MEGAN settings
====================================

Go to :menuselection:`Options --> Change LCA Parameters`. Let's adjust this to only take into account close relatives by modifying the :menuselection:`Min Percent Identity` parameter to ignore any hits below, say, 80% similarity (i.e. :menuselection:`Min Percent Identity: = 0.80).`

.. admonition:: Exercise

	* How does this change things?
	* Is this an appropriate selection for this dataset?

Return the :menuselection:`Min Percent Identity` to 0.0 and this time change the :menuselection:`Top Percent` value to 60 and the :menuselection:`LCA Algorithm` to :menuselection:`weighted`. This allows taking into account many more hits for the LCA algorithm, but weights them according to their score, which is more appropriate for shorter reads. This also may work better for an understudied community that doesn’t get many close hits.

:guilabel:`How does this change the taxonomy assignments?`

The next tutorial is on :ref:`identifiction using curated databases<id_curated>`.
