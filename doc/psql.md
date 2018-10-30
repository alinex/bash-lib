# PostgreSQL Access

Library for easy database integration in bash scripts.

## Configuration

The following environment settings should be used:

- `PGUSER` PostgreSQL user name to connect as
- `PGPASSWORD` password to be used if the server demands password authentication
- `PGHOST` specifies the name of host to connect to
- `PGPORT` port number to connect to at the server host (if not default port 5432)
- `PGDATABASE` is the database name

## Methods

### psql_exit

Check that the database connection is configured and exit with error message if not.

### psql_field

Read one field from database into variable:

```bash
result=$(psql_field <query>) || log_exit ALERT "Failed to to run DB call"
```

# psql_record <query>

# psql_records <query>

# psql_exec <query>
