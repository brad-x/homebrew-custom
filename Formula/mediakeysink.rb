class Mediakeysink < Formula
  desc "Stops headset and keyboard play buttons from launching Apple Music"
  homepage "https://github.com/brad-x/mediakeysink"
  url "https://github.com/brad-x/mediakeysink/releases/download/v1.0/mediakeysink-1.0.tar.gz"
  sha256 "29a5702af092f9768c060ab916d3c6275878c6b9e03fc67ef521231237fa5c29"

  depends_on :macos
  depends_on macos: :ventura

  def install
    app = buildpath/"MediaKeySink.app"
    (app/"Contents/MacOS").mkpath
    system "swiftc", "-O", "-o", app/"Contents/MacOS/MediaKeySink", "main.swift"
    cp "Info.plist", app/"Contents/Info.plist"
    system "codesign", "--force", "--sign", "-", app
    prefix.install app
  end

  def caveats
    <<~EOS
      MediaKeySink runs in the background with no Dock or menu bar icon.
      Start it once after each install or upgrade; it adds itself to Login Items:
        pkill -x MediaKeySink; open #{opt_prefix}/MediaKeySink.app
    EOS
  end

  test do
    system "codesign", "--verify", prefix/"MediaKeySink.app"
  end
end
