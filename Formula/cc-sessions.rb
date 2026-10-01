class CcSessions < Formula
  desc "Fast CLI to list and resume Claude Code sessions across all projects"
  homepage "https://github.com/chronologos/cc-sessions"
  license "MIT"

  on_macos do
    # Upstream ships arm64 only; Intel Macs run it under Rosetta.
    on_arm do
      url "https://github.com/chronologos/cc-sessions/releases/download/v1.9.0/cc-sessions-macos-arm64"
      sha256 "42e2b74227ac42067bb7b76d6583fa1824f69beaa75046a80e8269d2c0111d72"
    end
    on_intel do
      url "https://github.com/chronologos/cc-sessions/releases/download/v1.9.0/cc-sessions-macos-arm64"
      sha256 "42e2b74227ac42067bb7b76d6583fa1824f69beaa75046a80e8269d2c0111d72"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chronologos/cc-sessions/releases/download/v1.9.0/cc-sessions-linux-arm64"
      sha256 "47f15cc5d31f0fb8b0cc8c75a568091239744e35f48e2b104c277fc3971cd9e8"
    else
      url "https://github.com/chronologos/cc-sessions/releases/download/v1.9.0/cc-sessions-linux-x86_64"
      sha256 "5cfa98fa8f6f27954b584ff4445e039b53c72caa7fd707f0005a02c627cb7d09"
    end
  end

  def install
    bin.install Dir["cc-sessions-*"].first => "cc-sessions"
  end

  test do
    assert_match "1.9.0", shell_output("#{bin}/cc-sessions --version")
  end
end
