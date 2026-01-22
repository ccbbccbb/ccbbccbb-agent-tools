#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.10"
# dependencies = []
# ///
"""
Starknet data format converter.
Usage: uv run stark_convert.py <value>
"""
import sys
import hashlib

FELT_MAX = 2**251 + 17 * 2**192 + 1

def detect_and_convert(value: str):
    """Auto-detect input type and show all conversions."""
    value = value.strip()
    results = {}

    # Try as hex
    if value.startswith('0x') or value.startswith('0X'):
        try:
            as_int = int(value, 16)
            results['input_type'] = 'hex'
            results['decimal'] = as_int
            results['hex'] = value.lower()
            results['string'] = int_to_string(as_int)
            results['selector'] = f"(input is hex, not a name)"
            add_uint256_info(results, as_int)
        except ValueError:
            pass

    # Try as decimal
    if not results:
        try:
            as_int = int(value)
            results['input_type'] = 'decimal'
            results['decimal'] = as_int
            results['hex'] = hex(as_int)
            results['string'] = int_to_string(as_int)
            results['selector'] = f"(input is number, not a name)"
            add_uint256_info(results, as_int)
        except ValueError:
            pass

    # Try as string (for selector or short string)
    if not results:
        results['input_type'] = 'string'
        as_int = string_to_int(value)
        results['decimal'] = as_int
        results['hex'] = hex(as_int)
        results['string'] = value
        results['selector'] = hex(starknet_keccak(value))
        results['short_string_felt'] = as_int if len(value) <= 31 else "(too long)"

    return results

def int_to_string(n: int) -> str:
    """Convert felt to ASCII string."""
    if n == 0:
        return ""
    try:
        byte_len = (n.bit_length() + 7) // 8
        return n.to_bytes(byte_len, 'big').decode('ascii', errors='replace')
    except:
        return "(not valid ASCII)"

def string_to_int(s: str) -> int:
    """Convert ASCII string to felt (short string)."""
    return int.from_bytes(s.encode('ascii'), 'big')

def starknet_keccak(name: str) -> int:
    """Compute starknet_keccak selector for function/event name."""
    k = hashlib.sha3_256(name.encode('ascii')).digest()
    # Starknet uses first 250 bits
    return int.from_bytes(k, 'big') & ((1 << 250) - 1)

def add_uint256_info(results: dict, value: int):
    """Add uint256 low/high split."""
    results['u256_low'] = value & ((1 << 128) - 1)
    results['u256_high'] = value >> 128

def format_output(results: dict) -> str:
    """Format results for display."""
    lines = [f"Input type: {results.get('input_type', 'unknown')}", ""]

    if 'decimal' in results:
        lines.append(f"Decimal:    {results['decimal']}")
    if 'hex' in results:
        lines.append(f"Hex:        {results['hex']}")
    if 'string' in results:
        lines.append(f"String:     {results['string']}")
    if 'selector' in results:
        lines.append(f"Selector:   {results['selector']}")

    lines.append("")
    lines.append("uint256 split:")
    lines.append(f"  low:  {results.get('u256_low', 'N/A')}")
    lines.append(f"  high: {results.get('u256_high', 'N/A')}")

    return "\n".join(lines)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: stark_convert.py <value>")
        print("  value: hex (0x...), decimal, or string")
        sys.exit(1)

    value = " ".join(sys.argv[1:])
    results = detect_and_convert(value)
    print(format_output(results))
