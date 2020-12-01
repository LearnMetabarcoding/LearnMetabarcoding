.. _megan_settings: 

====================================
MEGAN settings
====================================

Go to ​Options > Change LCA Parameters​. Let’s adjust this to only take into account close relatives by modifying the ​Min Percent Identity parameter to ignore any hits below, say, 80% similarity (i.e. ​Min Percent Identity​ = 0.80).

* How does this change things?

* Is this an appropriate selection for this dataset?

Return the ​Min Percent Identity to 0.0 and this time change the ​Top Percent value to 60 and the ​LCA Algorithm to weighted. This allows taking into account many more hits for the LCA algorithm, but weights them according to their score, which is more appropriate for shorter reads. This also may work better for an understudied community that doesn’t get many close hits.

* How does this change the taxonomy assignments?

The next section is on :ref:`identifiction using curated databases<id_curated>`!