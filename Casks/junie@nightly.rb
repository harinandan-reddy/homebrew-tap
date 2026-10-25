cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3912.1"
  sha256 arm:   "017f6eedca590fdf7c0fb0adcb775f329323312119025408a3e06d00f2f9fd3d",
         intel: "c1e8b6382ac14f2f5e277b4af4d21eb19bb297c101d362afbb423276072037b9"

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
