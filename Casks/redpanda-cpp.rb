cask "redpanda-cpp" do
  version "3.5.0-beta.2"
  sha256 "616b524ddd1bd6e93a0c1e079b5163517aa7d61e1a6c40db6e3b889716e5ca21"

  url "https://github.com/harinandan-reddy/homebrew-tap/releases/download/redpanda-cpp-#{version}/RedPandaIDE-#{version}-macos.zip"
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
