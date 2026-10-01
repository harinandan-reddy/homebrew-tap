#!/usr/bin/env bash
# Usage: bump.sh <formula-name> <owner/repo>
# Rewrites Formula/<name>.rb to the latest GitHub release. Release assets named in a
# *.sha256 file must match the file names in the formula URLs. No-op if up to date.
set -euo pipefail
f=Formula/$1.rb repo=$2
tag=$(gh release view --repo "$repo" --json tagName --jq .tagName)
ver=${tag#v}
old=$(grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' "$f" | head -1)
old=${old#v}
[ "$old" = "$ver" ] && exit 0
tmp=$(mktemp -d)
gh release download "$tag" --repo "$repo" -p '*.sha256' -D "$tmp"
sed -i.bak "s/${old//./\\.}/$ver/g" "$f"
cat "$tmp"/*.sha256 | while read -r sum name; do
  sed -i.bak "/$name/{n;s/sha256 \".*\"/sha256 \"$sum\"/;}" "$f"
done
rm -f "$f.bak"
echo "$ver"
