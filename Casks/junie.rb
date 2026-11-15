cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "4020.10"
  sha256 arm:   "9ccd22132aae6f283e581716a8980a3d3c264de47cbf7d2dd5d0aac97d43b5bd",
         intel: "4613326033d387d364162cd7e0de78e38a03f7b2bca5f028b1340ccc1e0aa287"

  url "https://github.com/JetBrains/junie/releases/download/#{version}/junie-release-#{version}-macos-#{arch}.zip"
  name "Junie CLI (release)"
  desc "JetBrains Junie CLI (release channel)"
  homepage "https://www.jetbrains.com/junie"

  conflicts_with cask: ["junie@eap", "junie@nightly"]

  # Wrapper disables the binary's self-update so Homebrew owns upgrades.
  preflight_steps do
    write_file "junie-brew",
               "#!/bin/bash\nJUNIE_SKIP_UPDATE_CHECK=1 exec \"{{staged_path}}/Applications/junie.app/Contents/MacOS/junie\" \"$@\"\n"
    set_permissions "junie-brew", "0755"
  end

  binary "junie-brew", target: "junie"

  zap trash: "~/.junie"
end
