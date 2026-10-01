cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3623.1"
  sha256 arm:   "4823e61457da17187637097f052b1acd0664f6368a79a90a642410ec4db0fa36",
         intel: "2f4ae950989a7a43a2ed5901a330e3df32a079abeb8cdd4c96f2cc697f4523fa"

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
