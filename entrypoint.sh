#!/bin/sh -l

branch=$1
parent_path=$2
project_path=$3
secret=$4
composer_package_name=$(jq '.name' $project_path/composer.json)
git config --global user.name github-actions
git config --global user.email github-actions@github.com
echo -n $1 >> token.txt
gh auth login --with-token < token.txt
rm token.txt
cd $parent_path
composer config --global github-oauth.github.com ${{ secrets.PAT }}
composer update-$branch "$composer_package_name"
git commit -am "${{ github.event.head_commit.message }} - update composer with $composer_package_name"
git push origin $branch