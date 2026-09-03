cask "koodo-reader" do
  arch arm: "arm64", intel: "x64"

  version "2.4.3"
  sha256 arm:   "75dc734f0c1106f04a6e7d091f8ed1ae7eaff56a2af19472214b32ca1cc7936d",
         intel: "8992ed229986ea9ce43f1b72be39ba6c6e9d5041dc496479208a313fb19a5a45"

  url "https://dl.koodoreader.com/v#{version}/Koodo-Reader-#{version}-#{arch}.dmg"
  name "Koodo Reader"
  desc "Open-source epub reader"
  homepage "https://www.koodoreader.com/en"

  livecheck do
    url "https://api.960960.xyz/api/update"
    strategy :json do |json|
      json.dig("log", "version")
    end
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on :macos

  app "Koodo Reader.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/Koodo Reader.app"
  end

  zap trash: [
    "~/Library/Application Support/koodo-reader",
    "~/Library/Preferences/xyz.960960.koodo.plist",
    "~/Library/Saved Application State/xyz.960960.koodo.savedState",
  ]
end
