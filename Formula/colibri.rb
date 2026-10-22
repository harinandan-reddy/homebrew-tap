class Colibri < Formula
  desc "Run frontier MoE models locally, pure C with experts streamed from disk"
  homepage "https://justvugg.github.io/colibri"
  license "Apache-2.0"

  depends_on "libomp" if OS.mac?
  depends_on "python@3.14"

  on_macos do
    # Upstream ships Apple Silicon only.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/JustVugg/colibri/releases/download/v2.0.0/colibri-v2.0.0-macos-arm64.tar.gz"
      sha256 "faa0841b20b7efe3b3bbd537360a42bb8beeaa5031bfff3813ecb01367edf851"
    end
  end

  on_linux do
    # Upstream ships x86_64 only.
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/JustVugg/colibri/releases/download/v2.0.0/colibri-v2.0.0-linux-x86_64.tar.gz"
      sha256 "aef2c1e7d5cbad3d27cc90d8432775acdc315ec51f6d7a67a2f13a936f9978ce"
    end
  end

  def install
    libexec.install Dir["*"]
    (bin/"coli").write_env_script libexec/"coli", PATH: "#{formula_opt_libexec("python@3.14")/"bin"}:$PATH"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coli --version")
  end
end
