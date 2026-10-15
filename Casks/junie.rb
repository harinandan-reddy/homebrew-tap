cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3659.6"
  sha256 arm:   "d9cc598405770257dadf70921b605adeb3b30bcde0201e0c77ec1b0254370634",
         intel: "bf3c17e3fd6fb2bb3a10d1c057d361ebe644143989a82b821d897d2dc7a0b516"

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
