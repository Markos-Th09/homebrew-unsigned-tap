cask "qtpass" do
  version "1.7.0"
  sha256 "4aa8e1ac84c8d6434fcacc68df3549a569e2b969c7b19c1f645038aefcb9c852"

  url "https://github.com/IJHack/qtpass/releases/download/v#{version}/qtpass-#{version}.dmg"
  name "QtPass"
  desc "Multi-platform GUI for pass, the standard unix password manager"
  homepage "https://qtpass.org/"

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on :macos

  app "QtPass.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/QtPass.app"
  end

  zap trash: [
    "~/Library/Preferences/org.ijhack.QtPass.plist",
    "~/Library/Saved Application State/org.qtpass.savedState",
  ]

  caveats do
    requires_rosetta
  end
end
