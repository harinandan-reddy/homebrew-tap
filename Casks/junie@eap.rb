cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3813.3"
  sha256 arm:   "81598f93b1e3cdfa8fe8153938162520741a599f305eb8048a6e563a990b4959",
         intel: "abeb6bbeb7f02d6dd0dae351431e456605f345f50272636e207c6cbdbd66457a"

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
