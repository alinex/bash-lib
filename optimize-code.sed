#!/usr/bin/sed -E
# sed replacement optimization to compress the pre-build packages full and core

# replace easy validator calls with direct syntax
s/\bis set -- ("[^"]+")/[ -n \1 ]/g
s/\bis empty -- ("[^"]+")/[ -z \1 ]/g
s/\bis integer -- ("[^"]+")/[[ \1 =~ ^-?[0-9]+$ ]]/g
s/\bis float -- ("[^"]+")/[[ \1 =~ ^-?[0-9]+([.][0-9]+)?$ ]]/g

# shorten options
s/(is [a-z]+) --name=/\1 -n/g
s/(is .*?) --die/\1 -d/g
s/(is .*?) --output=/\1 -o/g
s/-- \$#/$#/g
