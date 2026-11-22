cask "paisa" do
  arch arm: "arm64", intel: "amd64"

  version "0.8.0"
  sha256 arm:   "558896960a547ba82eea344f81f5a93156ac31f6fb693999576241482a5d9aeb",
         intel: "944d313d8f2442c2e5eb42114f0a86c7364a2884f71615b98497ed4f52109d93"

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
