class Xauth < Formula
  desc ""
  homepage ""
  url "https://www.x.org/archive/individual/app/xauth-1.1.tar.gz"
  sha256 "e9fce796c8c5c9368594b9e8bbba237fb54b6615f5fd60e8d0a5b3c52a92c5ef"
  license ""

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "util-macros" => :build

  depends_on "libxext"
  depends_on "libxmu"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "autoconf"
    system "./configure", *args
    system "make", "install"
  end
end
