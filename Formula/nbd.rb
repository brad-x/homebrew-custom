# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Nbd < Formula
  desc "Network Block Device"
  homepage "https://github.com/NetworkBlockDevice/nbd"
  url "https://github.com/NetworkBlockDevice/nbd/releases/download/nbd-3.25/nbd-3.25.tar.xz"
  sha256 "f5c8fd0fcb57b1c926594d0e57f356432ee08678bef1d40d088f0830f0cbdd0a"
  license "GPL-2"

  depends_on "pkg-config" => :build

  depends_on "glib"
  depends_on "gnutls"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    system "./configure", *std_configure_args, "--disable-silent-rules"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "make", "V=1", "install"
  end

end
