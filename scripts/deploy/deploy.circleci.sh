#!/usr/bin/env bash
git config --global user.email "justus.caspers@destatis.de"
git config --global user.name "JustusCas"

git clone $CIRCLE_REPOSITORY_URL out

cd out
git checkout gh-pages || git checkout --orphan gh-pages
git rm -rfq .
cd ..

# The fully built site is already available at /tmp/build.
cp -a /tmp/build/_site/. out/.

mkdir -p out/.circleci && cp -a .circleci/. out/.circleci/.
cd out

git add -A
git commit -m "Automated deployment to GitHub Pages: ${CIRCLE_SHA1}" --allow-empty

git push origin gh-pages
