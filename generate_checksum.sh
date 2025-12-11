#!/bin/bash

# Generate checksum for ingot pool file
# This script creates a SHA-256 checksum that can be published before the draw
# to prove the pool was created beforehand and hasn't been tampered with

POOL_FILE="ingot_pool.json"
CHECKSUM_FILE="pool_checksum.txt"
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

if [ ! -f "$POOL_FILE" ]; then
    echo "Error: $POOL_FILE not found"
    exit 1
fi

# Generate SHA-256 checksum
CHECKSUM=$(sha256sum "$POOL_FILE" | awk '{print $1}')

# Write checksum with timestamp
cat > "$CHECKSUM_FILE" <<EOF
Golden Ticket Ingot Pool Checksum
==================================
Generated: $TIMESTAMP
Pool File: $POOL_FILE

SHA-256 Checksum:
$CHECKSUM

This checksum is published before the draw to verify the pool
was created beforehand and has not been modified.

To verify:
  sha256sum -c pool_checksum.txt
EOF

echo "Checksum generated successfully:"
echo "$CHECKSUM"
echo ""
echo "Checksum saved to $CHECKSUM_FILE"
