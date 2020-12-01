==============================
Mapping reads to references
==============================

If we were only interested in the species for which we have reference sequences, for example if we were monitoring for a single or set of known species, there isn’t really much need to generate anonymous OTUs. We could simply map our trimmed, merged and quality filtered reads against the references directly, to get counts of our reference species in each sample.

Try using both ``​blastn`` and ``vsearch --usearch_global`` to map the raw reads against the reference sequences, drawing on what you learned from using the previous commands.

Experiment with different thresholds and outputs.

* Experiment with different thresholds and outputs.

* Is one method clearly superior?