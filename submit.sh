#!/bin/bash

# Detect version control system
# Get a list of changed files, iterate through them and submit each to Flamenco
# Needs logic for killing off Blender instances since Blender doesn't quit after submission

set -x

cd $CI_PROJECT_DIR

if git status
then
  files=($(git diff-tree --no-commit-id --name-only -r $CI_COMMIT_SHA))
elif hg status
then
  files=($(hg status -n --change tip $CI_COMMIT_SHA))
fi

printf '%s\n' "${files[@]}"

blendfiles=()

echo "Iteration"
for file in "${files[@]}"
do
  if [[ $file == *"blends/"* ]]
  then
    echo "$file"
    blendfiles+=($file)
  fi
done

echo "Files in blender folder:"
printf '%s\n' "${blendfiles[@]}"

for file in "${blendfiles[@]}"
do
  if [ -f $file ] && [ $file == *".blend"* ]
  then
    echo "Submitting $file"
  fi
done
