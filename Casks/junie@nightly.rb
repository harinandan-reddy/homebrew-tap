cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3887.1"
  sha256 arm:   "a41ae35e3982fafcd577d724a30d29c79788ae5fff703df36d4e394792e7ea50",
         intel: "3e13c287e5625e89cffcf81d2ed8ff1db839c677bfa2640b850505495809ccca"

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
