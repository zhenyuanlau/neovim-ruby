#!/bin/sh

set -eu

: ${TRAVIS:?} ${GH_TOKEN:?}

if bundle exec rake docs:validate; then
  exit 0
fi

bundle exec rake docs:generate

git config user.name "Travis CI"
git config user.email "travis@travis-ci.org"
git remote set-url origin "https://$GH_TOKEN@github.com/neovim/neovim-ruby.git"

git fetch origin
git checkout master

git add lib/
git commit -m "[skip travis] Update generated docs"
git push origin master
