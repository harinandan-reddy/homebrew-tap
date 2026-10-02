cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3419.29"
  sha256 arm:   "0940cb4f3b2ce6e19886b3aa120bc3959e2aa3ecac29183ff24f824d63d1f865",
         intel: "9886726c4bf2c73e850915e628f0d70d6d60ece43df8bddd04be345b34ada7c3"

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
