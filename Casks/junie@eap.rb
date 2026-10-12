cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3659.3"
  sha256 arm:   "659eb470e90c1c627017e4b0d41edde61a3878f4c31a8667f91d2fc4ecfa1316",
         intel: "ac783f5382f3fb52e17199e3ff08354111589e10defdc9c2fe4b46ec7158f604"

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
