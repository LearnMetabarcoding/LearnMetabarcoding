.. _page-link:
=================
Page heading
=================

.. _level-one-link:
Level one heading
=================

.. _level-two-link:
Level two heading
-----------------

.. admonition:: Exercise
	This is an exercise and will come out blue by default

.. admonition:: Solution
	:class: toggle
	This is a solution and will come out blue by default, with the nice toggle to show content

.. admonition:: How this command works
	:class: togglegreen
	This will have a toggle


.. admonition:: Note
	:class: green
	This is a note, rather than using ``.. note::`` we're using a custom admonition box and a class to change the colour

.. admonition:: See also
	class: green
	This is a see also box, like with the note above we're using a custom admonition box and a class to change the colour, instead of doing ``.. seealso::``

.. tip::
	This is a tip, it's green by default so we don't need to do anything

.. warning::
	This is a warning and it's orange by default so we don't need to do anything


Use :guilabel:`gui label` to encompass an inline instruction, as an inline version of an exercise box.

For GUI software menus, use :menuselection:`File --> Save`.

For DNA sequences, use

.. topic:: title if needed
.. parsed-literal::
	ATCG*ATGC***ATCG**



