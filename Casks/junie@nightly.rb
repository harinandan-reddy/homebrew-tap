cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3731.1"
  sha256 arm:   "15115e2d5484b9d8c24e58af4bbc31b4bb97482056185a2adc78ef4bd7c5c87c",
         intel: "bdadf5ce42882eede970bd33e4349457ce32293cc15a71a9cf295e9377ecc25d"

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
