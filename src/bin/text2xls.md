# Convert CSV to XLS

Convert text file in CSV format to Excel binary format.

## Usage

Required switches:

    -i or --infile csv_infilename
    -o or --output xls_outfilename

Optional switches:

    -d or --delim alt_delimiter
      default delimiter is ','
    -h or --header
      Accepts no arguments.
      Bolds and background colors contents of topmost row.
    -b or --binary
    default mode is binary (permits LF inside a field).
    Use --nobinary do disable binary mode

Example:

    text2xls -i file1.csv -o file2.xls
