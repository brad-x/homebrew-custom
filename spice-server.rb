# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class SpiceServer < Formula
  desc "Remote virtual machine display server"
  homepage "https://www.spice-space.org/"
  url "https://www.spice-space.org/download/releases/spice-server/spice-0.14.3.tar.bz2"
  sha256 "551d4be4a07667cf0543f3c895beb6da8a93ef5a9829f2ae47817be5e616a114"
  license "BSD"

  depends_on "autoconf" => :build
  depends_on "autogen" => :build
  depends_on "automake" => :build

  depends_on "glib"
  depends_on "pixman"
  depends_on "openssl@1.1"
  depends_on "opus"
  depends_on "spice-protocol"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl@1.1"].opt_lib/"pkgconfig"
    system "autoreconf"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  patch do
    url "https://raw.githubusercontent.com/brad-x/homebrew-custom/main/patches/spice-server/red-worker.patch"
    sha256 "67e3c7cf21249991cf3f9f6ba136bc90a11ce7dbff678764eb17b6b2bac9ffd7"
  end

  patch do
    url "https://raw.githubusercontent.com/brad-x/homebrew-custom/main/patches/spice-server/test-websocket.patch"
    sha256 "c7407e2f4797b48ad05acc94971147ff65945ad5b2fc5d613785a3c294576e98"

  test do
    system "false"
  end
end
