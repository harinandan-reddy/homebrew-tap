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
      url "https://github.com/JustVugg/colibri/releases/download/v2.1.0/colibri-v2.1.0-macos-arm64.tar.gz"
      sha256 "58320c9d92f84873820ced439c5dfe30afec64ebfc5ae7255ed8f34414d9e202"
    end
  end

  on_linux do
    # Upstream ships x86_64 only.
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/JustVugg/colibri/releases/download/v2.1.0/colibri-v2.1.0-linux-x86_64.tar.gz"
      sha256 "d54b4c57c12417fc9e784b649249ac1aa3480eec44ece2777d4cbc639a25e66a"
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
