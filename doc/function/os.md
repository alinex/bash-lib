# os

## Detect OS settings and Hardware

### Usage

```bash
os_detect <format>
```

### Output (stdout)

- `<tsv-table>` for data
- `<value>` else


### Description


The following formats are possible:

- data - all values with `<name>	<value>`
- info - show human readable paragraph
- os - operating system type like Linux, Solaris, Windows
- base - base distribution type like Debian, ArchLinux
- base_revision_name - (optional)
- base_revision_number - (optional)
- distribution - real distribution name
- revision_number - distribution number
- revision_name - version code name
- kernel - version number of kernel like 6.8.0-87-generic
- architecture - x86_64, i686, i386, armv7l, aarch64...
- cpu_model - cpu name
- cpu_num - number of cpus
- memory - hardware memory in GB
- machine_id
- virtual_machine - `false` or `true`

