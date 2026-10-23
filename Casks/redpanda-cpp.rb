cask "redpanda-cpp" do
  arch arm: "arm64", intel: "x86_64"

  version "3.5.0-beta.2"
  sha256 arm:   "7ec8128346223e00eaacce787a8b5914a714ead0c62cf05fbc1a145cc1759fd0",
         intel: "deacd57f9240461b072fdffe519c23a51a3d54c8ed1b266dc2c5f452b4aee54c"

  url "https://github.com/harinandan-reddy/homebrew-tap/releases/download/redpanda-cpp-#{version}/RedPandaIDE-#{version}-macos-#{arch}.zip"
  name "Red Panda C++"
  desc "Cross-platform C++ IDE"
  homepage "https://github.com/royqh1979/RedPanda-CPP"

  livecheck do
    skip "Built by this tap's redpanda-cpp workflow"
  end

  depends_on macos: :sonoma

  app "RedPandaIDE.app"

  zap trash: [
    "~/Library/Preferences/com.royqh.RedPandaIDE.plist",
    "~/Library/Saved Application State/com.royqh.RedPandaIDE.savedState",
  ]

  caveats <<~EOS
    Red Panda C++ is ad-hoc signed and not notarized. If macOS refuses to open it, run:
      xattr -dr com.apple.quarantine /Applications/RedPandaIDE.app
    A C++ compiler is required, e.g. `xcode-select --install`.
  EOS
end
