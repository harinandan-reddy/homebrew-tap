cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3822.1"
  sha256 arm:   "9b841a46362774701757a324bdcee8beff3d7d46658ba8d6e2ba5059a7778cd0",
         intel: "f8f3d7801fb86a4f890ed3d16fd35621c82de9ba3e515174b274e942e6b1be82"

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
