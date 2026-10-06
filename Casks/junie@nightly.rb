cask "junie@nightly" do
  arch arm: "aarch64", intel: "amd64"

  version "3680.1"
  sha256 arm:   "df7577649cd10934c17d855b9a154dc6b52b08a1b71bc5d34c5d049d9235bf01",
         intel: "462f4670ebb64d7198c142e9c493019ca9e435bcd8e8a06da3567040e209dc39"

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
