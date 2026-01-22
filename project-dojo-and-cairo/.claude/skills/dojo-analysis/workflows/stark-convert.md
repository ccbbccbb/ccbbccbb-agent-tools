# Stark Convert

Convert between Starknet data formats on-demand.

## Usage

```bash
uv run .claude/skills/dojo-analysis/scripts/stark_convert.py <value>
```

## Examples

```bash
# Hex to decimal/string
uv run .claude/skills/dojo-analysis/scripts/stark_convert.py 0x68656c6c6f

# Decimal to hex/string
uv run .claude/skills/dojo-analysis/scripts/stark_convert.py 448378203247

# String to felt/selector
uv run .claude/skills/dojo-analysis/scripts/stark_convert.py transfer
```

## Sozo Calldata Prefixes (Encoding)

When calling contracts, sozo handles encoding:

| Prefix | Type |
|--------|------|
| `u256:` | uint256 (auto-splits) |
| `str:` | ByteArray |
| `sstr:` | Short string (≤31 chars) |
| `arr:` | Dynamic array |
| `int:` | Signed integer |

```bash
sozo execute Actions create u256:1000 str:hello
```
