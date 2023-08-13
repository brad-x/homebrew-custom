# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class SpiceServer < Formula
  include Language::Python::Virtualenv

  desc "Remote virtual machine display server"
  homepage "https://www.spice-space.org/"
  url "https://www.spice-space.org/download/releases/spice-server/spice-0.15.2.tar.bz2"
  sha256 "6d9eb6117f03917471c4bc10004abecff48a79fb85eb85a1c45f023377015b81"
  license "BSD"

  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build
  depends_on "autogen" => :build
  depends_on "automake" => :build
  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "gdk-pixbuf"
  depends_on "glib"
  depends_on "gstreamer"
  depends_on "lz4"
  depends_on "pixman"
  depends_on "openssl@1.1"
  depends_on "opus"
  depends_on "python@3.11"
  depends_on "spice-protocol"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end


  test do
    system "false"
  end
end
