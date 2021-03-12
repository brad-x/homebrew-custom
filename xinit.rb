class Xinit < Formula
  desc ""
  homepage ""
  url "https://www.x.org/pub/individual/app/xinit-1.4.1.tar.bz2"
  sha256 "de9b8f617b68a70f6caf87da01fcf0ebd2b75690cdcba9c921d0ef54fa54abb9"
  license ""

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "util-macros" => :build

  depends_on "xauth"
  depends_on "xset"
  depends_on "xrdb"

  def install
    ENV.prepend "CPPFLAGS", "-F#{MacOS.sdk_path}/System/Library/Frameworks/ApplicationServices.framework/Frameworks/"
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-launchd-id-prefix=com.brad-x
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "autoreconf", "-fvi"
    system "./configure", *args
    system "make", "install"
  end
end
