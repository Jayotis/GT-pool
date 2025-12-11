# GT-pool

A simple repository to store Golden Ticket ingot pools and related files.

Place your pool data, checksums, and results in the repository using the structure below.

Suggested structure
- pools/                # ingot_pool.json and any pool-related files
- checksums/            # pool_checksum.txt, pool_checksum_verify.txt
- combos/               # YYYY-MM-DD_combinations.txt files
- results/              # YYYY-MM-DD_results.txt files
- scripts/              # helper scripts like generate_checksum.sh, verify_checksum.sh

How to add files
1. Add your files to the appropriate directory (see structure above).
2. Commit and push with a clear message describing the file and date.
   Example: git add pools/ingot_pool.json && git commit -m "Add ingot pool 2025-12-11" && git push

Optional notes
- Name combination and result files with the date (YYYY-MM-DD) so they are easy to track.
- If you publish checksums before a draw, put them in checksums/ and include a short note in the corresponding results file linking back to the checksum.

```
