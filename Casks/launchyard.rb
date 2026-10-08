cask "launchyard" do
  version "1.0.1"
  sha256 "b94077466289e6080cf0dc6cdebdd6bf0491048798ff63d068a3bfd3e7b00077"

  url "https://github.com/jayhickey/Launchyard/releases/download/v#{version}/Launchyard.zip"
  name "Launchyard"
  desc "Native app for managing launchd services"
  homepage "https://github.com/jayhickey/Launchyard"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Launchyard.app"

  zap trash: [
    "~/Library/Caches/com.finalbits.launchyard",
    "~/Library/Preferences/com.finalbits.launchyard.plist",
  ]

  caveats <<~EOS
    Launchyard is ad-hoc signed and not notarized. If macOS refuses to open it, run:
      xattr -dr com.apple.quarantine /Applications/Launchyard.app
  EOS
end
