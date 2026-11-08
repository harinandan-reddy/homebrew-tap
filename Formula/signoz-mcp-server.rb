class SignozMcpServer < Formula
  desc "MCP Server for SigNoz"
  homepage "https://github.com/SigNoz/signoz-mcp-server"
  version "0.18.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_arm64.tar.gz"
      sha256 "e772fc2cab8f3518965b14f5f590e025fbaf09b471dab2333a60faa55c13ea32"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_amd64.tar.gz"
      sha256 "8776c787a2d72a2d38f3740ebee5ccf17343e8447d1cb41f24a7b06734fa429c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_arm64.tar.gz"
      sha256 "abeac58cb56e09ac394edc6be5213fab4568681bb82676bbf983b29410eb3c9e"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_amd64.tar.gz"
      sha256 "382a98b2d269741b4dd3730bd231834f274f29410fc8a6e84934a6c97c3453fd"
    end
  end

  def install
    bin.install Dir["**/bin/signoz-mcp-server"]
  end

  test do
    assert_predicate bin/"signoz-mcp-server", :executable?
  end
end
