class Fontcacheproto < Formula
  desc ""
  homepage ""
  url "https://www.x.org/archive/individual/proto/fontcacheproto-0.1.3.tar.gz"
  sha256 "759b4863b55a25bfc8f977d8ed969da0b99b3c823f33c674d6da5825f9df9a79"
  license ""

  depends_on "pkg-config" => [:build, :test]
  depends_on "util-macros" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-launchd-id-prefix=com.brad-x
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "autoconf"
    system "./configure", *args
    system "make", "install"
  end
end
