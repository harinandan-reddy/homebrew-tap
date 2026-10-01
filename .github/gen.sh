#!/usr/bin/env bash
# Regenerate Casks/junie{,@eap,@nightly}.rb from the latest JetBrains/junie release per channel.
# Casks (not formulae): brew rewrites dylib paths in formulae, which breaks JetBrains' code signature.
set -euo pipefail
repo=JetBrains/junie
rels=$(gh api "repos/$repo/releases?per_page=100")

for ch in release eap nightly; do
  case $ch in
    release) tok=junie;         others='"junie@eap", "junie@nightly"' ;;
    eap)     tok=junie@eap;     others='"junie", "junie@nightly"' ;;
    nightly) tok=junie@nightly; others='"junie", "junie@eap"' ;;
  esac
  tag=$(jq -r --arg p "junie-$ch-" '[.[] | select(any(.assets[]; .name|startswith($p)))][0].tag_name' <<<"$rels")
  [ "$tag" != null ] || { echo "no $ch release" >&2; continue; }
  sum() { jq -r --arg n "junie-$ch-$tag-macos-$1.zip" '[.[].assets[] | select(.name==$n)][0].digest | sub("sha256:";"")' <<<"$rels"; }

  cat > "Casks/$tok.rb" <<RB
cask "$tok" do
  arch arm: "aarch64", intel: "amd64"

  version "$tag"
  sha256 arm:   "$(sum aarch64)",
         intel: "$(sum amd64)"

  url "https://github.com/$repo/releases/download/#{version}/junie-$ch-#{version}-macos-#{arch}.zip"
  name "Junie CLI ($ch)"
  desc "JetBrains Junie CLI ($ch channel)"
  homepage "https://www.jetbrains.com/junie"

  conflicts_with cask: [$others]

  # Wrapper disables the binary's self-update so Homebrew owns upgrades.
  preflight_steps do
    write_file "junie-brew",
               "#!/bin/bash\\nJUNIE_SKIP_UPDATE_CHECK=1 exec \\"{{staged_path}}/Applications/junie.app/Contents/MacOS/junie\\" \\"\$@\\"\\n"
    set_permissions "junie-brew", "0755"
  end

  binary "junie-brew", target: "junie"

  zap trash: "~/.junie"
end
RB
done
