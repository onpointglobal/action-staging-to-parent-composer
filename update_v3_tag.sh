# push changes.
git add .
git commit -m "Update V3 tag"
git push

#
git tag -d v3
git push --delete origin v3

# create and update tag
git tag v3
git push origin v3