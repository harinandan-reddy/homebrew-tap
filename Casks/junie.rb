cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3579.5"
  sha256 arm:   "924e8cc32510bbbc96c8890851b352001a75e3de3bda3ca844a9ce7cfadedd1e",
         intel: "d89a80a870b15f875de98b9af627188b86cab5890699f7691459a34981f79b94"

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
