cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3785.1"
  sha256 arm:   "4ee1bbb1cfc122610f751e4c3857c58ac53c58188bedea60ca2f62492cb6b8ad",
         intel: "f4b8c579cc4ceed0fc7dca5b1d8674dcd3fbb1c324c568c018100dc6a7110712"

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
