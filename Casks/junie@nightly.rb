cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3612.1"
  sha256 arm:   "bfafcc38d4d153408ce436ca3a637e6756e2bf96f3abe3333ee27504c8ea9d35",
         intel: "a81eb6365bddc8c4d6483834d3b82a10d23f2c07ea04fc06e9d8169e17472085"

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
