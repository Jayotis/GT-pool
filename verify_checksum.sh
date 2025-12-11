#!/bin/bash

# Verify the ingot pool checksum
# This script verifies that the pool file hasn't been modified since checksum generation

POOL_FILE="ingot_pool.json"
CHECKSUM_FILE="pool_checksum.txt"

if [ ! -f "$POOL_FILE" ]; then
    echo "Error: $POOL_FILE not found"
    exit 1
fi

if [ ! -f "$CHECKSUM_FILE" ]; then
    echo "Error: $CHECKSUM_FILE not found"
    exit 1
fi

# Extract the checksum from the checksum file
STORED_CHECKSUM=$(grep -A 1 "SHA-256 Checksum:" "$CHECKSUM_FILE" | tail -n 1)

# Calculate current checksum
CURRENT_CHECKSUM=$(sha256sum "$POOL_FILE" | awk '{print $1}')

echo "Verifying ingot pool integrity..."
echo ""
echo "Stored checksum:  $STORED_CHECKSUM"
echo "Current checksum: $CURRENT_CHECKSUM"
echo ""

if [ "$STORED_CHECKSUM" = "$CURRENT_CHECKSUM" ]; then
    echo "✓ VERIFICATION SUCCESSFUL"
    echo "The ingot pool has not been modified since the checksum was generated."
    exit 0
else
    echo "✗ VERIFICATION FAILED"
    echo "The ingot pool has been modified or the checksum is incorrect."
    exit 1
fi
