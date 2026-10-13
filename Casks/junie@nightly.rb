cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3775.1"
  sha256 arm:   "9185927f791f22ad1955460fce779bfcdd22ae291db0b8cea2abe6772ec3ad20",
         intel: "3db18ebe9ed6b3c33bb3c18755dcfe35eaf998d704484c386c74990a24e9bacb"

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
