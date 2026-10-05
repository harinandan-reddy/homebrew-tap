class CcSessions < Formula
  desc "Fast CLI to list and resume Claude Code sessions across all projects"
  homepage "https://github.com/chronologos/cc-sessions"
  license "MIT"

  on_macos do
    # Upstream ships arm64 only; Intel Macs run it under Rosetta.
    on_arm do
      url "https://github.com/chronologos/cc-sessions/releases/download/v1.10.1/cc-sessions-macos-arm64"
      sha256 "1b81fce0c73d1d5d2ecc9025812e212aaa83f52d05f6d424264af1af3753b459"
    end
    on_intel do
      url "https://github.com/chronologos/cc-sessions/releases/download/v1.10.1/cc-sessions-macos-arm64"
      sha256 "1b81fce0c73d1d5d2ecc9025812e212aaa83f52d05f6d424264af1af3753b459"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chronologos/cc-sessions/releases/download/v1.10.1/cc-sessions-linux-arm64"
      sha256 "7698656962027e804e5efa8d7c494ff7697f90087ccb76b0996ab58c8dc7c95c"
    else
      url "https://github.com/chronologos/cc-sessions/releases/download/v1.10.1/cc-sessions-linux-x86_64"
      sha256 "8177f53c111c7716089ac6b739e527c7901c8df58a93a0a4052f250b747c84f1"
    end
  end

  def install
    bin.install Dir["cc-sessions-*"].first => "cc-sessions"
  end

  test do
    assert_match "1.10.1", shell_output("#{bin}/cc-sessions --version")
  end
end
