#!/bin/sh -l

branch=$1
composer_parent_path=$2
composer_project_path=$3
secret=$4
composer_package_name=$(jq -r '.name' $composer_project_path/composer.json)
git config --global user.name github-actions
git config --global user.email github-actions@github.com
composer config --global github-oauth.github.com $secret
export COMPOSER=composer-$branch.json
cd $composer_parent_path && composer update $composer_package_name
git config --get remote.origin.url
git status
git commit -am "update composer.lock with $composer_package_name"
git push origin $branch