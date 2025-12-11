# How to Use This Repository

## For Pool Publishers (Golden Ticket App Users)

### Step 1: Generate Your Ingot Pool
Use the Golden Ticket app to create your optimized ingot pool with strategically selected numbers.

### Step 2: Save Pool to Repository
Save your pool data to `ingot_pool.json` in this repository format.

### Step 3: Generate and Publish Checksum
Before the lottery draw, run:
```bash
./generate_checksum.sh
```

This creates `pool_checksum.txt` with the SHA-256 hash. **Commit and push this to the repository before the draw.**

### Step 4: After the Draw
Compare your pool results with the winning numbers and publish the results. Anyone can verify your pool wasn't modified after the checksum was published.

## For Verifiers (Anyone Wanting to Verify Authenticity)

### Verify Pool Integrity
To confirm the pool hasn't been modified since the checksum was published:

```bash
./verify_checksum.sh
```

Or manually:
```bash
sha256sum ingot_pool.json
# Compare the output with the checksum in pool_checksum.txt
```

### Check Timestamp
The checksum file includes a timestamp showing when it was generated. Check the git commit history to verify the checksum was committed before the draw date:

```bash
git log --follow pool_checksum.txt
```

## Understanding the Advantage

### Traditional Quickpick (Random Selection)
- 10 random entries
- Likely overlap in number selection
- No strategic distribution
- Pure chance coverage

### Golden Ticket Ingot Pool
- 10 optimized entries
- Maximum coverage of number space
- Strategic distribution minimizes overlap
- Pattern-based selection
- **Result: Higher probability of matching winning numbers**

## Example Scenario

**Before Draw (Dec 10, 2025)**
- Pool created: 10 entries with optimized numbers
- Checksum generated and committed to repository
- Published checksum: `87b0c7620be3e9859a7e21983034a399c5ddc8042448b5f0f7f97437e496d390`

**After Draw (Dec 11, 2025)**
- Winning numbers announced
- Check pool results against winners
- Verify pool integrity with checksum
- Compare with random selection performance

## Transparency Benefits

1. **Provable Pre-commitment** - Can't change numbers after seeing results
2. **Public Verification** - Anyone can verify authenticity
3. **Performance Tracking** - Build statistical evidence over time
4. **Trust Building** - Demonstrates methodology effectiveness

## Questions?

For questions about the Golden Ticket app or this verification system, please refer to the main README.md or contact the repository owner.
