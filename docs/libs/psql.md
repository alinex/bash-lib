title: PostgreSQL

# PostgreSQL Access

Library for easy database integration in bash scripts.

## Configuration

The following environment settings should be used:

-   `PGUSER` PostgreSQL user name to connect as
-   `PGPASSWORD` password to be used if the server demands password authentication
-   `PGHOST` specifies the name of host to connect to
-   `PGPORT` port number to connect to at the server host (if not default port 5432)
-   `PGDATABASE` is the database name
-   `PGLOG` set this flag to log the calls to postgreSQL and the returned results

## Methods

### psql_exit

Check that the database connection is configured and exit with error message if not. A log message is emitted.

### psql_exec <query> or | psql_exec

Run the given query and return only the results:

```bash
result=$(psql_exec <query>) || log_exit ALERT "Failed to export from DB"
```

Another alternative is to pipe the sql commands into the process:

```bash
cat file.sql | psql_exec
```

The resulting text may contain the `UPDATE` or `DELETE` success message or in case of `SELECT` it will contain the resulting rows with `|` as record separator.

### psql_csv <query>

Run the given query and return the dataset as CSV including the column header:

```bash
psql_csv <query> >result.csv || log_exit ALERT "Failed to export from DB"
```

This may create a file with the following contents:

    id,status,changetime,description,reporter,story_priority,resolution,time,component,remaining_time,summary,priority,keywords,drp_resources,milestone,owner,rd_points,sprint,type
    34,accepted,2014-10-09 15:44:50.550308+00:00,,user,,,2014-10-01 16:54:17.745176+00:00,UT-Editor,4,some text,Alpha,,,Scrum Startup,user,,2nd Try,task
    39,new,2014-10-09 18:58:44.694814+00:00,"""hello""",user,,,2014-10-01 17:15:45.326223+00:00,Document Management,4,"""integration, test for DocumentService""",Alpha,,,Scrum Startup,user,,2nd Try,task
    43,new,2014-10-09 21:08:34.888938+00:00,"Content:
    - Something
    Todo:
    - Finally test on Beta",user,,,2014-10-02 15:34:05.008107+00:00,,,new Booking Process 1.1: Test on BetaServer,,,,Scrum Startup,user,5,2nd Try,story

As shown in the example above special cases are:

-   Record 2: containing quotes as content
-   Record 3: contains a multiline text field

### csv2html <csv> or | csv2html

A small helper which will convert a data export like from `psql_csv` into an HTML table:

```bash
echo "<html><body>" >>result.html
psql_csv <query> | csv2html >>result.html || log_exit ALERT "Failed to export from DB"
echo "</body></html>" >>result.html
```

### csv2xls <output-file> <csv> or | csv2xls <output-file>

Because opening CSV in Microsoft Excel correctly is not an easy task, better create the binary format:

```bash
psql_csv <query> | csv2xls result.xls || log_exit ALERT "Failed to export from DB"
```

> Keep in mind that the `install` command of the bash-lib have to be run to make this work.
