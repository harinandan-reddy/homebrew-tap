class Scip < Formula
  desc "CLI for the SCIP code intelligence protocol"
  homepage "https://github.com/scip-code/scip"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/scip-code/scip/releases/download/v0.10.0/scip-darwin-arm64.tar.gz"
      sha256 "7ea200390e0790b3da8999b7b1cd4e3597700dcb3d354911872523bfe0090779"
    else
      url "https://github.com/scip-code/scip/releases/download/v0.10.0/scip-darwin-amd64.tar.gz"
      sha256 "e1d5eb355e5fcfc1c6d6479dd94cb9334c24262a34e38ff514dd5a2231b779ec"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/scip-code/scip/releases/download/v0.10.0/scip-linux-arm64.tar.gz"
      sha256 "6ab677dc2c4bf2955975d0530766152e45daaa988f9404068d8adecacd0bb24c"
    else
      url "https://github.com/scip-code/scip/releases/download/v0.10.0/scip-linux-amd64.tar.gz"
      sha256 "eeb28ebbff443c01609fb1691809958f3f0c7a8651af689a5bc8560061cd8ab0"
    end
  end

  def install
    bin.install "scip"
  end

  test do
    assert_match "0.10.0", shell_output("#{bin}/scip --version")
  end
end
