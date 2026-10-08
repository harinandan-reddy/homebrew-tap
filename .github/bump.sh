#!/usr/bin/env bash
# Usage: bump.sh <formula-name> <owner/repo>
# Rewrites Formula/<name>.rb (or Casks/<name>.rb, using the asset digest) to the latest GitHub release. Release assets named in a
# *.sha256 file (or a combined SHA256SUMS) must match the file names in the formula URLs. No-op if up to date.
set -euo pipefail
f=Formula/$1.rb repo=$2
tag=$(gh release view --repo "$repo" --json tagName --jq .tagName)
ver=${tag#v}
if [ -f "Casks/$1.rb" ]; then
  # Cask with a single release asset: take its sha256 from the GitHub asset digest.
  f=Casks/$1.rb
  old=$(sed -nE 's/^  version "(.*)"/\1/p' "$f")
  [ "$old" = "$ver" ] && exit 0
  sum=$(gh release view "$tag" --repo "$repo" --json assets --jq '.assets[0].digest | sub("sha256:";"")')
  sed -i.bak -E "s/^  version \".*\"/  version \"$ver\"/; s/^  sha256 \".*\"/  sha256 \"$sum\"/" "$f"
  rm -f "$f.bak"
  echo "$ver"
  exit 0
fi
old=$(grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' "$f" | head -1)
old=${old#v}
[ "$old" = "$ver" ] && exit 0
tmp=$(mktemp -d)
gh release download "$tag" --repo "$repo" -p '*.sha256' -p 'SHA256SUMS' -D "$tmp"
sed -i.bak "s/${old//./\\.}/$ver/g" "$f"
cat "$tmp"/* | while read -r sum name; do
  [ -n "$name" ] || continue
  sed -i.bak "/$name/{n;s/sha256 \".*\"/sha256 \"$sum\"/;}" "$f"
done
rm -f "$f.bak"
echo "$ver"
