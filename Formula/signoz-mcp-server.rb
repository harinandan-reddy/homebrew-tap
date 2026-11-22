class SignozMcpServer < Formula
  desc "MCP Server for SigNoz"
  homepage "https://github.com/SigNoz/signoz-mcp-server"
  version "0.20.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_arm64.tar.gz"
      sha256 "567edbf1d7669dddeabca523d1d625688d8c4ee87ab0840e70f166a070dc9d7d"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_amd64.tar.gz"
      sha256 "bcddc7f2c0cbf9e02cb3b682640ccb5542580ad5ecb9c88e8c258fb74e856ebb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_arm64.tar.gz"
      sha256 "fa97f72c513d35c1fcf03b59db84f54c4525768b37e3c8d32eb8e7b874cbccd4"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_amd64.tar.gz"
      sha256 "a7ac13e665c48bd0e24b50175ae7a1f48b970ef511345e8c4cdd8e6be7320d5e"
    end
  end

  def install
    bin.install Dir["**/bin/signoz-mcp-server"]
  end

  test do
    assert_predicate bin/"signoz-mcp-server", :executable?
  end
end
