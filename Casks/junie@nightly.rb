cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3818.1"
  sha256 arm:   "67592bf59ae78f62ed3d995ce888ebaecf36f4dcd74c59999461d540b848ae0e",
         intel: "0e05fc199c54ade8ef3d9da26652da750a4df5ff0d6750d6467b2f91f79a943e"

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
