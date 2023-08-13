# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class SpiceServer < Formula
  include Language::Python::Virtualenv

  desc "Remote virtual machine display server"
  homepage "https://www.spice-space.org/"
  url "https://www.spice-space.org/download/releases/spice-server/spice-0.15.2.tar.bz2"
  sha256 "6d9eb6117f03917471c4bc10004abecff48a79fb85eb85a1c45f023377015b81"
  license "BSD"

  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "gdk-pixbuf"
  depends_on "glib"
  depends_on "gstreamer"
  # depends_on "gst-plugins-base"
  depends_on "lz4"
  depends_on "pixman"
  depends_on "openssl@1.1"
  depends_on "opus"
  depends_on "python@3.11"
  depends_on "spice-protocol"

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/37/fe/65c989f70bd630b589adfbbcd6ed238af22319e90f059946c26b4835e44b/pyparsing-3.1.1.tar.gz"
    sha256 "ede28a1a32462f5a9705e07aea48001a08f7cf81a021585011deba701581a0db"
  end

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/dc/98/5f896af066c128669229ff1aa81553ac14cfb3e5e74b6b44594132b8540e/setuptools-68.0.0.tar.gz"
    sha256 "baf1fdb41c6da4cd2eae722e135500da913332ab3f2f5c7d33af9b492acb5235"
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
      system "meson", *std_meson_args, "-Dwith-docs=false", "-Dsasl=false", ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  # patch do
  #   url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/pthread-setname-args.diff"
  #   sha256 "ef6fb1e47bee0159e358ffb3410a758b8774229ba848594e4424de0e2b8db3d5"
  # end

  # patch do
  #   url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-werror.diff"
  #   sha256 "e23c80eac47b2bce684fc3d50645bf727df5d7f712cbd4d69ae758f8fc3c94a6"
  # end

  # patch do
  #   url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-tests.diff"
  #   sha256 "a2766fe736ab8630910330d6c23e3fea9890a76cd5c5cd35cdd9c67a14edf1f8"
  # end

  # patch do
  #   url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-tools.diff"
  #   sha256 "6b44d51804ae8831a69afea1e60aaa59a7ad44e45444905c21c79e961f006382"
  # end

  # patch do
  #   url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/no-msg-nosignal.diff"
  #   sha256 "1ad43db73cdf9bf7d890e07311b4df6f9b95cb987dbea7b7e3526f3a8ccd6497"
  # end

  # patch do
  #   url "https://github.com/brad-x/homebrew-custom/raw/main/patches/spice-server/meson-build.diff"
  #   sha256 "6157cb95abb0ed5d9769b61e5c49b2d815b1780b769f0226def5ad4e9f8eab9e"
  # end

  test do
    system "false"
  end
end
