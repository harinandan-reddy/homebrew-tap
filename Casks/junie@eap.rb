cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "4020.4"
  sha256 arm:   "e74935eaef319351a48b18ff1a38c330174f46f60523178c044eb9c1ca2fc876",
         intel: "9b5382aaccc9c7274af10ce2a865244e99773e2b66c3e0cb3b8ce45b62b62a7d"

  url "https://github.com/JetBrains/junie/releases/download/#{version}/junie-eap-#{version}-macos-#{arch}.zip"
  name "Junie CLI (eap)"
  desc "JetBrains Junie CLI (eap channel)"
  homepage "https://www.jetbrains.com/junie"

  conflicts_with cask: ["junie", "junie@nightly"]

  # Wrapper disables the binary's self-update so Homebrew owns upgrades.
  preflight_steps do
    write_file "junie-brew",
               "#!/bin/bash\nJUNIE_SKIP_UPDATE_CHECK=1 exec \"{{staged_path}}/Applications/junie.app/Contents/MacOS/junie\" \"$@\"\n"
    set_permissions "junie-brew", "0755"
  end

  binary "junie-brew", target: "junie"

  zap trash: "~/.junie"
end
