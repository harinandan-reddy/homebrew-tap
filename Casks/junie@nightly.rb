cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3844.1"
  sha256 arm:   "72b1c57b1928a3aeac29241f031bb7bbe5780aef97c2f376a04e18e51b874d23",
         intel: "2ee8d4251af45e07b402171b8de3ea89bc85b0b0df9dde84c3b2318551065d15"

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
