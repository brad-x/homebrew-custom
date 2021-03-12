class Xrdb < Formula
  desc ""
  homepage ""
  url "https://www.x.org/archive/individual/app/xrdb-1.2.0.tar.gz"
  sha256 "7dec50e243d55c6a0623ff828355259b6a110de74a0c65c40529514324ef7938"
  license ""

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "util-macros" => :build

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
