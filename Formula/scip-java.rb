class ScipJava < Formula
  desc "SCIP code intelligence indexer for Java, Scala and Kotlin"
  homepage "https://github.com/scip-code/scip-java"
  url "https://github.com/scip-code/scip-java/releases/download/v0.13.2/scip-java-v0.13.2"
  sha256 "5248136592d19ea2c468f64ebd18587d32de7c961536ff19346f8a025af1d13c"
  license "Apache-2.0"

  depends_on "openjdk"

  def install
    libexec.install "scip-java-v#{version}" => "scip-java"
    chmod 0755, libexec/"scip-java"
    (bin/"scip-java").write_env_script libexec/"scip-java", Language::Java.overridable_java_home_env
  end

  test do
    assert_match "scip-java", shell_output("#{bin}/scip-java --help")
  end
end
