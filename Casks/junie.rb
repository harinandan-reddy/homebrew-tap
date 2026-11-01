cask "junie" do
  arch arm: "aarch64", intel: "amd64"

  version "3893.6"
  sha256 arm:   "917bd6a481f0e0c0dd18abfeb5a6da3e23d5c9c529beeddffbb61742a925ff49",
         intel: "5263a3102e8fc6d3bd248b49138006559705690b23e6d025816f0e6b015f76fb"

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
