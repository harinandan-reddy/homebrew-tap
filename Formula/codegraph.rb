class Codegraph < Formula
  desc "Pre-indexed local code knowledge graph for AI coding agents"
  homepage "https://github.com/colbymchenry/codegraph"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/colbymchenry/codegraph/releases/download/v1.6.2/codegraph-darwin-arm64.tar.gz"
      sha256 "d74d1bfb4060db63ec3c2b72c4e17f76c31978af3bad6ace4370d1501ac0662e"
    end
    on_intel do
      url "https://github.com/colbymchenry/codegraph/releases/download/v1.6.2/codegraph-darwin-x64.tar.gz"
      sha256 "53d1a4d1a9af31d6cec11b346df2ae792087081e13f623f583e27783c1e7f9bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/colbymchenry/codegraph/releases/download/v1.6.2/codegraph-linux-arm64.tar.gz"
      sha256 "c8c6be292be21d00dea26bad8b28d434731cf612fb8cc475dc10f5b3038b5b64"
    end
    on_intel do
      url "https://github.com/colbymchenry/codegraph/releases/download/v1.6.2/codegraph-linux-x64.tar.gz"
      sha256 "ef0af416092128fb1ccc723786000b7edf4a6971fe604acd08bf966e4f37b828"
    end
  end

  def install
    # Bundle is self-contained (own node + lib); the launcher resolves symlinks to find it.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/codegraph"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codegraph --version")
  end
end
