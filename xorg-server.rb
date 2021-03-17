class XorgServer < Formula
  desc "X.Org Server"
  homepage "https://www.x.org"
  url "https://www.x.org/archive/individual/xserver/xorg-server-1.20.10.tar.gz"
  sha256 "02f2198608b6191b7f8c65158bd4613734ec1c5c3d6784c5177f41b5cd2d30a3"
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
