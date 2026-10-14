cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3796.1"
  sha256 arm:   "9aa12e0d6437a15c5114e1c888dab9c18cea194fa092ea8dae6b24060c6893ee",
         intel: "36bb7280060f351e8ec57778a32b7499fc598a838ac8480b3e77d5a07c7a36f7"

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
