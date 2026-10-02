cask "junie@eap" do
  arch arm: "aarch64", intel: "amd64"

  version "3579.4"
  sha256 arm:   "069ec5a7972e97ab4815fca5a870fcc487d313944574a65f0cfd259423b1c6b7",
         intel: "74264455d874a7e8b25f6b1e1089f0b3a0f14542ec3f8defe5b6c5b5191bd0cc"

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
