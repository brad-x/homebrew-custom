class Qemu < Formula
  desc "Generic machine emulator and virtualizer"
  homepage "https://www.qemu.org/"
  url "https://download.qemu.org/qemu-9.0.1.tar.xz"
  sha256 "d0f4db0fbd151c0cf16f84aeb2a500f6e95009732546f44dafab8d2049bbb805"
  license "GPL-2.0-only"
  head "https://gitlab.com/qemu-project/qemu.git", branch: "master"

  livecheck do
    url "https://www.qemu.org/download/"
    regex(/href=.*?qemu[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  depends_on "libtool" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "spice-protocol" => :build

  depends_on "capstone"
  depends_on "dtc"
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
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu/8.2-vmnet-short-frames.diff"
    sha256 "c1fd73eaae9035088df4e7ea90e29f30ea7f7f252ef66ae33e4f72f09783ad8e"
  end

  # patch do
  #   url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu/tpm-crb-aarch64.diff"
  #   sha256 "ee6cae6f36a5d6d4e886eedaa704e522ad83336ef42564a3d856ab77b0439e5d"
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
      --enable-fdt=system
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
    archs = %w[
      aarch64 alpha arm cris hppa i386 m68k microblaze microblazeel mips
      mips64 mips64el mipsel nios2 or1k ppc ppc64 riscv32 riscv64 rx
      s390x sh4 sh4eb sparc sparc64 tricore x86_64 xtensa xtensaeb
    ]
    archs.each do |guest_arch|
      assert_match expected, shell_output("#{bin}/qemu-system-#{guest_arch} --version")
    end

    resource("homebrew-test-image").stage testpath
    assert_match "file format: raw", shell_output("#{bin}/qemu-img info FLOPPY.img")

    # On macOS, verify that we haven't clobbered the signature on the qemu-system-x86_64 binary
    if OS.mac?
      output = shell_output("codesign --verify --verbose #{bin}/qemu-system-x86_64 2>&1")
      assert_match "valid on disk", output
      assert_match "satisfies its Designated Requirement", output
    end
  end
end