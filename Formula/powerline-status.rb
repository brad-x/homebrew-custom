class PowerlineStatus < Formula
    include Language::Python::Virtualenv
  
    desc "A status line plugin for vim, bash, and other tools"
    homepage "https://powerline.readthedocs.io/en/latest/"
    url "https://files.pythonhosted.org/packages/9c/30/8bd3c62642778af9ad813a526c6ff7dd2f98144d6580ad6fab94ca389265/powerline-status-2.7.tar.gz"
    sha256 "8c7e7da45beb2332bc8226b166b732ef70db2cb0a1f3f0fdc3c539115522ecb6"
    license "MIT"
  
    depends_on "python@3.13"
  
    resource "cachetools" do
      url "https://files.pythonhosted.org/packages/c3/38/a0f315319737ecf45b4319a8cd1f3a908e29d9277b46942263292115eee7/cachetools-5.5.0.tar.gz"
      sha256 "2cc24fb4cbe39633fb7badd9db9ca6295d766d9c2995f245725a46715d050f2a"
    end
  
    resource "certifi" do
      url "https://files.pythonhosted.org/packages/b0/ee/9b19140fe824b367c04c5e1b369942dd754c4c5462d5674002f75c4dedc1/certifi-2024.8.30.tar.gz"
      sha256 "bec941d2aa8195e248a60b31ff9f0558284cf01a52591ceda73ea9afffd69fd9"
    end
  
    resource "charset-normalizer" do
      url "https://files.pythonhosted.org/packages/f2/4f/e1808dc01273379acc506d18f1504eb2d299bd4131743b9fc54d7be4df1e/charset_normalizer-3.4.0.tar.gz"
      sha256 "223217c3d4f82c3ac5e29032b3f1c2eb0fb591b72161f86d93f5719079dae93e"
    end
  
    resource "durationpy" do
      url "https://files.pythonhosted.org/packages/31/e9/f49c4e7fccb77fa5c43c2480e09a857a78b41e7331a75e128ed5df45c56b/durationpy-0.9.tar.gz"
      sha256 "fd3feb0a69a0057d582ef643c355c40d2fa1c942191f914d12203b1a01ac722a"
    end
  
    resource "google-auth" do
      url "https://files.pythonhosted.org/packages/a1/37/c854a8b1b1020cf042db3d67577c6f84cd1e8ff6515e4f5498ae9e444ea5/google_auth-2.35.0.tar.gz"
      sha256 "f4c64ed4e01e8e8b646ef34c018f8bf3338df0c8e37d8b3bba40e7f574a3278a"
    end
  
    resource "idna" do
      url "https://files.pythonhosted.org/packages/f1/70/7703c29685631f5a7590aa73f1f1d3fa9a380e654b86af429e0934a32f7d/idna-3.10.tar.gz"
      sha256 "12f65c9b470abda6dc35cf8e63cc574b1c52b11df2c86030af0ac09b01b13ea9"
    end
  
    resource "kubernetes" do
      url "https://files.pythonhosted.org/packages/7e/bd/ffcd3104155b467347cd9b3a64eb24182e459579845196b3a200569c8912/kubernetes-31.0.0.tar.gz"
      sha256 "28945de906c8c259c1ebe62703b56a03b714049372196f854105afe4e6d014c0"
    end
  
    resource "oauthlib" do
      url "https://files.pythonhosted.org/packages/6d/fa/fbf4001037904031639e6bfbfc02badfc7e12f137a8afa254df6c4c8a670/oauthlib-3.2.2.tar.gz"
      sha256 "9859c40929662bec5d64f34d01c99e093149682a3f38915dc0655d5a633dd918"
    end
  
    resource "powerline-kubernetes" do
      url "https://files.pythonhosted.org/packages/34/1f/4cfd85c8e96b1a0fb67e1c29fc90dde476be7b35b248b20a4d7b4791f6e2/powerline-kubernetes-1.2.0.tar.gz"
      sha256 "f635f648b3e0249fe7491996c5a681ead8868b9bfa0254dde8811fe2919a9711"
    end
  
    resource "powerline-status" do
      url "https://files.pythonhosted.org/packages/9c/30/8bd3c62642778af9ad813a526c6ff7dd2f98144d6580ad6fab94ca389265/powerline-status-2.7.tar.gz"
      sha256 "8c7e7da45beb2332bc8226b166b732ef70db2cb0a1f3f0fdc3c539115522ecb6"
    end
  
    resource "pyasn1" do
      url "https://files.pythonhosted.org/packages/ba/e9/01f1a64245b89f039897cb0130016d79f77d52669aae6ee7b159a6c4c018/pyasn1-0.6.1.tar.gz"
      sha256 "6f580d2bdd84365380830acf45550f2511469f673cb4a5ae3857a3170128b034"
    end
  
    resource "pyasn1-modules" do
      url "https://files.pythonhosted.org/packages/1d/67/6afbf0d507f73c32d21084a79946bfcfca5fbc62a72057e9c23797a737c9/pyasn1_modules-0.4.1.tar.gz"
      sha256 "c28e2dbf9c06ad61c71a075c7e0f9fd0f1b0bb2d2ad4377f240d33ac2ab60a7c"
    end
  
    resource "python-dateutil" do
      url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
      sha256 "37dd54208da7e1cd875388217d5e00ebd4179249f90fb72437e91a35459a0ad3"
    end
  
    resource "PyYAML" do
      url "https://files.pythonhosted.org/packages/54/ed/79a089b6be93607fa5cdaedf301d7dfb23af5f25c398d5ead2525b063e17/pyyaml-6.0.2.tar.gz"
      sha256 "d584d9ec91ad65861cc08d42e834324ef890a082e591037abe114850ff7bbc3e"
    end
  
    resource "requests" do
      url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896afe06353c2a2913/requests-2.32.3.tar.gz"
      sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
    end
  
    resource "requests-oauthlib" do
      url "https://files.pythonhosted.org/packages/42/f2/05f29bc3913aea15eb670be136045bf5c5bbf4b99ecb839da9b422bb2c85/requests-oauthlib-2.0.0.tar.gz"
      sha256 "b3dffaebd884d8cd778494369603a9e7b58d29111bf6b41bdc2dcd87203af4e9"
    end
  
    resource "rsa" do
      url "https://files.pythonhosted.org/packages/aa/65/7d973b89c4d2351d7fb232c2e452547ddfa243e93131e7cfa766da627b52/rsa-4.9.tar.gz"
      sha256 "e38464a49c6c85d7f1351b0126661487a7e0a14a50f1675ec50eb34d4f20ef21"
    end
  
    resource "six" do
      url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
      sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
    end
  
    resource "urllib3" do
      url "https://files.pythonhosted.org/packages/ed/63/22ba4ebfe7430b76388e7cd448d5478814d3032121827c12a2cc287e2260/urllib3-2.2.3.tar.gz"
      sha256 "e7d814a81dad81e6caf2ec9fdedb284ecc9c73076b62654547cc64ccdcae26e9"
    end
  
    resource "websocket-client" do
      url "https://files.pythonhosted.org/packages/e6/30/fba0d96b4b5fbf5948ed3f4681f7da2f9f64512e1d303f94b4cc174c24a5/websocket_client-1.8.0.tar.gz"
      sha256 "3239df9f44da632f96012472805d40a23281a991027ce11d2f45a6f24ac4c3da"
    end

    def install
      # virtualenv_install_with_resources
      venv = virtualenv_install_with_resources without: "powerline-status"
      venv.pip_install_and_link resource("powerline-status")
    end

    def post_install
      # Define the file path
      segments_file = "#{prefix}/libexec/lib/python3.13/site-packages/powerline_kubernetes/segments.py"
  
      # Use inreplace to remove the specific line
      inreplace segments_file, /^\s*namespace = ctx\['namespace'\].*$/, ""
    end

    test do
      system "#{bin}/powerline", "--help"
    end
  end
  