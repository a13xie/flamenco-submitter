#!/bin/bash

# Detect version control system
# Get a list of changed files, iterate through them and submit each to Flamenco
# Needs logic for killing off Blender instances since Blender doesn't quit after submission


cd $CI_PROJECT_DIR

if git status
then
  files=($(git diff-tree --no-commit-id --name-only -r $CI_COMMIT_SHA))
elif hg status
then
  files=($(hg status -n --change tip $CI_COMMIT_SHA))
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
  if [[ $file == *".blend"* ]]
  then
    echo "Submitting $file"
  fi
done

# startx /usr/bin/blender "--python-exit-code 1 $CI_PROJECT_DIR/untitled.blend --python /tmp/submitter/submitter.py" & sleep 60 && killall blender
