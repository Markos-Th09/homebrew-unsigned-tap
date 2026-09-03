cask "syncplay" do
  version "1.7.6"
  sha256 "b027d9ba402953db9fe66f2d3770d16e500f1f6ac7e5a5a6e9552310fe9febb7"

  url "https://github.com/Syncplay/syncplay/releases/download/v#{version}/Syncplay_#{version}.dmg"
  name "Syncplay"
  desc "Synchronize video playback across multiple media players over the network"
  homepage "https://syncplay.pl/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Syncplay.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/Syncplay.app"
  end
end
