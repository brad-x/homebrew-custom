class Libapplewm < Formula
  desc "X.org libAppleWM library."
  homepage "https://www.x.org"
  url "https://github.com/freedesktop/libAppleWM/archive/libAppleWM-1.4.1.tar.gz"
  sha256 "a973c40cc48e5efab9ab295ce497f746891b2fe59b274aa08010b8a7c99e96f8"
  license "NOASSERTION"

  depends_on "libxext"
  depends_on "xorgproto"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end

end
