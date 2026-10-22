cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3893.1"
  sha256 arm:   "b875ced9a624b5b389616e14d6cbcdd412735b08575f7cf81a92d9d09e0e1f75",
         intel: "ace116cce581429ce96ba81a0be73245ace4ad667c44cb8e90dc477b964c6843"

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
