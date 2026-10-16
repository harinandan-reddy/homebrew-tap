cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3659.7"
  sha256 arm:   "3134feec72550b394df5353e195a06a0627750c6717209c3bcbf7f2ecfeb89d5",
         intel: "02c18d5388441a9b1791cde7958c94458b50be389356bc8962caf769354b0b0d"

  url "https://github.com/JetBrains/junie/releases/download/#{version}/junie-release-#{version}-macos-#{arch}.zip"
  name "Junie CLI (release)"
  desc "JetBrains Junie CLI (release channel)"
  homepage "https://www.jetbrains.com/junie"

  conflicts_with cask: ["junie@eap", "junie@nightly"]

  # Wrapper disables the binary's self-update so Homebrew owns upgrades.
  preflight_steps do
    write_file "junie-brew",
               "#!/bin/bash\nJUNIE_SKIP_UPDATE_CHECK=1 exec \"{{staged_path}}/Applications/junie.app/Contents/MacOS/junie\" \"$@\"\n"
    set_permissions "junie-brew", "0755"
  end

  binary "junie-brew", target: "junie"

  zap trash: "~/.junie"
end
