# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Sshpass < Formula
  desc ""
  homepage ""
  url "https://sourceforge.net/projects/sshpass/files/sshpass/1.09/sshpass-1.09.tar.gz"
  sha256 "71746e5e057ffe9b00b44ac40453bf47091930cba96bbea8dc48717dedc49fb7"
  license ""

  # depends_on "cmake" => :build

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
