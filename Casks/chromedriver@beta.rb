cask "chromedriver@beta" do
  arch arm: "arm64", intel: "x64"

  version "154.0.8037.0"
  sha256 arm:   "885a6ecce079bf9266bb2566a2b7c3fe367855c80c5965ae386dd88e4e37ff29",
         intel: "a5f0bb2eaed09d51ab92dfdad52618a6b1ab2e8a72d0d6113e8ec3d6ae4e287f"

  url "https://storage.googleapis.com/chrome-for-testing-public/#{version}/mac-#{arch}/chromedriver-mac-#{arch}.zip"
  name "ChromeDriver"
  desc "Automated testing of webapps for Google Chrome"
  homepage "https://chromedriver.chromium.org/"

  livecheck do
    url "https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions.json"
    strategy :json do |json|
      json.dig("channels", "Beta", "version")
    end
  end

  conflicts_with cask: "chromedriver"
  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on :macos

  binary "chromedriver-mac-#{arch}/chromedriver"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/chromedriver-mac-#{arch}/chromedriver"
  end

  # No zap stanza required
end
