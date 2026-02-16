# option_help

## Print help for options defined in options specification

### Usage

```bash
option_help <spec>
<spec> lines := <short-letter>|- <long-word> <type>|- <description>
```

### Output (stdout)

Formatted options section for the help page like:


```text
-g <string>, --group <string>            Nur diese Gruppe anzeigen
--batch                                  Run non-interactive in batch mode
-n <name>, --net <name>                  Selektion des Netzes
-i <regexp>, --instance <regexp>         Pattern für Instanz
-s <regexp>, --summary <regexp>          Pattern für Zusammenfassung
-h, --help                               Show Help Page
```

### Examples

[`base_script`](../example/base_script.md) includes a simple example


### Description


This is mainly used by the [`help`](help.md) output.

It needs the same specification lines like [`option_parse`](option_parse.md).

