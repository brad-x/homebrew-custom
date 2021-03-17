class XorgServer < Formula
  desc "X.Org Server"
  homepage "https://www.x.org"
  url "https://www.x.org/archive/individual/xserver/xorg-server-1.20.10.tar.gz"
  sha256 "f66debdc8b7f1091dbfd3719ea7b80888b5d6bf4eb68ae34a94a1980356cfec3"
  license ""

  depends_on "pkg-config" => :build
  depends_on "mesa" => :build
  depends_on "xorgproto" => :build
  depends_on "xtrans" => :build

  depends_on "xinit"
  depends_on "quartz-wm"
  depends_on "xorg-fonts"
  depends_on "xkeyboardconfig"
  depends_on "libapplewm"
  depends_on "libxfixes"
  depends_on "libxfont"

  def install
    args = %W[
      --with-bundle-id-prefix=com.brad-x \
      --without-dtrace \
      --without-doxygen \
      --without-fop \
      --without-xmlto \
      --disable-devel-docs \
      --with-sha1=CommonCrypto \
      --disable-dri2 \
      --disable-dri3 \
      --with-launchagents-dir=#{prefix} \
      --with-launchdaemons-dir=#{prefix}
  ]

  system "autoreconf", "-fvi"
  system "./configure", *args
  system "make", "install"
  end
end
