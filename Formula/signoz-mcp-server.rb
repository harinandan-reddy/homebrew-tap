class SignozMcpServer < Formula
  desc "MCP Server for SigNoz"
  homepage "https://github.com/SigNoz/signoz-mcp-server"
  version "0.15.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_arm64.tar.gz"
      sha256 "d6957894b9c5c10ecf01ade4ab2d841048d1cdd7027c04c692201162a0f9661d"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_amd64.tar.gz"
      sha256 "3ebbd11c892758a23474cbd7f2ec54f610a578a8bd89f40222067ffe8a0c1a81"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_arm64.tar.gz"
      sha256 "fd31faf102993f471e02c43e52bc69a956490c5beadfc5bb0b87710edbb1e5e4"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_amd64.tar.gz"
      sha256 "9b0ac2e11a84f71b35590bf128ebad607286649a7e23e0bd6bcb9c6f9a3457ce"
    end
  end

  def install
    bin.install Dir["**/bin/signoz-mcp-server"]
  end

  test do
    assert_predicate bin/"signoz-mcp-server", :executable?
  end
end
