class Mkfontscale < Formula
  desc ""
  homepage ""
  url "https://www.x.org/archive/individual/app/mkfontscale-1.2.1.tar.gz"
  sha256 "e5b687029e44d0bd3ccd254a4da6a5cbfc40350aa8b43fcca16ef6e9b9bb9f22"
  license ""

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "util-macros" => :build

  depends_on "xorgproto"
  depends_on "bzip2"
  depends_on "zlib"
  depends_on "libfontenc"

  def install
    ENV.prepend "CPPFLAGS", "-F#{MacOS.sdk_path}/System/Library/Frameworks/ApplicationServices.framework/Frameworks/"
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-bzip2
    ]

    system "autoreconf", "-fvi"
    system "./configure", *args
    system "make", "install"
  end
end
