cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3813.2"
  sha256 arm:   "59fd2d5d6a02635993ed01dc12fed056d483b082f6878f39c9a3f2df1e6fa727",
         intel: "bc072b06bfc24288629d4778e93ff4d171b25701d37ef3be0fe2d3059ed1b2a4"

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
