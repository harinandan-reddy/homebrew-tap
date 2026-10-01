cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3611.1"
  sha256 arm:   "1e71f122b5d5f26019f209188bcd016e6ac470bc19f9a66a19f0f440a9044c95",
         intel: "234762e29b0042d152baa3257407ff3a0f2b51a259e554bae668df5e9795d8e8"

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
