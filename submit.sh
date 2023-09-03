#!/bin/bash

# Detect version control system
# Get a list of changed files, iterate through them and submit each to Flamenco
# Needs logic for killing off Blender instances since Blender doesn't quit after submission


cd $CI_PROJECT_DIR

if git status
then
  echo "Detected git"
  files=($(git diff-tree --no-commit-id --name-only -r $CI_COMMIT_SHA))
elif hg status
then
  echo "Detected Mercurial"
  files=($(hg status -n --change $CI_COMMIT_SHA))
fi

blendfiles=()

for file in "${files[@]}"
do
  if [[ $file == *"blends/"* ]]
  then
    blendfiles+=($file)
  fi
done

set -x

for file in "${blendfiles[@]}"
do
  if [[ $file == *".blend"* ]] && [ -f $file ]
  then
    echo "Submitting $file"
    PROJECT_NAME=$file PREVIEW=true startx /usr/bin/blender "--python-exit-code 1 $file --python /tmp/submitter/submitter.py" -- -logverbose 0 & sleep 60 && killall blender
  fi
done


