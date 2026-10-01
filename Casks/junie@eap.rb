cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3579.2"
  sha256 arm:   "3c7e2733d70f75574028bbb7a2bf0428ab5ecd6674d3cdee2f4fad82b88b6499",
         intel: "993a23653498519ae7435220cbaf9efb61f7bd473da70190e7c52f6cc2a9af89"

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
