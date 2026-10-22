cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3896.1"
  sha256 arm:   "0e6c7158e0e3a3d6f75ade415be0596a4ed040422ebb00132816d3efd87241e0",
         intel: "47899e36f3aa067b7180fa65521df3a92cf97ae1ffdba95a6fadce888345deb8"

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
