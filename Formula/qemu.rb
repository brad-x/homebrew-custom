class Qemu < Formula
  desc "Emulator for x86 and PowerPC"
  homepage "https://www.qemu.org/"
  url "https://download.qemu.org/qemu-8.2.1.tar.xz"
  sha256 "8562751158175f9d187c5f22b57555abe3c870f0325c8ced12c34c6d987729be"
  license "GPL-2.0-only"
  head "https://git.qemu.org/git/qemu.git", branch: "master"

  depends_on "libtool" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "spice-protocol" => :build
  

  depends_on "capstone"
  depends_on "glib"
  depends_on "gnutls"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libslirp"
  depends_on "libssh"
  depends_on "libusb"
  depends_on "usbredir"
  depends_on "lzo"
  depends_on "ncurses"
  depends_on "nettle"
  depends_on "pixman"
  depends_on "sdl2"
  depends_on "snappy"
  depends_on "vde"
  depends_on "zstd"
  depends_on "spice-server"

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  on_linux do
    depends_on "attr"
    depends_on "gtk+3"
    depends_on "libcap-ng"
  end

  fails_with gcc: "5"

  # 820KB floppy disk image file of FreeDOS 1.2, used to test QEMU
  resource "homebrew-test-image" do
    url "https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/official/FD12FLOPPY.zip"
    sha256 "81237c7b42dc0ffc8b32a2f5734e3480a3f9a470c50c14a9c4576a2561a35807"
  end
  
  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu/windows-hack.diff"
    sha256 "b65143e363291de1ac194c639c8fab1f50f8533b065b6bdf71a16d78f5e4c834"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu/virtio-ramfb.diff"
    sha256 "0ddeed33046845ffea600dbd7a0f7a8c6758eaf0c2d09e6449026b12d0f6b5d6"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu/8.2-vmnet-short-frames.diff"
    sha256 "c1fd73eaae9035088df4e7ea90e29f30ea7f7f252ef66ae33e4f72f09783ad8e"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu/8.2-cocoa-updates.diff"
    sha256 "eac29bd71d719b2582ee4e3a1c349892b547aeca7a15a78ce8eb7e2d3a9bcb9b"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu/8.2-cocoa-sonoma-title-fix.diff"
    sha256 "eca8567f3c617d2fd42a04441a9a63c3baad9bf65289909041869848dead2eff"
  end

  # patch do
  #   url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu/introduce-TPM-CRB-SysBus-device-v5.diff"
  #   sha256 "ee6cae6f36a5d6d4e886eedaa704e522ad83336ef42564a3d856ab77b0439e5d"
  # end

  # patch do
  #   url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu/fake-tpm-tis.diff"
  #   sha256 "76df4a09b118152be9698fc17c0f5b7a4d868a2a6518930431b6e09f254535c6"
  # end

  def install
    ENV["LIBTOOL"] = "glibtool"

    args = %W[
      --prefix=#{prefix}
      --cc=#{ENV.cc}
      --host-cc=#{ENV.cc}
      --disable-bsd-user
      --disable-guest-agent
      --enable-slirp
      --enable-capstone
      --enable-curses
      --enable-libssh
      --enable-spice
      --enable-vde
      --enable-virtfs
      --enable-zstd
      --enable-usb-redir
      --extra-cflags=-DNCURSES_WIDECHAR=1
    ]

    # Sharing Samba directories in QEMU requires the samba.org smbd which is
    # incompatible with the macOS-provided version. This will lead to
    # silent runtime failures, so we set it to a Homebrew path in order to
    # obtain sensible runtime errors. This will also be compatible with
    # Samba installations from external taps.
    args << "--smbd=#{HOMEBREW_PREFIX}/sbin/samba-dot-org-smbd"

    args += if OS.mac?
      ["--disable-gtk", "--enable-cocoa", "--enable-sdl"]
    else
      ["--enable-gtk"]
    end

    system "./configure", *args
    system "make", "V=1", "install"
  end

  test do
    expected = build.stable? ? version.to_s : "QEMU Project"
    assert_match expected, shell_output("#{bin}/qemu-system-aarch64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-alpha --version")
    assert_match expected, shell_output("#{bin}/qemu-system-arm --version")
    assert_match expected, shell_output("#{bin}/qemu-system-cris --version")
    assert_match expected, shell_output("#{bin}/qemu-system-hppa --version")
    assert_match expected, shell_output("#{bin}/qemu-system-i386 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-m68k --version")
    assert_match expected, shell_output("#{bin}/qemu-system-microblaze --version")
    assert_match expected, shell_output("#{bin}/qemu-system-microblazeel --version")
    assert_match expected, shell_output("#{bin}/qemu-system-mips --version")
    assert_match expected, shell_output("#{bin}/qemu-system-mips64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-mips64el --version")
    assert_match expected, shell_output("#{bin}/qemu-system-mipsel --version")
    assert_match expected, shell_output("#{bin}/qemu-system-nios2 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-or1k --version")
    assert_match expected, shell_output("#{bin}/qemu-system-ppc --version")
    assert_match expected, shell_output("#{bin}/qemu-system-ppc64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-riscv32 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-riscv64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-rx --version")
    assert_match expected, shell_output("#{bin}/qemu-system-s390x --version")
    assert_match expected, shell_output("#{bin}/qemu-system-sh4 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-sh4eb --version")
    assert_match expected, shell_output("#{bin}/qemu-system-sparc --version")
    assert_match expected, shell_output("#{bin}/qemu-system-sparc64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-tricore --version")
    assert_match expected, shell_output("#{bin}/qemu-system-x86_64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-xtensa --version")
    assert_match expected, shell_output("#{bin}/qemu-system-xtensaeb --version")
    resource("homebrew-test-image").stage testpath
    assert_match "file format: raw", shell_output("#{bin}/qemu-img info FLOPPY.img")
  end
end
