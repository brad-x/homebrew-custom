# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class SpiceServer < Formula
  desc "Remote virtual machine display server"
  homepage "https://www.spice-space.org/"
  url "https://www.spice-space.org/download/releases/spice-server/spice-0.14.3.tar.bz2"
  sha256 "551d4be4a07667cf0543f3c895beb6da8a93ef5a9829f2ae47817be5e616a114"
  license "BSD"

  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "glib"
  depends_on "pixman"
  depends_on "openssl@1.1"
  depends_on "opus"
  depends_on "spice-protocol"

  def install
    mkdir "build" do
      system "meson", *std_meson_args, "-Dwith-docs=false", ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/pthread-setname-args.diff"
    sha256 "ef6fb1e47bee0159e358ffb3410a758b8774229ba848594e4424de0e2b8db3d5"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-werror.diff"
    sha256 "e23c80eac47b2bce684fc3d50645bf727df5d7f712cbd4d69ae758f8fc3c94a6"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-tests.diff"
    sha256 "a2766fe736ab8630910330d6c23e3fea9890a76cd5c5cd35cdd9c67a14edf1f8"
  end

  test do
    system "false"
  end
end
