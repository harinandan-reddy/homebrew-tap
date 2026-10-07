cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3704.1"
  sha256 arm:   "e362291b85f45e85ee6abd92258a1d0047b2c9e3b2c774e813c5adcb66ce7fba",
         intel: "c84a74213a7d14296cc43bba82afccf5062954cd35ce6279a27b02452043c9cd"

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
