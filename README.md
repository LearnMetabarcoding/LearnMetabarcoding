### Editing the course site

This document gives instructions on how to edit and remake the website documentation for the "Bioinformatic Methods for Biodiversity Metabarcoding" course.

## General information

* The website is split into two parts: 
    * [The landing page](https://learnmetabarcoding.github.io/)
    * [The course documentation](https://learnmetabarcoding.github.io/LearnMetabarcoding/)
* Both of these are hosted by github pages and have a repository each:
    * [The landing pages repository](https://github.com/LearnMetabarcoding/LearnMetabarcoding.github.io)
    * [The course documentation repository](https://github.com/LearnMetabarcoding/LearnMetabarcoding)

## Editing the landing page

The landing page is written in plain HTML and CSS. The files that github pages serve are in the docs/ directory of the repository. The .nojekyll file is there to specify to github pages not to build the site with jekyll. It is a simple site that uses CSS grid to position elements. To edit you can clone the repository and edit the files Index.html and main.css. Then when you push the changes github pages will automatically update the site. 

## Editing the course documentation site

The course documentation site is built using sphinx. This can be downloaded [here.](https://www.sphinx-doc.org/en/master/) Sphinx is a program that parses through reStructuredText files and can output HTML files. It takes a little while to get the hang of using sphinx but once you've learnt the basics it is quite simple to use. To edit the website you can clone the repository. The files to edit are the .rst files in the sphinx/source/ directory of the repository. You should learn a bit about sphinx and reStructuredText before editing and a great resource is the sphinx documentation site linked above. If you are making new pages, deleting pages or rearranging pages it is particularly important to learn about the [toctree directive.](https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html?highlight=toctree#directive-toctree) 

We created some custom classes for the site to allow more flexibility in the sites styles (such as adding solution boxes that can be opened and closed). In the root of the repository there is a file named template.rst which has information on how to use these classes as well as where they are used in the site. To change the styles of any of these classes you can edit the custom.css file which is located in the sphinx/source/ directory.

Once you have edited you need to run sphinx to build the updated HTML and rearrange the folders so the custom styles are inserted and github pages serves the site correctly. The file Make_script.sh at the root of the repository can be run to do this all automatically. To run this in a terminal you simply type `bash Make_script.sh`. Review the output of the terminal as it will tell you about any errors and in which files these errors are so you can go and correct them before pushing your changes. Once you push github will automatically update the site.



<!--
**LearnMetabarcoding/LearnMetabarcoding** is a ✨ _special_ ✨ repository because its `README.md` (this file) appears on your GitHub profile.

Here are some ideas to get you started:

- 🔭 I’m currently working on ...
- 🌱 I’m currently learning ...
- 👯 I’m looking to collaborate on ...
- 🤔 I’m looking for help with ...
- 💬 Ask me about ...
- 📫 How to reach me: ...
- 😄 Pronouns: ...
- ⚡ Fun fact: ...
-->
