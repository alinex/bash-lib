# tsv

## tsv filter --exact 'completed' status  # Search for exact matches of 'completed' in the 'status' column

### Usage

```bash
<tsv> | tsv headers [options]
<tsv> | tsv count [options]
<tsv> | tsv select [options] <selection>
<tsv> | tsv filter [options] <regex> <selection>
<tsv> | tsv slice [options] <start> <end>
<tsv> | tsv sort [options] <selection>
<tsv> | tsv reverse [options]
<tsv> | tsv edit [options] <col-num> <row-num> <value>
<tsv> | tsv crop <column> <length>
<tsv> | tsv print [options]
<tsv> | tsv to <format> [<destination>] [options]
```

### Options

```bash
--no-headers                # input is without header
-i, --input-file <file>     # file to read from instead of STDIN
-o, --output-file <file>    # file to write result to instead of STDOUT
--sort                      # sort columns in select
--literal                   # Treat the regex as a literal string do not interpret it
--exact                     # Match the ENTIRE field exactly
--invert                    # Filter/slice only rows that did not match
--flag <column>             # Do not filter but add a filter column containing 0 for not matched, else the row number
--numerical                 # sort numerical
--natural                   # sort natural (numbers in strings are treaded numerical)
--reverse                   # sort in reverse order
--ignore-case               # ignore case in filter and sorting
--unique                    # keep only one line per sorted value
--max-col-width <num>       # maximum column width for all columns, will truncate content
--schema <name>             # schema for to postgres export
--table <name>              # table name
--drop                      # drop table before insert to postgres
```

### Description

tsv filter --literal 'a.b*c'      # Search for literal string 'a.b*c' in all columns
tsv filter --invert-match 'test'  # Invert match: select rows that do NOT match the regex 'test'
tsv filter --flag=`<column>` 'pattern' # Flag matched rows in a new column named `<column>`

```

**slice**

Get only the rows in the range specified.

```bash
tsv slice 2               # Slice from the 3rd record to the end
tsv slice 0 2             # Slice the first three records
tsv slice -1              # Slice the last record
tsv slice -10             # Slice the last 10 records
tsv slice -10 --invert    # Get everything except the last 10 records

```

**sort**

Sorts data in lexicographical, natural, numerical, reverse, unique or random order.

```bash
tsv sort                      # Sort lexicographical 1, 10, 11, ..., 2...
tsv sort --numerical          # Sort numerical: 1, 2, 3, .... 10, 11...
tsv sort --natural            # Sort natural: file1, file2, .... file10...
tsv sort --case-insensitive   # Sort case insensitive
tsv sort --unique --reverse   # Sort in reverse order and show only rows unique in the sort columns
tsv sort 3,4                  # Sort after column 3 and 4

```

**reverse**

Reverses rows of CSV data.

**print**

Outputs data as a visual table with columns in alignment.

**edit**

Replace the value of a cell specified by its row and column.

```bash
tsv edit 0 0 aaa      # Set first column in the first row to "aaa"

```

**crop**

Crop the column to maximum length.

```bash
tsv crop 1 10         # Crop column 1 to maximum 10 characters
tsv crop name 10      # Crop column "name" to maximum 10 characters

```

**to**

Convert data to csv, postgres or sqlite table, Excel XLSX, or ODS.

```bash
tsv to csv                                                # Convert to CSV
tsv to json                                               # Convert to a newline-delimited JSON (JSONL/NDJSON)
tsv to xlsx --output=output.xlsx                          # Load data into xlsx file
tsv to ods --ouput=output.ods                             # Load data into ODS file
tsv to postgres                                           # Print dump to stdout
tsv to postgres --output dumpfile.sql                     # Create dump file
tsv to postgres 'postgres://testuser:pass@localhost/test' --table=mytable     # Load data to local database `test.mytable`, with user `testuser`, and password `pass`
tsv to postgres 'postgres://...' --table=mytable --schema=myschema            # Load data into a new/existing postgres schema
tsv to postgres 'postgres://...' --table=mytable --drop                       # Drop tables if they exist before loading
tsv to sqlite                                             # Print dump to stdout
tsv to sqlite --output dumpfile.sql                       # Create dump file
tsv to sqlite test.db --table=mytable                     # Load data to sqlite database `test.db`
tsv to sqlite test.db --table=mytable --drop              # Drop tables if they exist before loading

```


