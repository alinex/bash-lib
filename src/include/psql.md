# PostgreSQL Access

Library for easy database integration in bash scripts.

## Configuration

The following environment settings should be used:

- `PGUSER` PostgreSQL user name to connect as
- `PGPASSWORD` password to be used if the server demands password authentication
- `PGHOST` specifies the name of host to connect to
- `PGPORT` port number to connect to at the server host (if not default port 5432)
- `PGDATABASE` is the database name
- `PGLOG` set this flag to log the calls to postgreSQL

## Methods

### psql_exit

Check that the database connection is configured and exit with error message if not.

### psql_exec <query>

Run the given query and return only the results:

```bash
result=$(psql_exec <query>) || log_exit ALERT "Failed to export from DB"
```

The resulting text may contain the `UPDATE` or `DELETE` success message or in case of `SELECT` it will contain the resulting rows with `|` as record separator.

### psql_csv <query>

Run the given query and return the dataset as CSV including the column header:

```bash
psql_csv <query> >result.csv || log_exit ALERT "Failed to export from DB"
```
