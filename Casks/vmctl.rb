cask "vmctl" do
  version "0.1.0"
  sha256 "REPLACE_WITH_SHA256"

  url "https://git.brad-x.com/brad/vmctl/releases/download/v#{version}/vmctl-#{version}.zip"
  name "vmctl"
  desc "Lightweight macOS virtual machine manager using vfkit and vmnet-helper"
  homepage "https://git.brad-x.com/brad/vmctl"

  depends_on formula: "vfkit"
  depends_on formula: "vmnet-helper"

  app "vmctl.app"
  binary "vmctl.app/Contents/MacOS/vmctl-cli", target: "vmctl"

  postflight do
    system_command "/usr/bin/codesign",
      args: ["--force", "--deep", "--sign", "-", "#{appdir}/vmctl.app"],
      sudo: false
  end
  caveats <<~EOS
    Both vfkit and vmnet-helper must be installed:
      brew install vfkit vmnet-helper
  EOS
end