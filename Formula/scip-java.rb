class ScipJava < Formula
  desc "SCIP code intelligence indexer for Java, Scala and Kotlin"
  homepage "https://github.com/scip-code/scip-java"
  url "https://github.com/scip-code/scip-java/releases/download/v0.13.1/scip-java-v0.13.1"
  sha256 "a694cae143c32c5b6226362fb4bd268a8d13d3cd9b482819b3b0029a9a97b8fe"
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
