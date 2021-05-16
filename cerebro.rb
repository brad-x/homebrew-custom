class Cerebro < Formula
  desc "cerebro is an open source(MIT License) elasticsearch web admin tool built using Scala, Play Framework, AngularJS and Bootstrap."
  homepage "https://github.com/lmenezes/cerebro"
  url "https://github.com/lmenezes/cerebro/releases/download/v0.9.3/cerebro-0.9.3.tgz"
  sha256 "8fb294ffae01faf3ea8f980760db199b8dcb2bd44c406f63ae3078301ff62753"
  license "MIT"

  depends_on "openjdk"

  def install
    rm_f Dir["bin/*.bat"]
    bin.install Dir[bin/"*"]
    (etc/"cerebro").install "conf"
    lib.install Dir[lib/"*"]
    bin.install "bin/cerebro"
  end
end
