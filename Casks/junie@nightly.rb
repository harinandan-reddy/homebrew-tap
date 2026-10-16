cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3839.1"
  sha256 arm:   "e23fbf3b1576100ec9837e927b8edb71fd9a5f0282d903945e6883b691d432aa",
         intel: "f667306cea3bd9ed41d516cc48510310c9a3824bf9b5fcd78ef94b1155840025"

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
