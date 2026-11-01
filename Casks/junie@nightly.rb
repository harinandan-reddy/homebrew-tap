cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3975.1"
  sha256 arm:   "b532e18cd7374e5b5366a0afb5d94f81dbbbe5d9566ea7d390726775d4c4db71",
         intel: "9edf05052c15b5570bb1424a0de1bd7113ea4c4b9da308c68a97dda1dcf32d53"

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
