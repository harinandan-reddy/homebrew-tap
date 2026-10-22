cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3893.2"
  sha256 arm:   "aaf2e4bfd5d50a6df0a09c13e72fa0e7ff75436425a25371dbafad76901feb17",
         intel: "cd89f4c0e738c03a86fe45eecd4e6d1b3b37b075c277641f8447a2321909d2bf"

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
