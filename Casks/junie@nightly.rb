cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3715.1"
  sha256 arm:   "ffbbe7830f1947599356ef1d5754c0d5efbd13b241a8459bffafbdd3095b6b51",
         intel: "df0f1add6dad06b90a98a531402f76bec74394f05f54f1494147ac9abc2bd145"

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
