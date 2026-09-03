cask "qbittorrent" do
  on_catalina :or_older do
    version "4.6.7"
    sha256 "0b1051af73562fc3f7c0c71abd27c3433ad238fbca0c4612f554db35be3eba6e"

    livecheck do
      skip "Legacy version"
    end
  end
  on_big_sur :or_newer do
    version "5.2.3"
    sha256 "9e37f6c7ff848c7bdd3c10167614c0cb78c00e2ddcc323f1ad3ac6c008a0481f"

    livecheck do
      url "https://sourceforge.net/projects/qbittorrent/rss?path=/qbittorrent-mac"
      regex(%r{url=.*?/qbittorrent[._-]v?(\d+(?:\.\d+)+)\.dmg}i)
    end
  end

  url "https://downloads.sourceforge.net/qbittorrent/qbittorrent-mac/qbittorrent-#{version}/qbittorrent-#{version}.dmg"
  name "qBittorrent"
  desc "Peer to peer Bitorrent client"
  homepage "https://www.qbittorrent.org/"

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  conflicts_with cask: "qbittorrent@lt20"
  # Renamed for consistency: app name is different in the Finder and in a shell.

  depends_on :macos

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
