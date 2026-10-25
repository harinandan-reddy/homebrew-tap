cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3813.10"
  sha256 arm:   "824e0004ebb6337ba981b8eefa138a692a0e8500e0c16439100bb2b09bba1b9f",
         intel: "e629812488a52c9193cf79842e0db8d2cb9d5fc3cd6d85942d5672ecd1ea8b58"

  url "https://github.com/JetBrains/junie/releases/download/#{version}/junie-release-#{version}-macos-#{arch}.zip"
  name "Junie CLI (release)"
  desc "JetBrains Junie CLI (release channel)"
  homepage "https://www.jetbrains.com/junie"

  conflicts_with cask: ["junie@eap", "junie@nightly"]

  # Wrapper disables the binary's self-update so Homebrew owns upgrades.
  preflight_steps do
    write_file "junie-brew",
               "#!/bin/bash\nJUNIE_SKIP_UPDATE_CHECK=1 exec \"{{staged_path}}/Applications/junie.app/Contents/MacOS/junie\" \"$@\"\n"
    set_permissions "junie-brew", "0755"
  end

  binary "junie-brew", target: "junie"

  zap trash: "~/.junie"
end
