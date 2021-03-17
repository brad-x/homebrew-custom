class QuartzWm < Formula
  desc "The quartz-wm window manager for XQuartz"
  homepage "https://www.xquartz.org"
  url "https://github.com/XQuartz/quartz-wm/releases/download/quartz-wm-1.3.2/quartz-wm-1.3.2.tar.xz"
  sha256 "3a4ff60ef53e7a37af2c7af3431aa0256a161807cce2161863c0657a5de2d1f5"
  license "NOASSERTION"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build

  depends_on "libxinerama"
  depends_on "libxrandr"
  depends_on "libapplewm"
  depends_on "pixman"


  def install
    args = %W[
      --with-bundle-id-prefix=com.brad-x \
      --with-launchagents-dir=#{prefix} \
      --with-launchdaemons-dir=#{prefix}
  ]

  system "autoreconf", "-fvi"
  system "./configure", *args
  system "make", "install"
  end
end
