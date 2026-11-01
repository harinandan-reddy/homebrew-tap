cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3959.2"
  sha256 arm:   "8045995fc923689df242572f11a8cd0e44ab759508ecbe3c7e4bac79405d9327",
         intel: "69dc7ef75773551f4f3c378cd63eddfb6e3eafadb9a30356f0b0710b5b469ff3"

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
