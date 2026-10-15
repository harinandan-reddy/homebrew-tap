cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3800.1"
  sha256 arm:   "3caa820357e95a2b4b645361231e456b119656eafdf7a68d2dd6400c9f4c19df",
         intel: "d466fd3cc0e6442ffde108fe0c233011872dbac72fbb7d735b26a68b9714db90"

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
