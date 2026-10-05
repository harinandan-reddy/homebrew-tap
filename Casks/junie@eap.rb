cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3646.2"
  sha256 arm:   "0b4e96befb79b7fd0656e6229dd212cf6955c7abfb4ed1b2606313ffe770b87d",
         intel: "cec1cdbfff8e57e706c1fed0ac1e42408365f9eb1455c90db58a8f1e9394393a"

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
