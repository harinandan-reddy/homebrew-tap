cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3874.1"
  sha256 arm:   "591bf5554e979f3172e08e51c29ff4d738d340c86f5d09ff12c134d65efe93e7",
         intel: "23ef2d6eb60a020c6232e3223b9e87ad53695548e8f587f971e412798d2b610c"

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
