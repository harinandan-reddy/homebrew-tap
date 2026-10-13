cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3659.4"
  sha256 arm:   "b426bcb7546cd90ff52177b9240f85ce17378de28fa0191287fcef6a8790ea2a",
         intel: "48c0e416effdcdcfade0a38e56009a5d6f9cdaf6d6e65c1d197bca40cca3548e"

  url "https://github.com/JetBrains/junie/releases/download/#{version}/junie-release-#{version}-macos-#{arch}.zip"
  name "Junie CLI (release)"
  desc "JetBrains Junie CLI (release channel)"
  homepage "https://www.jetbrains.com/junie"

  conflicts_with cask: ["junie@eap", "junie@nightly"]

  # Wrapper disables the binary's self-update so Homebrew owns upgrades.
  preflight_steps do
    write_file "junie-brew",
               "#!/bin/bash\nJUNIE_SKIP_UPDATE_CHECK=1 exec \"{{staged_path}}/Applications/junie.app/Contents/MacOS/junie\" \"$@\"\n"
    set_permissions "junie-brew", "0755"
  end

  binary "junie-brew", target: "junie"

  zap trash: "~/.junie"
end
