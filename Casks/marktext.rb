cask "marktext" do
  arch arm: "arm64", intel: "x64"

  version "0.23.0"
  sha256 arm:   "91af19c192c2a7bcce7edd1daf4acde0f1f15445abdd619b8a4f60bb4b05dfc9",
         intel: "2ad2fb2f335e4452dd9c4af1d101e3bd7a8411b0a8857c92f5ccebf686c11de5"

  url "https://github.com/marktext/marktext/releases/download/v#{version}/marktext-mac-#{arch}-#{version}.zip"
  name "MarkText"
  desc "Markdown editor"
  homepage "https://github.com/marktext/marktext"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "MarkText.app"

  zap trash: [
    "~/Library/Application Support/marktext",
    "~/Library/Caches/com.github.marktext.marktext",
    "~/Library/Preferences/com.github.marktext.marktext.plist",
    "~/Library/Saved Application State/com.github.marktext.marktext.savedState",
  ]

  caveats <<~EOS
    MarkText is ad-hoc signed and not notarized. If macOS refuses to open it, run:
      xattr -dr com.apple.quarantine /Applications/MarkText.app
  EOS
end
