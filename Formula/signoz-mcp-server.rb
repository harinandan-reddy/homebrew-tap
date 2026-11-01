class SignozMcpServer < Formula
  desc "MCP Server for SigNoz"
  homepage "https://github.com/SigNoz/signoz-mcp-server"
  version "0.17.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_arm64.tar.gz"
      sha256 "0f78c6ac89e24d0d1fafba34e44f83f0221af1e443ddb9e4d72fbc8ce57d5c4c"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_amd64.tar.gz"
      sha256 "a71a9c918e387e8153bb36095d513d030618270b7728e90cb166ff9cdad36e82"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_arm64.tar.gz"
      sha256 "986ce3a23bef77dc85400e4cef9264562d3699927ab75220edaa69432a737cb5"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_amd64.tar.gz"
      sha256 "62b6749a238eb91593716ce1f43d51579f6d44fc15fb700f99c243febcf30335"
    end
  end

  def install
    bin.install Dir["**/bin/signoz-mcp-server"]
  end

  test do
    assert_predicate bin/"signoz-mcp-server", :executable?
  end
end
