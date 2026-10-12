cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3579.7"
  sha256 arm:   "1e1d62527916ad815a83115ba68bb4af60e322b92ab428f5b1e3bb314d634e6f",
         intel: "fa2db84e7b780e51ff1c83e6e82916a309e29239be0fd07631a16bf6abbd8533"

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
