cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "4131.1"
  sha256 arm:   "90bfb5e7873e8738cb009c576c6ec0c3c7398b01860af02ae390c632b16c7936",
         intel: "eacb4504896c177cb8d66abb9748cd1819686021ff8707d1c9edd02d517396d2"

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
