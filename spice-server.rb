# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class SpiceServer < Formula
  include Language::Python::Virtualenv

  desc "Remote virtual machine display server"
  homepage "https://www.spice-space.org/"
  url "https://www.spice-space.org/download/releases/spice-server/spice-0.14.3.tar.bz2"
  sha256 "551d4be4a07667cf0543f3c895beb6da8a93ef5a9829f2ae47817be5e616a114"
  license "BSD"

  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "gdk-pixbuf"
  depends_on "glib"
  depends_on "gstreamer"
  depends_on "gst-plugins-base"
  depends_on "pixman"
  depends_on "openssl@1.1"
  depends_on "opus"
  depends_on "python@3.9"
  depends_on "spice-protocol"

  resource "six" do
    url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
    sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/c1/47/dfc9c342c9842bbe0036c7f763d2d6686bcf5eb1808ba3e170afdb282210/pyparsing-2.4.7.tar.gz"
    sha256 "c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1"
  end

  def install
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{xy}/site-packages"
    resources.each do |r|
      r.stage do
        system "python3", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end
  
    mkdir "build" do
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{xy}/site-packages"
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

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-tools.diff"
    sha256 "6b44d51804ae8831a69afea1e60aaa59a7ad44e45444905c21c79e961f006382"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-msg-nosignal.diff"
    sha256 "1ad43db73cdf9bf7d890e07311b4df6f9b95cb987dbea7b7e3526f3a8ccd6497"
  end

  patch do
    url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/meson-build.diff"
    sha256 "6157cb95abb0ed5d9769b61e5c49b2d815b1780b769f0226def5ad4e9f8eab9e"
  end

  test do
    system "false"
  end
end
