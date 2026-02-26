cask "vmctl" do
  version "0.1.0"
  sha256 "366e3d1315de97bd99ad68e3134fb7d246400b408af8d93b4a382512605bd579"

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