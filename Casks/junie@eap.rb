cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3659.2"
  sha256 arm:   "5c7921bdfc548d715c0148fd2f9320c8ecae4b14a8d9b5f7684f1051d37dcae2",
         intel: "a5fa2b7a03b50feb72a88a1065bcec7606609cf5d43643271fa862f7666f4f77"

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
