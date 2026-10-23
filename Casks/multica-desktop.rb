cask "multica-desktop" do
  arch arm: "arm64", intel: "x64"

  version "0.7.0"
  sha256 arm:   "185b8c0ba3018b7a7dfc26a087710482e7ea8300265036aac26df10a0ea48ebd",
         intel: "bc55ec6d7608568fa881f5e8f4bba9bff63c4abcaa6afe0feef689c1e3d4f872"

  url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-desktop-#{version}-mac-#{arch}.zip"
  name "Multica"
  desc "Desktop app for managing AI agents as teammates"
  homepage "https://github.com/multica-ai/multica"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Multica.app"

  zap trash: [
    "~/Library/Application Support/Multica",
    "~/Library/Caches/ai.multica.desktop",
    "~/Library/Preferences/ai.multica.desktop.plist",
  ]
end
