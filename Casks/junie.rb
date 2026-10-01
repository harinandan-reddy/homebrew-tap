cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3419.22"
  sha256 arm:   "ae42bfa35dbfc1bfe9299b34d29d317cb234d17c136a726064b28f0e96417d6b",
         intel: "d85a45f50f82ac41587acef95d2c80720f1a9cd1de94a4fdb1e2e72926c8875a"

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
