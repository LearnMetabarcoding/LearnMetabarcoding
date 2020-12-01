.. _cutadapt_extension:

===================================
Cutadapt extension
===================================

Cutadapt has a lot more parameters for searching. It can be error-tolerant, allowing you to permit some mismatches between your indices and the sequences. Our adapters are all at least 3 bases different, so in theory we could allow a one-base difference to try and get more reads for our samples. The relevant option is ​-e​, which is the maximum error rate (0-1), i.e. the total proportion of errors allowed in our indices. The default, 0.1, would allow 10% errors, but since our indices are only 6 bases this rounds to 0 errors allowed.

* Create two more new directories and try ​-e values that allow one error or two errors, putting the outputs into those two directories. Explore the read numbers using ​grep

* How do the read numbers vary? Is being more error-tolerant sensible?

Feel free to explore more of the parameters, for example the minimum overlap parameter ​-0

* In this case, I believe the default settings are appropriate. What do you think?
