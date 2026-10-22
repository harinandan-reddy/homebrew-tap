cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3897.1"
  sha256 arm:   "33f04099f4e872da04ebf0dea7c4ec6200057c2ef4c57bd9d7f7a3ff9daead9a",
         intel: "36b1367b1af0061cdcf7909316b55967e2ea1ab3eb81681ce7ca7d8368ede5fa"

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
