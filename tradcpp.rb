class Tradcpp < Formula
  desc "a traditional (K&R-style) C preprocessor"
  homepage "http://ftp.netbsd.org/pub/NetBSD/misc/dholland/"
  url "http://ftp.netbsd.org/pub/NetBSD/misc/dholland/tradcpp-0.5.tar.gz"
  sha256 "f03fea0d8803f23ae1fd2fa552332e26966470844da219587ba6c604d02a4dc4"
  license "BSD"

  depends_on "bsdmake" => :build

  def install
    system "bsdmake"
    system "bsdmake", "install", "BINDIR=#{bin}", "MANDIR=share/man",
                                 "CATDIR=#{man}/cat1"
  end

end
