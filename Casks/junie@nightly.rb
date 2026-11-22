cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "4193.1"
  sha256 arm:   "252bd6e13ea8f6769faa4f1d5899e7abd6fab80ee08eef78b1011ad5d84a9de4",
         intel: "f368144657d55b8c49d78e6e867931812a6cb2108684f7158c879ba1f5550c04"

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
