#!/bin/bash

# Verify the ingot pool checksum
# This script verifies that the pool file(s) haven't been modified since checksum generation

POOL_FILE="ingot_pool.json"
CHECKSUM_FILE="pool_checksum.txt"
DATE=$(date -u +"%Y-%m-%d")
COMBINATIONS_FILE="${DATE}_combinations.txt"

if [ ! -f "$POOL_FILE" ]; then
    echo "Error: $POOL_FILE not found"
    exit 1
fi

if [ ! -f "$CHECKSUM_FILE" ]; then
    echo "Error: $CHECKSUM_FILE not found"
    exit 1
fi

# Check if checksum file has combinations entry
HAS_COMBINATIONS=$(grep -c "Combinations File:" "$CHECKSUM_FILE")

echo "Verifying ingot pool integrity..."
echo ""

# Extract pool JSON checksum using grep (line after "Pool File:")
STORED_POOL_CHECKSUM=$(grep -A 1 "^Pool File:" "$CHECKSUM_FILE" | tail -n 1 | sed 's/SHA-256 Checksum: //')
CURRENT_POOL_CHECKSUM=$(sha256sum "$POOL_FILE" | awk '{print $1}')

echo "Pool JSON File:"
echo "  Stored checksum:  $STORED_POOL_CHECKSUM"
echo "  Current checksum: $CURRENT_POOL_CHECKSUM"

POOL_VALID=false
if [ "$STORED_POOL_CHECKSUM" = "$CURRENT_POOL_CHECKSUM" ]; then
    echo "  ✓ Pool JSON verified"
    POOL_VALID=true
else
    echo "  ✗ Pool JSON verification FAILED"
fi

# Verify combinations file if it exists
COMBINATIONS_VALID=true
if [ "$HAS_COMBINATIONS" -gt 0 ] && [ -f "$COMBINATIONS_FILE" ]; then
    echo ""
    echo "Combinations File:"
    # Extract combinations checksum (line after "Combinations File:")
    STORED_COMB_CHECKSUM=$(grep -A 1 "^Combinations File:" "$CHECKSUM_FILE" | tail -n 1 | sed 's/SHA-256 Checksum: //')
    CURRENT_COMB_CHECKSUM=$(sha256sum "$COMBINATIONS_FILE" | awk '{print $1}')
    
    echo "  Stored checksum:  $STORED_COMB_CHECKSUM"
    echo "  Current checksum: $CURRENT_COMB_CHECKSUM"
    
    if [ "$STORED_COMB_CHECKSUM" = "$CURRENT_COMB_CHECKSUM" ]; then
        echo "  ✓ Combinations file verified"
    else
        echo "  ✗ Combinations file verification FAILED"
        COMBINATIONS_VALID=false
    fi
fi

echo ""
if [ "$POOL_VALID" = true ] && [ "$COMBINATIONS_VALID" = true ]; then
    echo "✓ VERIFICATION SUCCESSFUL"
    echo "The ingot pool has not been modified since the checksum was generated."
    exit 0
else
    echo "✗ VERIFICATION FAILED"
    echo "One or more files have been modified or the checksums are incorrect."
    exit 1
fi
