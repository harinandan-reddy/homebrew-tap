cask "multica-desktop" do
  arch arm: "arm64", intel: "x64"

  version "0.6.1"
  sha256 arm:   "b3c1c0a69ff3c0741e8d02d480a6f8458e5873da210042b1f1956ca3208e9f62",
         intel: "933430c4bbbbd7fbbe4083f8fa1c2360de86652fe47bd03e39122c0b6676d0ff"

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
