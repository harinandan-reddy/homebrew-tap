cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3899.1"
  sha256 arm:   "3e87b8e72e8190228cfe0e2b4100f1c2af1beb71e5b941b55294752dbfbce3dc",
         intel: "a3066d87ec34b2f295fa8f307fc6ac834d50e30c7dd7142316046db3f2a283fd"

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
