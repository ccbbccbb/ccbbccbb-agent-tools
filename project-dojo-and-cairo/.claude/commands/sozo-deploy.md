---
description: Full deployment pipeline with testing and verification
allowed-tools: echo, sozo, jq
---

Complete build, test, and deploy workflow with deployment verification:

**Note:** For quick deployments without tests, use `/sozo-deploy` instead.

```bash
set -e  # Exit on any error

PROFILE="${1:-dev}"

echo "🔨 Building contracts (profile: $PROFILE)..."
sozo build --profile "$PROFILE"

echo ""
echo "🧪 Running tests..."
sozo test --profile "$PROFILE"

echo ""
echo "🚀 Migrating to blockchain..."
sozo migrate --profile "$PROFILE"

echo ""
echo "🔍 Inspecting deployed world..."
sozo inspect --profile "$PROFILE" --json > "deployed_$PROFILE.json"

echo ""
echo "✅ Deployment complete! Summary:"
echo ""
echo "World Address:"
jq -r '.world.address // "Not found"' "deployed_$PROFILE.json"

echo ""
echo "Deployed Contracts:"
jq -r '.contracts[]? | "  - \(.name) (\(.tag)): \(.address)"' "deployed_$PROFILE.json"

echo ""
echo "Models:"
jq -r '.models[]? | "  - \(.name): \(.class_hash)"' "deployed_$PROFILE.json"

echo ""
echo "📄 Full deployment manifest: manifest_$PROFILE.json"
echo "📄 Deployment snapshot: deployed_$PROFILE.json"
```

Usage:
- `/sozo-deploy` - Full pipeline with dev profile (default)
- `/sozo-deploy release` - Full pipeline with release profile

See also:
- `/sozo-migrate` - Quick build + migrate (no tests)
