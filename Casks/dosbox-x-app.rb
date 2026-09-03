cask "dosbox-x-app" do
  arch arm: "arm64", intel: "x86_64"

  version "2026.08.31,2026.08.31"
  sha256 arm:   "09addce22e0846fbe8872b5a4c1be878de529ed2d0c336d7ebe2848814ed0d4e",
         intel: "c367e924179f8d804972eb41313d553ffb1cd9f7e8368113bce5890aa1b512b9"

  url "https://github.com/joncampbell123/dosbox-x/releases/download/dosbox-x-v#{version.csv.first}/dosbox-x-macosx-#{arch}-#{version.csv.second}.zip"
  name "DOSBox-X"
  desc "Fork of the DOSBox project"
  homepage "https://dosbox-x.com/"

  livecheck do
    url :url
    regex(%r{/dosbox-x-v?(\d+(?:\.\d+)+)/dosbox-x-macosx-#{arch}-([^/]+)\.zip$}i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["browser_download_url"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on :macos

  app "dosbox-x/dosbox-x.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/dosbox-x.app"
  end

  zap trash: [
    "~/Library/Preferences/com.dosbox-x.plist",
    "~/Library/Preferences/mapper-dosbox-x.map",
  ]
end
