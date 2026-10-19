cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3848.1"
  sha256 arm:   "7db2f4684c10797acf4f81661d131d3840a2cc881f689bba21f5e74818c2be4b",
         intel: "97a3b01db74bfeccf35003a9450f08ae057a9c15f22e7ac570277b72cb4fde2b"

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
