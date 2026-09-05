cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-09-03"
  sha256 arm:   "258b134c284f51764172064bda74014d23f539b5f7cde8fd3870ae4f88b601a5",
         intel: "69f907b79d694bd432ddcfc38824c80885769a371724936453c32f89143a5c15"

  url "https://github.com/servo/servo-nightly-builds/releases/download/#{version}/servo-#{arch}-apple-darwin.dmg"
  name "Servo"
  desc "Parallel browser engine"
  homepage "https://servo.org/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:[.-]\d+)+)$/i)
    strategy :github_latest
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on macos: :ventura

  app "Servo.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/Servo.app"
  end

  zap trash: "~/Library/Application Support/Servo"
end
