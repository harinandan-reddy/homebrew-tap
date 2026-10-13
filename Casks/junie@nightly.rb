cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3762.1"
  sha256 arm:   "d357776127c727c0afa8630c7767e27f45ddf221a0d4bcc4c50e0f8f45ae98c6",
         intel: "1e86f9bee06a2eeff8d301e899015776fc80f036e5b0673db8f8689009491c75"

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
