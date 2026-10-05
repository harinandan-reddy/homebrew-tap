class Abtop < Formula
  desc "Like htop, but for AI coding agents (Claude Code and Codex CLI sessions)"
  homepage "https://github.com/graykode/abtop"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/graykode/abtop/releases/download/v0.5.5/abtop-aarch64-apple-darwin.tar.xz"
      sha256 "9d0b4554d1efcde099d86197edec48d6dc19e2eea3df133a960ad2ecdfe18703"
    end
    on_intel do
      url "https://github.com/graykode/abtop/releases/download/v0.5.5/abtop-x86_64-apple-darwin.tar.xz"
      sha256 "d44923a88b3ec214b496e72a16fdb426e2f7aadc0324515c4c2fbb8e93c68a7b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/graykode/abtop/releases/download/v0.5.5/abtop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4820294003933717ec5e906d9bbc475f2f751c03ed079d25eda1ebcd9e2ab58c"
    end
    on_intel do
      url "https://github.com/graykode/abtop/releases/download/v0.5.5/abtop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ae2f264561c11751748b4a6fb254a1648d5951fb541cf6d8e074f2cf75bdedf8"
    end
  end

  def install
    bin.install "abtop"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/abtop --version")
  end
end
