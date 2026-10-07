cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3688.1"
  sha256 arm:   "f0515776444b656c368eba34cc7f7f4655ff3432fe85dfae5928f34536bccd85",
         intel: "f5aaf769d708f0eda05d8c2262df61e0348c7214813e224ec7c999bfb89121d2"

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
