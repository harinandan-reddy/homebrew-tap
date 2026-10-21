cask "multica-desktop" do
  arch arm: "arm64", intel: "x64"

  version "0.6.5"
  sha256 arm:   "2ccf6f09101073be711759586e17ad6f05bd5ee756469d220aa3cd04c6f608fd",
         intel: "247ef9652c768909366a9338cd8b95149e90e2b97eb3d1bbccc51793f868a206"

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
