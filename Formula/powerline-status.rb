class PowerlineStatus < Formula
    include Language::Python::Virtualenv
  
    desc "A status line plugin for vim, bash, and other tools"
    homepage "https://powerline.readthedocs.io/en/latest/"
    url "https://files.pythonhosted.org/packages/9c/30/8bd3c62642778af9ad813a526c6ff7dd2f98144d6580ad6fab94ca389265/powerline-status-2.7.tar.gz"
    sha256 "8c7e7da45beb2332bc8226b166b732ef70db2cb0a1f3f0fdc3c539115522ecb6"
    license "MIT"
  
    depends_on "python@3.12"
  
    def install
      virtualenv_install_with_resources
    end
  
    test do
      system "#{bin}/powerline", "--help"
    end
  end
  