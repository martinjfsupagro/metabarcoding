# metabarcoding

This repository contains small utilities for processing paired FASTQ files.

## compare_pairs.sh

`compare_pairs.sh` checks that each file in `R1/filtered` has a matching
file in `R2/filtered`. It lists any unmatched files, counts the number of
complete pairs and reports how many pairs are incomplete. For each
matching pair it also verifies that both compressed FASTQ files contain
the same number of lines.

Run from the directory that contains the `R1` and `R2` folders:

```bash
chmod +x compare_pairs.sh
./compare_pairs.sh
```

