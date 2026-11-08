cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "4040.1"
  sha256 arm:   "3e6855d49dfe36da435970a19ce38020ca110befdf0558e9d32b4d4f7ac6123c",
         intel: "7b5b18939b8201bcd46900605947784a3e3c658d841b7fa82726fc37ae5e2ca6"

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
