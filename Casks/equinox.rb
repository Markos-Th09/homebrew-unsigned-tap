cask "equinox" do
  version "6.0"
  sha256 "1271dfb05af237d5f31d18c67b8755c3d57a8683257ea2eef5bddcd9bbd24261"

  url "https://github.com/rlxone/Equinox/releases/download/v#{version}/Equinox-Installer.dmg"
  name "Equinox"
  desc "Create dynamic wallpapers"
  homepage "https://equinoxmac.com/"

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on :macos

  app "Equinox.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/Equinox.app"
  end

  zap trash: [
    "~/Library/Application Scripts/com.rlxone.equinox",
    "~/Library/Containers/com.rlxone.equinox",
  ]
end
