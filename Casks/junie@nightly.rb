cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3867.1"
  sha256 arm:   "231d39365f5e25d9b881d5840c332e4352986f031a00b0071c49242bcaf10a71",
         intel: "c6550b28872c0f2f899f41c9ef2d0e1ebebec7dc6ed49b1bd8f7366b6ff79208"

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
