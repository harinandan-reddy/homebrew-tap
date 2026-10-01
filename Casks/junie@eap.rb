cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3579.3"
  sha256 arm:   "4a675375c565bde521bcadf05739b37934dd2a702f501c94cbc72dad731c72c3",
         intel: "1b6cb5259b321ad89a7a5f3a9e2703cdc5422bae0c986c84f7aece8336dfe1fe"

  url "https://github.com/JetBrains/junie/releases/download/#{version}/junie-eap-#{version}-macos-#{arch}.zip"
  name "Junie CLI (eap)"
  desc "JetBrains Junie CLI (eap channel)"
  homepage "https://www.jetbrains.com/junie"

  conflicts_with cask: ["junie", "junie@nightly"]

  # Wrapper disables the binary's self-update so Homebrew owns upgrades.
  preflight_steps do
    write_file "junie-brew",
               "#!/bin/bash\nJUNIE_SKIP_UPDATE_CHECK=1 exec \"{{staged_path}}/Applications/junie.app/Contents/MacOS/junie\" \"$@\"\n"
    set_permissions "junie-brew", "0755"
  end

  binary "junie-brew", target: "junie"

  zap trash: "~/.junie"
end
