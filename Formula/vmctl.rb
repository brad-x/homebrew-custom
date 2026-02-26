class Vmctl < Formula
  desc "Lightweight macOS virtual machine manager using vfkit and vmnet-helper"
  homepage "https://git.brad-x.com/brad/vmctl"
  url "https://git.brad-x.com/brad/vmctl.git", tag: "v0.1.0"
  # For development/local testing, comment out the above and use:
  # url "file:///Users/brad/Workspace/brad-x/vmctl", using: :git, branch: "main"
  license "MIT"

  depends_on :macos
  depends_on :xcode => ["15.0", :build]
  depends_on "vfkit"
  depends_on "vmnet-helper"

  def install
    # Build vmctl-cli (universal binary)
    cd "vmctl-cli" do
      system "swift", "build",
        "-c", "release",
        "--arch", "x86_64",
        "--arch", "arm64",
        "--disable-sandbox"
      bin.install ".build/apple/Products/Release/vmctl-cli" => "vmctl"
    end

    # Build vmctl.app
    xcodebuild_args = %w[
      -project vmctl.xcodeproj
      -scheme vmctl
      -configuration Release
      clean build
      CODE_SIGN_IDENTITY=-
      SYMROOT=build
    ]
    system "xcodebuild", *xcodebuild_args
    prefix.install "build/Release/vmctl.app"
  end

  def post_install
    # Symlink .app into /Applications
    app = prefix/"vmctl.app"
    target = Pathname("/Applications/vmctl.app")
    if app.exist? && !target.exist?
      target.make_symlink(app)
    end
  end

  def caveats
    <<~EOS
      vmctl.app has been symlinked to /Applications.

      The CLI is available as `vmctl` in your PATH.

      Both vfkit and vmnet-helper must be installed:
        brew install vfkit vmnet-helper
    EOS
  end

  test do
    assert_match "vmctl", shell_output("#{bin}/vmctl --help", 0)
  end
end