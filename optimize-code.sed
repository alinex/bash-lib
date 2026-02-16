#!/usr/bin/sed -E
# sed replacement optimization to compress the pre-build packages full and core

# validator
# replace easy validator calls with direct syntax
s/\bis set -- ("[^"]+")/[ -n \1 ]/g
s/\bis empty -- ("[^"]+")/[ -z \1 ]/g
s/\bis integer -- ("[^"]+")/[[ \1 =~ ^-?[0-9]+$ ]]/g
s/\bis float -- ("[^"]+")/[[ \1 =~ ^-?[0-9]+([.][0-9]+)?$ ]]/g
# shorten options
s/(is [a-z]+) --name=/\1 -n/g
s/(is .*?) --die/\1 -d/g
s/(is .*?) --output=/\1 -o/g
s/(is .*?) --message=/\1 -m/g
# combine options
s/(is .*?) -d -([^-])/\1 -d\2/g
# remove unnecessary end option
s/-- \$#/$#/g

# remove variable documentation only $VAR=$VAR
/^([A-Z_]+)=(\")?\$\1\2?$/d

# compress inline scripts
#/awk[^']*'$/,/^\s*'\s*/{/awk[^']*'$/b;/^\s*'\s*/b;s/./x/g} # mark inner area for test
/awk[^']*'$/,/^\s*'\s*/{s/^\s+//;/awk[^']*'$/b;/^\s*'\s*/b;/^#/d;s/\s#.*$//;s/\s$//}
#/jq[^']*'$/,/^\s*'\s*/{/jq[^']*'$/b;/^\s*'\s*/b;s/./x/g} # mark inner area for test
/jq[^']*'$/,/^\s*'\s*/{s/^\s+//;/jq[^']*'$/b;/^\s*'\s*/b;/^#/d;s/\s#.*$//;s/\s$//}
# not working
#/sed[^']*'$/,/^\s*'\s*/{/sed[^']*'$/b;/^\s*'\s*/b;s/./x/g} # mark inner area for test
#/sed[^']*'$/,/^\s*'\s*/{s/^\s+//;/sed[^']*'$/b;/^\s*'\s*/b;/^#/d;s/\s#.*$//;s/\s$//}

# further small optimization
s/^source /. /
