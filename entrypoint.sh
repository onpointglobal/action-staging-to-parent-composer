#!/bin/sh -l

branch=$1
composer_parent_path=$2
composer_project_path=$3
secret=$4
tag_version=$5
composer_wpmudev=$6
composer_package_name=$(jq -r '.name' "$composer_project_path"/composer.json)
update_arg="$composer_package_name"

if [ ! -z "${tag_version}" ]; then
    echo "tag_version is not empty"
    composer_version=$(echo $tag_version | cut -c 2-) 
    update_arg="$composer_package_name":"$composer_version"  
fi

git config --global user.name github-actions
git config --global --add safe.directory /github/workspace/main
git config --global user.email github-actions@github.com
git config --get remote.origin.url

cd $composer_parent_path
composer config --global github-oauth.github.com $secret
composer config --global http-basic.wpmudev.com $composer_wpmudev null
composer require $update_arg

git status
git commit -am "update composer.lock with $composer_package_name"
git push origin $branch