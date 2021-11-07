class Vde < Formula
  desc "Ethernet compliant virtual network"
  homepage "https://vde.sourceforge.io/"
  url "https://github.com/virtualsquare/vde-2/tarball/534a09453f956f8f545ba4fe37413be1a139314d"
  version="534a"
  sha256 "2955839f6d0ccac3e17c9aeec88204ce78bc93c846ace9b323e5e69e6f090a95"
  license "GPL-2.0"
  revision 1

  livecheck do
    url :stable
    regex(%r{url=.*?/vde\d*?[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  def install
    system "autoreconf", "--install"
    system "./configure", "--prefix=#{prefix}", "--disable-python"

    ENV.deparallelize
    system "make", "install"
  end
end
