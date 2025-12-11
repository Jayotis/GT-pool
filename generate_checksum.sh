#!/bin/bash

# Generate checksum for ingot pool files
# This script creates a SHA-256 checksum that can be published before the draw
# to prove the pool was created beforehand and hasn't been tampered with

POOL_FILE="ingot_pool.json"
CHECKSUM_FILE="pool_checksum.txt"
CHECKSUM_VERIFY_FILE="pool_checksum_verify.txt"
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
DATE=$(date -u +"%Y-%m-%d")
COMBINATIONS_FILE="${DATE}_combinations.txt"

if [ ! -f "$POOL_FILE" ]; then
    echo "Error: $POOL_FILE not found"
    exit 1
fi

# Generate SHA-256 checksum for JSON pool
CHECKSUM=$(sha256sum "$POOL_FILE" | awk '{print $1}')

# Generate SHA-256 checksum for combinations file if it exists
if [ -f "$COMBINATIONS_FILE" ]; then
    COMBINATIONS_CHECKSUM=$(sha256sum "$COMBINATIONS_FILE" | awk '{print $1}')
    HAS_COMBINATIONS=true
else
    HAS_COMBINATIONS=false
fi

# Write checksum with timestamp for documentation
if [ "$HAS_COMBINATIONS" = true ]; then
cat > "$CHECKSUM_FILE" <<EOF
Golden Ticket Ingot Pool Checksum
==================================
Generated: $TIMESTAMP

Pool File: $POOL_FILE
SHA-256 Checksum: $CHECKSUM

Combinations File: $COMBINATIONS_FILE
SHA-256 Checksum: $COMBINATIONS_CHECKSUM

This checksum is published before the draw to verify the pool
was created beforehand and has not been modified.

To verify, use: ./verify_checksum.sh
Or manually: sha256sum -c pool_checksum_verify.txt
EOF
else
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
fi

# Write checksum in standard format for sha256sum -c
echo "$CHECKSUM  $POOL_FILE" > "$CHECKSUM_VERIFY_FILE"
if [ "$HAS_COMBINATIONS" = true ]; then
    echo "$COMBINATIONS_CHECKSUM  $COMBINATIONS_FILE" >> "$CHECKSUM_VERIFY_FILE"
fi

echo "Checksum generated successfully:"
echo "Pool JSON: $CHECKSUM"
if [ "$HAS_COMBINATIONS" = true ]; then
    echo "Combinations: $COMBINATIONS_CHECKSUM"
fi
echo ""
echo "Checksum documentation saved to $CHECKSUM_FILE"
echo "Checksum verification file saved to $CHECKSUM_VERIFY_FILE"
