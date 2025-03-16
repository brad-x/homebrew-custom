class QemuUtmAT9 < Formula
  desc "Emulator for x86 and PowerPC with UTM patchset"
  homepage "https://www.qemu.org/"
  url "https://github.com/utmapp/qemu/releases/download/v9.1.2-utm/qemu-9.1.2-utm.tar.xz"
  sha256 "a9c10bea147abaa5781b1f25d0506c62dc5e0ab84b786066b236ef681703d628"
  license "GPL-2.0-only"
  head "https://github.com/utmapp/qemu.git", branch: "utm-edition"

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
  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  on_linux do
    depends_on "attr"
    depends_on "cairo"
    depends_on "elfutils"
    depends_on "gdk-pixbuf"
    depends_on "gtk+3"
    depends_on "libcap-ng"
    depends_on "libepoxy"
    depends_on "libx11"
    depends_on "libxkbcommon"
    depends_on "mesa"
    depends_on "systemd"
  end

  fails_with gcc: "5"

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/qemu-utm/qemu-9.1.2-utm.diff"
    sha256 "60451a63c517ee8f01bf68b962341748a171aba19f3a5f8459f3d21f21f7449f"
  end

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
      --enable-spice
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
    # 820KB floppy disk image file of FreeDOS 1.2, used to test QEMU
    resource "homebrew-test-image" do
      url "https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/official/FD12FLOPPY.zip"
      sha256 "81237c7b42dc0ffc8b32a2f5734e3480a3f9a470c50c14a9c4576a2561a35807"
    end

    archs = %w[
      aarch64 alpha arm avr cris hppa i386 loongarch64 m68k microblaze microblazeel mips
      mips64 mips64el mipsel or1k ppc ppc64 riscv32 riscv64 rx
      s390x sh4 sh4eb sparc sparc64 tricore x86_64 xtensa xtensaeb
    ]
    archs.each do |guest_arch|
      assert_match version.to_s, shell_output("#{bin}/qemu-system-#{guest_arch} --version")
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
