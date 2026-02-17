# compress

## Compress data stream using multiple algorithms.

### Usage

```bash
compress [<string>]
<string> | compress
```

### Options

```bash
-i, --input <path>         # file to read from
-o, --output <path>        # file to write to
-t, --tool <compression>   # compression: gzip, zip,...
-d, --decompress
```

### Tools used

- gzip
- bzip2
- xz
- zstd
- lz4
- zip
- 

### Description


| Tool  | Algorithmus             | Geschwindigkeit | Kompressionsrate  | Datenintegrität | Dateiendung |
| ----- | ----------------------- | --------------- | ----------------- | --------------- | ----------- |
| gzip  | DEFLATE (Lempel-Ziv)    | Sehr schnell    | Mittel            | CRC32           | .gz         |
| bzip2 | Burrows-Wheeler         | Langsam         | Hoch              | CRC32           | .bz2        |
| xz    | LZMA2                   | Sehr langsam    | Sehr hoch         | CRC64 / SHA-256 | .xz         |
| zstd  | Zstandard (FSE/Huffman) | Extrem schnell  | Hoch (skalierbar) | XXH64           | .zst        |
| lz4   | LZ4                     | Ultrafast       | Niedrig           | XXH32           | .lz4        |

Zip is not supported at the moment, because it can not work with streams but files only.

