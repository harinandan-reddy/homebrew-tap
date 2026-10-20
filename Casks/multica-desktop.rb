cask "multica-desktop" do
  arch arm: "arm64", intel: "x64"

  version "0.6.4"
  sha256 arm:   "78e160c419420a6a6da9999cfcce4f9bc60c46cedd341fc56b2e9a8f0a9f0434",
         intel: "7b9e4bbe0734f4fae40242e612e3e48d5b0c4b6201751d0d352f6f5fd89929b4"

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
