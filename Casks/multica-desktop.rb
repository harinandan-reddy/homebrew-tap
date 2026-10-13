cask "multica-desktop" do
  arch arm: "arm64", intel: "x64"

  version "0.6.2"
  sha256 arm:   "0ce62042b6ba77525f78739b5370368acdd0a1f6928bf8acc37a1579e73f424c",
         intel: "5d662a7a77eca4d98fa9c0987981bc13338a87a9f4d945aaf31b4f3371c143a6"

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
