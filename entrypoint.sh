#!/bin/sh -l

branch=$1
composer_parent_path=$2
composer_project_path=$3
secret=$4
tag_version=$5
composer_wpmudev=$6
yoast_premium=$7
composer_package_name=$(jq -r '.name' "$composer_project_path"/composer.json)
update_arg="$composer_package_name"

echo "branch value: $branch"
echo "composer_parent_path value: $composer_parent_path"
echo "composer_project_path value: $composer_project_path"
echo "secret value: $secret"
echo "tag_version value: $tag_version"
echo "composer_wpmudev value: $composer_wpmudev"
echo "yoast_premium value: $yoast_premium"

echo "token1"
echo "yoast_premium value: $yoast_premium"
echo "token2"

if [ ! -z "${tag_version}" ]; then
    echo "tag_version is not empty"
    composer_version=$(echo $tag_version | cut -c 2-) 
    update_arg="$composer_package_name":"$composer_version"  
fi

cd $composer_parent_path
composer config --global github-oauth.github.com $secret
composer config --global http-basic.wpmudev.com $composer_wpmudev null
composer config --global http-basic.my.yoast.com token "$yoast_premium"
composer require $update_arg

git config --global user.name github-actions
git config --global user.email github-actions@github.com
git config --get remote.origin.url
git status
git commit -am "update composer.lock with $composer_package_name"
git push origin $branch