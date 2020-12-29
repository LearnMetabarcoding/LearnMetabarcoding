git rm -r docs/
git commit -am "Auto-removal of previous html version"
cd sphinx
make html
cd ../
rm -r doctrees
mv html docs
touch docs/.nojekyll
cp sphinx/source/custom.css docs/_static/css
cp sphinx/source/customjs/custom.js docs/_static/js
cd docs/
mkdir data
cd ../
### Thomas added ###
cd data_source/
for d in *; do zip -r ../docs/data/${d}.zip $d; done
cd ../
####################
git add docs
git commit -am "Auto-commit of new html version"
