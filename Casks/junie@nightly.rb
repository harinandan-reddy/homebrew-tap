cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3749.1"
  sha256 arm:   "0fc09727ea9caa57933419386d4f98b728e0d8acd3eca11a80f5408c3960308d",
         intel: "4447cc3a45eff476faae9445a59245f9122ebbad31a3c1b35ada844986d81fdb"

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
