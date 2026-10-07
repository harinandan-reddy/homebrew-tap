cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3700.1"
  sha256 arm:   "19c67a31025d35d2e2b7348bc3164636f6428598411ba550589c166e9547071c",
         intel: "4978d9bdcd3d27ff92aaca23a53a1b80a195bf210e2e208feb2b1215bac66ba2"

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
