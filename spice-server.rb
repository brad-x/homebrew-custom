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
    sha256 "7a0dd200792d03839ca68de4e44edce45d007b6b479fcf1dbc7625b3cdeae444"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-werror.diff"
    sha256 "5927d53e7037580a54f26c01d9727057485987b8e4555402cce79bbf0f0709da"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-tests.diff"
    sha256 "999c5415f1e07573b1fea95b053efb078bb44999af10a6476db13ea4eb7f4736"
  end

  test do
    system "false"
  end
end
