class SignozMcpServer < Formula
  desc "MCP Server for SigNoz"
  homepage "https://github.com/SigNoz/signoz-mcp-server"
  version "0.16.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_arm64.tar.gz"
      sha256 "5b41beae8760b6945129db287c4cff27248476da42c9be96b0263275a8cb0ffa"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_darwin_amd64.tar.gz"
      sha256 "77ca0a3823170fd578c4892ffecfe74178ea279a8e1094f0700e75cf64036281"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_arm64.tar.gz"
      sha256 "26c5e389cd577cdd365c011d0adf7dd727237e9d5a0ea6ea542bf854e6671084"
    else
      url "https://github.com/SigNoz/signoz-mcp-server/releases/download/v#{version}/signoz-mcp-server_linux_amd64.tar.gz"
      sha256 "12c7f2e58002cdf523120cc81c5304839a702ca3650c27a7dbdecee4ec01c6c2"
    end
  end

  def install
    bin.install Dir["**/bin/signoz-mcp-server"]
  end

  test do
    assert_predicate bin/"signoz-mcp-server", :executable?
  end
end
