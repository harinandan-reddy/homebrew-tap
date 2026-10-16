cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3828.1"
  sha256 arm:   "1248dad0c7d6990eab54690e3b8d8d195fb54e449e60266698c4750a184a5ea3",
         intel: "7f05e9b3bac005d2013fbffabce43e388af02b8c9d7eb768d590df1ec33a02a3"

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
