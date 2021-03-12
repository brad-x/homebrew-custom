class Xset < Formula
  desc ""
  homepage ""
  url "https://www.x.org/archive/individual/app/xset-1.2.4.tar.gz"
  sha256 "3a05e8626298c7a79002ec5fb4949dcba8abc7a2b95c03ed5e0f5698c3b4dea0"
  license ""

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "util-macros" => :build

  depends_on "libxmu"
  depends_on "libxp"
  depends_on "libxfontcache"

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
