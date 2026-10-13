cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3779.1"
  sha256 arm:   "37f3c9cb4b6183d27f0129ef94d55530b645c7f4ac8d0d7c2e690f8d7a576d5d",
         intel: "cf674b88040534ef24e2a7b07e38b978050b5b85b820175a493dc5f84f816cf0"

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
