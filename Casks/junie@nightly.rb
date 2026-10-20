cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3860.1"
  sha256 arm:   "949bca615bcf4bc723e49a64dbf293d1bbc1e8d808b6e801fd510cc76191977c",
         intel: "d8c5a3ee5e91fe41d403a55aa0a3fa8d22d06ce5f1264cfc03750a0bb161b4d2"

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
