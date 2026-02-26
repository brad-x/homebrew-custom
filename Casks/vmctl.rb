cask "vmctl" do
  version "0.1.0"
  sha256 "be5f9bddbfdcfb5bd465def8660e2d209501cc21a885687c03fca9b4d4334f08"

  url "https://git.brad-x.com/brad/vmctl/releases/download/v#{version}/vmctl-#{version}.zip"
  name "vmctl"
  desc "Lightweight macOS virtual machine manager using vfkit and vmnet-helper"
  homepage "https://git.brad-x.com/brad/vmctl"

  depends_on formula: "vfkit"
  depends_on formula: "vmnet-helper"

  app "vmctl.app"
  binary "vmctl.app/Contents/MacOS/vmctl-cli", target: "vmctl"
  caveats <<~EOS
    Both vfkit and vmnet-helper must be installed:
      brew install vfkit vmnet-helper
  EOS
end