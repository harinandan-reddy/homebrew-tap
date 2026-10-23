cask "redpanda-cpp" do
  arch arm: "arm64", intel: "x86_64"

  version "3.5.0-beta.2"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "0000000000000000000000000000000000000000000000000000000000000000"

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
