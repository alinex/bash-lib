title: Library

# Downloads

The optimized and compressed files are available as:

-   [Complete distribution](bash-lib.tgz) (~35kB archive)

Each of the combined and compressed following packages are self contained as a single bash script with some of the libraries:

-   [Base libraries](base.bash)
    including core, colors, log
-   [Info libraries](info.bash)
    including core, colors, log, info
-   [Process libraries](process.bash)
    including core, colors, log, process
-   [PSQL libraries](psql.bash)
    including core, colors, log, psql
-   [All libraries](all.bash)
    including core, colors, log, locking, info, psql

You should always only include one library. If you need multiple functions, include a bigger one.

> All of the above files are build from latest master branch automatically.

Also you may need the following script to check if your server is ready for the bash-lib or if you should install something:

-   [Install checker](install)
