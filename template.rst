.. _page-link:
=================
Page heading
=================

.. _level-one-link:
Introduction
============

Almost all pages should start with an introduction, even if it's just a few sentences.

.. admonition:: Data and software
	:class: green
	
	Almost all pages should have a brief box outlining the data this step will need, and the software that should be installed, making sure to :ref:`link <linkname>` to that software section in the software install page.


.. _level-two-link:
Level two heading
-----------------

Generally let's try and avoid too many different heading levels unless necessary for a long list page

When introducing software, use ``monospaced`` if it is a base linux tool, such as sed or grep, or **bold** if it is anything that should be installed. Try to respect author capitalisation and be consistent.


For code, use

.. parsed-literal::
	
	function -i :var:`input.fasta` -p :var:`N` -k 54 :comment:`# This is a comment`
	

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
	:class: green
	
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



