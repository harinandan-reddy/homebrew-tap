cask "multica-desktop" do
  arch arm: "arm64", intel: "x64"

  version "0.6.3"
  sha256 arm:   "aabcb9ab2613a002c7013f58ac0ed5007bc48580f5ef242be996388dbbaaac7a",
         intel: "eba18a64ed1eb1ab5ff62a1b785bfe994621ed05eb683a11173dd72a34fbe95f"

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
