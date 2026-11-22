cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "4171.5"
  sha256 arm:   "1e0fb6d5f036cc101c18f7964897ac1b6f0abf0a9043df5b97fa29ff2d25fde9",
         intel: "8d778fe081f765a5ad072a86e7ad87da0915d8ce19adbf6219c18a88439bc15c"

  url "https://github.com/JetBrains/junie/releases/download/#{version}/junie-eap-#{version}-macos-#{arch}.zip"
  name "Junie CLI (eap)"
  desc "JetBrains Junie CLI (eap channel)"
  homepage "https://www.jetbrains.com/junie"

  conflicts_with cask: ["junie", "junie@nightly"]

  # Wrapper disables the binary's self-update so Homebrew owns upgrades.
  preflight_steps do
    write_file "junie-brew",
               "#!/bin/bash\nJUNIE_SKIP_UPDATE_CHECK=1 exec \"{{staged_path}}/Applications/junie.app/Contents/MacOS/junie\" \"$@\"\n"
    set_permissions "junie-brew", "0755"
  end

  binary "junie-brew", target: "junie"

  zap trash: "~/.junie"
end
