class Libxfontcache < Formula
  desc ""
  homepage ""
  url "https://www.x.org/archive/individual/lib/libXfontcache-1.0.5.tar.bz2"
  sha256 "0d639219549f51fa0e6b4414383f5d13e6c1638e66b3434f4626eb989ffacbce"
  license ""

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "util-macros" => :build

  depends_on "libxext"
  depends_on "xorgproto"
  depends_on "fontcacheproto"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "autoreconf", "-fvi"
    system "./configure", *args
    system "make", "install"
  end
end
