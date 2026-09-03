cask "chromedriver" do
  arch arm: "arm64", intel: "x64"

  version "152.0.7977.75"
  sha256 arm:   "07be29b25e28ad37fbe0d633faf4feace941d244689b99a317ea0e9f3cb8ab74",
         intel: "936beace85668c822d9fe95ad30eae2048e8504bb09c728bde509f991bd76815"

  url "https://storage.googleapis.com/chrome-for-testing-public/#{version}/mac-#{arch}/chromedriver-mac-#{arch}.zip"
  name "ChromeDriver"
  desc "Automated testing of webapps for Google Chrome"
  homepage "https://chromedriver.chromium.org/"

  livecheck do
    url "https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions.json"
    strategy :json do |json|
      json.dig("channels", "Stable", "version")
    end
  end

  conflicts_with cask: "chromedriver@beta"
  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on :macos

  binary "chromedriver-mac-#{arch}/chromedriver"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/chromedriver-mac-#{arch}/chromedriver"
  end

  # No zap stanza required
end
