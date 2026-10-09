cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3736.1"
  sha256 arm:   "34489c9d60f4003c3ed876247c23d68e93cb105fcc72410306530811dc55913f",
         intel: "4ea7cbfb88fe1c1aac3270897ef954de1f0250ab7a81ace317d6fbff93be73b5"

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
