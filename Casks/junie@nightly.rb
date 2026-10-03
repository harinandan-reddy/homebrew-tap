cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3636.1"
  sha256 arm:   "75a93d60d56ddc3868d6cb2a8df65105e0dfa3a80ae9b40fc12cc6d3adf6d1a2",
         intel: "783f85a4e0622ad7284a1fdcc1696a9cdd4bf9d99b3d737da9c8347fdac685f0"

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
