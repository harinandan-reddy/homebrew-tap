cask "paisa" do
  arch arm: "arm64", intel: "amd64"

  version "0.7.8"
  sha256 arm:   "71c3d1bab4b8422d318b3492ecbf3cf92750196a3edec19982e16f84b8795a7c",
         intel: "bf37c9c33a9aff2573bf77c2d0a9f1dc1d126a44fa461a21995fab5dfbf492a6"

  url "https://github.com/ananthakumaran/paisa/releases/download/v#{version}/paisa-app-macos-#{arch}.dmg"
  name "Paisa"
  desc "Personal finance manager"
  homepage "https://paisa.fyi/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Paisa.app"

  zap trash: [
    "~/Library/Caches/fyi.paisa.Paisa",
    "~/Library/Preferences/fyi.paisa.Paisa.plist",
  ]
end
