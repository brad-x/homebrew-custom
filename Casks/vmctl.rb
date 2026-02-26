cask "vmctl" do
  version "0.1.1"
  sha256 "8a25bac6b7ad720fdab95446484cfca98ff3d1cf88cf8d1573bff2d10f908d5f"

  url "https://git.brad-x.com/brad/vmctl/releases/download/v#{version}/vmctl-#{version}.zip"
  name "vmctl"
  desc "Lightweight macOS virtual machine manager using vfkit and vmnet-helper"
  homepage "https://git.brad-x.com/brad/vmctl"

  depends_on formula: "vfkit"
  depends_on formula: "vmnet-helper"

  app "vmctl.app"
  binary "vmctl.app/Contents/MacOS/vmctl-cli", target: "vmctl"

  postflight do
    system_command "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "#{appdir}/vmctl.app"]
    system_command "/usr/bin/codesign",
        args: ["--force", "--sign", "-", "#{appdir}/vmctl.app/Contents/MacOS/vmctl-cli"]
    system_command "/usr/bin/codesign",
        args: ["--force", "--sign", "-", "#{appdir}/vmctl.app"]
  end
  caveats <<~EOS
    Both vfkit and vmnet-helper must be installed:
      brew install vfkit vmnet-helper
  EOS
end