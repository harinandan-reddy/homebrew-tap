cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3809.1"
  sha256 arm:   "7487d593f80d7aa176142cbb3da9dce9a59b8a8b5df10687601b48f474d4045f",
         intel: "1832a6d5f34d573602f525fc9dc10df30c1137609fe95a43b247234dd9a7a047"

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
