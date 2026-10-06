cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3651.1"
  sha256 arm:   "26b959d1141024aafbe35c5353862e033c660dc6dabcc7f22ba92851a64c618f",
         intel: "f15795338ac3e4f5952154665b88b4e9e7ee5fd8ba858d55ca4a8b59fd26a4fe"

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
