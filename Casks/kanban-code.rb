cask "kanban-code" do
  version "0.1.32"
  sha256 "46707f14555d260ad36832bd509cc5c2ee34c3be44217184b9945e1f5a4940f6"

  url "https://github.com/langwatch/kanban-code/releases/download/v#{version}/KanbanCode-#{version}-macos.zip"
  name "Kanban Code"
  desc "Kanban board for running multiple Claude Code agents in parallel"
  homepage "https://github.com/langwatch/kanban-code"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "node"
  depends_on macos: :tahoe

  app "KanbanCode.app"
  binary "#{appdir}/KanbanCode.app/Contents/Resources/cli/dist/kanban.js", target: "kanban"

  zap trash: [
    "~/.kanban-code",
    "~/Library/Caches/com.kanban-code.app",
    "~/Library/Preferences/com.kanban-code.app.plist",
  ]

  caveats <<~EOS
    Kanban Code is not notarized. If macOS refuses to open it, run:
      xattr -dr com.apple.quarantine /Applications/KanbanCode.app
    Claude Code CLI is required.
  EOS
end
