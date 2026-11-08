class ScipJava < Formula
  desc "SCIP code intelligence indexer for Java, Scala and Kotlin"
  homepage "https://github.com/scip-code/scip-java"
  url "https://github.com/scip-code/scip-java/releases/download/v0.14.1/scip-java-v0.14.1"
  sha256 "06be799e2d9914e142ede285bb21c0f077e9ea84b6a835c90893c2fb048eeb53"
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
