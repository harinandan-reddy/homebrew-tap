cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3629.1"
  sha256 arm:   "69d35a638a352deb5fd7f752bc9f3d4945065e2b520dcb36bc3f82af10f6276c",
         intel: "ca9ac7b3c52a473cbe239e8fefa09ebcdeb55ba4b34a6f8f1b8051bec2160a35"

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
