cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3842.1"
  sha256 arm:   "532113f9a0a52e8e9d8b451da8bf0e2176c0cfcf8b7032890a4f7088fbbc5442",
         intel: "cb4e516b58277e2d0926bf2b14f96eec0a0b493d51494583311d3b4f6a35742f"

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
