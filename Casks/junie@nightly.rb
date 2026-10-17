cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3843.1"
  sha256 arm:   "6ef9d95e8b537a7dd1ba871b1612a8cbfd4ee0fa114721429a9620b3984fb41a",
         intel: "7da3442d5e1e4fbf51116e8843226703201c021afac3268811d08b802acf9af1"

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
