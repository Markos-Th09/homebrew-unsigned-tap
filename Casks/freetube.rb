cask "freetube" do
  arch arm: "arm64", intel: "x64"

  on_catalina do
    version "0.22.1"
    sha256 "0e9eb9db841f36671c81fedff4580c39dbbd6bd541d5158ed4897218c4134946"

    url "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-mac-x64.dmg"

    livecheck do
      skip "Legacy version"
    end
  end
  on_big_sur :or_newer do
    version "0.25.3"
    sha256 arm:   "2b445d64f5e56a873debea50c785cd41400bdabc387f0d67fc7be745b2b9146e",
           intel: "40fb6c671ec75905e035968ec0c14bfe717643730af80536e625d191455f49bf"

    url "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-beta-mac-#{arch}.dmg"

    livecheck do
      url :url
      regex(/^v?(\d+(?:\.\d+)+)/i)
    end
  end

  name "FreeTube"
  desc "YouTube player focusing on privacy"
  homepage "https://freetubeapp.io/"

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on :macos

  app "FreeTube.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/FreeTube.app"
  end

  uninstall quit: "io.freetubeapp.freetube"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/io.freetubeapp.freetube.sfl*",
    "~/Library/Application Support/FreeTube",
    "~/Library/Preferences/io.freetubeapp.freetube.plist",
    "~/Library/Saved Application State/io.freetubeapp.freetube.savedState",
  ]
end
