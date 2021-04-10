#/bin/bash

# reference: https://askubuntu.com/questions/518370/extract-several-zip-files-each-in-a-new-folder-with-the-same-name-via-ubuntu-t

cd $1;

while read -rd $'\0' f; do 
  unzip -o -d "${f%.*}" "$f" && rm "$f"
  sleep 2
done < <(find . -name '*.zip' -print0)
