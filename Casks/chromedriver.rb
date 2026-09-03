cask "chromedriver" do
  arch arm: "arm64", intel: "x64"

  version "152.0.7977.82"
  sha256 arm:   "f5d378ce382494416bb3243491ef30a5d22b12cfd2ab7cb5fdf6c448bff8abbb",
         intel: "d3bacdcffee9e71e178b11d6a33162aa5d072d3d00bacd2bd4235dd46c3611c7"

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
