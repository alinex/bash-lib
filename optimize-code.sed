#!/usr/bin/sed -E
# sed replacement optimization

# replace easy validator calls with direct syntax
s/\bis set -- ("[^"]+")/[ -n \1 ]/g
s/\bis empty -- ("[^"]+")/[ -z \1 ]/g
s/\bis integer -- ("[^"]+")/[[ \1 =~ ^-?[0-9]+$ ]]/g
s/\bis float -- ("[^"]+")/[[ \1 =~ ^-?[0-9]+([.][0-9]+)?$ ]]/g
