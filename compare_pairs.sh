#!/bin/bash
# compare_pairs.sh
# Lists .fastq.gz files that are present only in one of the paired directories
# and reports the number of complete and incomplete pairs.

dirR1="./R1/filtered"
dirR2="./R2/filtered"

pairs=0
missing=0
mismatch=0

# Check files in R1 and look for their R2 partners
for f in "$dirR1"/*_R1_*.fastq.gz; do
    [ -e "$f" ] || continue
    partner="$dirR2/$(basename "$f" | sed 's/_R1_/_R2_/')"
    if [ -f "$partner" ]; then
        pairs=$((pairs+1))
        lines1=$(gzip -cd "$f" | wc -l)
        lines2=$(gzip -cd "$partner" | wc -l)
        if [ "$lines1" -ne "$lines2" ]; then
            echo "Line count mismatch: $f ($lines1 lines) vs $partner ($lines2 lines)"
            mismatch=$((mismatch+1))
        fi
    else
        echo "$f"
        missing=$((missing+1))
    fi
done

# Check files in R2 that lack an R1 partner
for f in "$dirR2"/*_R2_*.fastq.gz; do
    [ -e "$f" ] || continue
    partner="$dirR1/$(basename "$f" | sed 's/_R2_/_R1_/')"
    if [ ! -f "$partner" ]; then
        echo "$f"
        missing=$((missing+1))
    fi
done

printf "Found %d complete pairs\n" "$pairs"
printf "%d incomplete pairs detected\n" "$missing"
printf "%d pairs with mismatched line counts\n" "$mismatch"

