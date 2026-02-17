# tsv

## Transform tab separated table

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
<tsv> | tsv color <color> [options] <regex> <selection>
<tsv> | tsv print [options]
<tsv> | tsv to <format> [<destination>] [options]
```

### Options

```bash
-i, --input-file <file>     # file to read from instead of STDIN
-o, --output-file <file>    # file to write result to instead of STDOUT
-n, --no-headers            # input is without header
-r, --remove                # tsv headers --remove the header
--sort                      # sort columns in select
--literal                   # Treat the regex as a literal string do not interpret it
--exact                     # Match the ENTIRE field exactly
--invert                    # Filter/slice only rows that did not match
--flag <column>             # Do not filter but add a filter column containing 0 for not matched, else the row number
--numerical                 # sort numerical
--natural                   # sort natural (numbers in strings are treaded numerical)
--reverse                   # sort in reverse order
--ignore-case               # ignore case in filter and sorting
--column <num>              # column to colorize
--unique                    # keep only one line per sorted value
--schema <name>             # schema for to postgres export
--table <name>              # table name
--drop                      # drop table before insert to postgres
```

### Description


**headers**

Prints the column number and name (space separated) of the first row in the data.


```
1   Number
2   Name
```

Or you can remove the header line:


```
tsv headers --remove
```

**count**

Returns a count of the number of records in the data without the header.

**select**

Select columns from data efficiently.

This command lets you manipulate the columns in data. You can re-order,
duplicate, reverse or drop them. Columns can be referenced by index or by
name if there is a header row (duplicate column names can be disambiguated with
more indexing). Column ranges can also be specified. Finally, columns can be
selected using regular expressions.


```bash
tsv select 1,4                # Select the first and fourth columns
tsv select 1-4                # Select the first 4 columns (by index)
tsv select Header1-Header4    # Select the first 4 columns (by name)
tsv select 3-                 # Ignore the first 2 columns (by range)
tsv select '!1-2'             # Ignore the first 2 columns (by index)
tsv select 'Foo[2]'           # Select the third column named 'Foo':
tsv select 1,_                # Select the first and last columns, _ is a special character for the last column:
tsv select _-1                # Reverse the order of columns:
tsv select /^a/               # select columns starting with 'a' (regex)
tsv select '/^.*\d.*$/'       # select columns with a digit (regex)
tsv select '!/SSN|account_no|password/'   # remove SSN, account_no and password columns (regex)
tsv select 1- --sort          # Sort the columns lexicographically (i.e. by their byte values)
tsv select 1,4,5-7 --sort     # Select some columns and then sort them
tsv select '\"Date - Opening\",\"Date - Actual Closing\"'     # Quote column names that conflict with selector syntax:
```

**filter**

Filter only rows matching the condition.


```bash
tsv filter 'foo.*bar'             # Search for rows where any field contains the regex 'foo.*bar' (case sensitive)
tsv filter --ignore-case 'error' message     # Case insensitive search for 'error' in the 'message' column
tsv filter --exact 'completed' status  # Search for exact matches of 'completed' in the 'status' column
tsv filter --literal 'a.b*c'      # Search for literal string 'a.b*c' in all columns
tsv filter --invert-match 'test'  # Invert match: select rows that do NOT match the regex 'test'
tsv filter --flag=<column> 'pattern' # Flag matched rows in a new column named <column>
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

**color**

Colorize line with ansi colors.

For multiple colors run it multiple times in a pipe. But keep in mind that if a column will match multiple colors the first match will take precedence.
But if you use different formats like color, background and intensity they both will match.


```bash
tsv color `$CC_RED` 'foo.*bar'                          # Colorize rows where any field contains the regex 'foo.*bar' (case sensitive)
tsv color `$CC_RED`:`$CC_RESET_FG` --column=1 'foo.*bar'  # Colorize the first column and give the reset code to use
tsv color `$CC_RED` --ignore-case 'error' message       # Case insensitive colorize for 'error' in the 'message' column
tsv color `$CC_RED` --exact 'completed' status          # Colorize for exact matches of 'completed' in the 'status' column
tsv color `$CC_RED` --literal 'a.b*c'                   # Colorize for literal string 'a.b*c' in all columns
tsv color `$CC_RED` --invert-match 'test'               # Invert match: colorize rows that do NOT match the regex 'test'
```

**print**

Outputs data as a visual table with columns in alignment.

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

You may concat all this methods together as far as they output tsv further and in the end call `print` or `to`.


