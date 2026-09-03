cask "stremioservice" do
  version "0.1.22"
  sha256 "0b2aaf882823d16132bf1d49900d377d22f57741768ffdaa2958a8b6cef9c4f8"

  url "https://github.com/Stremio/stremio-service/releases/download/v#{version}/StremioService.dmg"
  name "Stremio Service"
  desc "Companion app for Stremio Web"
  homepage "https://web.strem.io/"

  livecheck do
    url "https://www.stremio.com/updater/check?product=stremio-service"
    strategy :json do |json|
      json["version"]
    end
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on macos: :big_sur
  depends_on arch: :arm64

  app "StremioService.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/StremioService.app"
  end

  uninstall launchctl: "com.stremio.service"

  zap trash: [
    "~/Library/Application Support/stremio-server",
    "~/Library/LaunchAgents/com.stremio.service.plist",
  ]
end
