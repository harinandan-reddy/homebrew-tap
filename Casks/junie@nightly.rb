cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3635.1"
  sha256 arm:   "b41b7b2e03bd979d01cc3a3d1b7ddf880b2e2f790638b0fe35b5efac4c9ec7af",
         intel: "538e0308bffbef9983ff545f055d508238a3689b9ec99fa7fbcf3a3f9cb18dd6"

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
