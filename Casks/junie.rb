cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3813.7"
  sha256 arm:   "36f11ca9946add48a2a41cce9edaf2ca975c1443b5f11251beafb4e8718872ca",
         intel: "a1e095ad98fb73501f12e7938b8758a390a41d0a714c4b62e8e66c9b2a1397fe"

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
