cask "qbittorrent@lt20" do
  version "5.2.3"
  sha256 "4dde4f357cf8d7271f7e25140d2986d076126566edf2d2ad441cdd382b2a333d"

  url "https://downloads.sourceforge.net/qbittorrent/qbittorrent-mac/qbittorrent-#{version}/qbittorrent-#{version}_lt20.dmg"
  name "qBittorrent"
  desc "Edition of qBitorrent based on libtorrent-rasterbar 2.0.x"
  homepage "https://www.qbittorrent.org/"

  livecheck do
    url "https://sourceforge.net/projects/qbittorrent/rss?path=/qbittorrent-mac"
    regex(%r{url=.*?/qbittorrent[._-]v?(\d+(?:\.\d+)+)[._-]lt20\.dmg}i)
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  conflicts_with cask: "qbittorrent"
  depends_on macos: :big_sur

  # Renamed for consistency: app name is different in the Finder and in a shell.

  app "qbittorrent.app", target: "qBittorrent.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/qbittorrent.app"
  end

  zap trash: [
    "~/.config/qBittorrent",
    "~/Library/Application Support/qBittorrent",
    "~/Library/Caches/qBittorrent",
    "~/Library/Preferences/org.qbittorrent.qBittorrent.plist",
    "~/Library/Preferences/qBittorrent",
    "~/Library/Saved Application State/org.qbittorrent.qBittorrent.savedState",
  ]
end
