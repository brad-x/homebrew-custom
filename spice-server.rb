# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class SpiceServer < Formula
  desc ""
  homepage ""
  url "https://www.spice-space.org/download/releases/spice-server/spice-0.14.3.tar.bz2"
  sha256 "551d4be4a07667cf0543f3c895beb6da8a93ef5a9829f2ae47817be5e616a114"
  license ""


  def install
    system "./configure", "--prefix=#{prefix}"
    system "autoreconf"
    system "make", "install"
  end

  test do
    system "false"
  end
end
