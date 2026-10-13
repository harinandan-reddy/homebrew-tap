cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3773.1"
  sha256 arm:   "e8c5e151ca80c2d025686f922a82969eeca7f4f97076cc39919a637d0bb4c066",
         intel: "a0281be27ba11a522706f720f2e0604cf5c1c511b46e364d96b5a6d26b5aa599"

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
