cask "whichspace" do
  version "1.3.7"
  sha256 "8dba17c3bbea643d53bb18055b350c6c5971314369fed0d26041dc4d204b37e1"

  url "https://github.com/gechr/WhichSpace/releases/download/v#{version}/WhichSpace.zip"
  name "WhichSpace"
  desc "Active space menu bar icon"
  homepage "https://github.com/gechr/WhichSpace"

  livecheck do
    url "https://raw.githubusercontent.com/gechr/WhichSpace/updates/appcast.xml"
    strategy :sparkle
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  auto_updates true
  depends_on macos: :sonoma

  app "WhichSpace.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/WhichSpace.app"
  end

  uninstall quit: "io.gechr.WhichSpace"

  zap trash: [
    "~/Library/Caches/io.gechr.WhichSpace",
    "~/Library/Cookies/io.gechr.WhichSpace.binarycookies",
    "~/Library/Preferences/io.gechr.WhichSpace.plist",
    "~/Library/Saved Application State/io.gechr.WhichSpace.savedState",
  ]
end
