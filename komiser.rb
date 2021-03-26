class Komiser < Formula
  desc ":cloud: Cloud Environment Inspector 👮:lock: :moneybag:"
  homepage "https://komiser.io"
  url "https://github.com/mlabouardy/komiser/archive/refs/tags/2.4.0.tar.gz"
  sha256 "5d0eb9026605f40d39de12b046b6b691649f6b24377d2e9e01031646830dc16a"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-mod=vendor"
  end

end
