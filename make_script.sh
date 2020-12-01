git rm -r docs/
git commit -am "Auto-removal of previous html version"
cd sphinx
make html
cd ../
rm -r doctrees
mv html docs
touch docs/.nojekyll
git add docs
git commit -am "Auto-commit of new html version"