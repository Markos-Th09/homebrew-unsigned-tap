cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-09-01"
  sha256 arm:   "7b396333a3914c98f3a23abd8dae618f5f5cd61809412bc5cd548395594fca65",
         intel: "9e09d2c9dc748da69d53351b0061651fdfbaa430bd40cecb86c39c833af2b5c5"

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
