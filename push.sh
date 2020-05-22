#!/bin/zsh
hexo g -d
git add .
git commit -m "update"
git push