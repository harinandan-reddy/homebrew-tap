class Colibri < Formula
  desc "Run frontier MoE models on hardware you already own, pure C with experts streamed from disk"
  homepage "https://justvugg.github.io/colibri"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on "libomp"

    url "https://github.com/JustVugg/colibri/releases/download/v2.0.0/colibri-v2.0.0-macos-arm64.tar.gz"
    sha256 "faa0841b20b7efe3b3bbd537360a42bb8beeaa5031bfff3813ecb01367edf851"
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/JustVugg/colibri/releases/download/v2.0.0/colibri-v2.0.0-linux-x86_64.tar.gz"
    sha256 "aef2c1e7d5cbad3d27cc90d8432775acdc315ec51f6d7a67a2f13a936f9978ce"
  end

  depends_on "python@3.14"

  def install
    libexec.install Dir["*"]
    (bin/"coli").write_env_script libexec/"coli", PATH: "#{Formula["python@3.14"].opt_bin}:$PATH"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coli --version")
  end
end
