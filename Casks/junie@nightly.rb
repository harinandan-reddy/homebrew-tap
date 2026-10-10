cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3750.1"
  sha256 arm:   "e505a4cbe8dd136af4f8d5dc657b578ead86ab25d16a6368c84cea71957c5d43",
         intel: "8a9156cbf3f2a6a7600d470b2fd0475c2995e8ea4c2bf44b096f6523dca21395"

  url "https://github.com/JetBrains/junie/releases/download/#{version}/junie-nightly-#{version}-macos-#{arch}.zip"
  name "Junie CLI (nightly)"
  desc "JetBrains Junie CLI (nightly channel)"
  homepage "https://www.jetbrains.com/junie"

  conflicts_with cask: ["junie", "junie@eap"]

  # Wrapper disables the binary's self-update so Homebrew owns upgrades.
  preflight_steps do
    write_file "junie-brew",
               "#!/bin/bash\nJUNIE_SKIP_UPDATE_CHECK=1 exec \"{{staged_path}}/Applications/junie.app/Contents/MacOS/junie\" \"$@\"\n"
    set_permissions "junie-brew", "0755"
  end

  binary "junie-brew", target: "junie"

  zap trash: "~/.junie"
end
