#!/bin/bash

NAME=$(grep combined_output_path mkdocs.yml | sed 's/.* alinex/alinex/;s/\..*//')

cp mkdocs.yml mkdocs.yml.save
sed -i 's/#PDF#//g' mkdocs.yml
mkdocs build 2>/dev/null
test $? && echo "Failed to create PDF"
mv site/$NAME.pdf docs 2>/dev/null
ebook-convert docs/$NAME.pdf docs/$NAME.epub
mv -f mkdocs.yml.save mkdocs.yml
rm -r site
