#!/bin/bash

# Generate checksum for ingot pool file
# This script creates a SHA-256 checksum that can be published before the draw
# to prove the pool was created beforehand and hasn't been tampered with

POOL_FILE="ingot_pool.json"
CHECKSUM_FILE="pool_checksum.txt"
CHECKSUM_VERIFY_FILE="pool_checksum_verify.txt"
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

if [ ! -f "$POOL_FILE" ]; then
    echo "Error: $POOL_FILE not found"
    exit 1
fi

# Generate SHA-256 checksum
CHECKSUM=$(sha256sum "$POOL_FILE" | awk '{print $1}')

# Write checksum with timestamp for documentation
cat > "$CHECKSUM_FILE" <<EOF
Golden Ticket Ingot Pool Checksum
==================================
Generated: $TIMESTAMP
Pool File: $POOL_FILE

SHA-256 Checksum:
$CHECKSUM

This checksum is published before the draw to verify the pool
was created beforehand and has not been modified.

To verify, use: ./verify_checksum.sh
Or manually: sha256sum -c pool_checksum_verify.txt
EOF

# Write checksum in standard format for sha256sum -c
echo "$CHECKSUM  $POOL_FILE" > "$CHECKSUM_VERIFY_FILE"

echo "Checksum generated successfully:"
echo "$CHECKSUM"
echo ""
echo "Checksum documentation saved to $CHECKSUM_FILE"
echo "Checksum verification file saved to $CHECKSUM_VERIFY_FILE"
