cask "operadriver" do
  version "151.0.7922.176"
  sha256 "c1669c0fafd14aa059211c7b243f8a4fb60daca3cf68d58540ec015e9b3dbb2e"

  url "https://github.com/operasoftware/operachromiumdriver/releases/download/v.#{version}/operadriver_mac64.zip"
  name "OperaChromiumDriver"
  desc "Driver for Chromium-based Opera releases"
  homepage "https://github.com/operasoftware/operachromiumdriver"

  livecheck do
    url :url
    regex(/^v?\.?(\d+(?:\.\d+)+)$/i)
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  binary "operadriver_mac64/operadriver"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/operadriver_mac64/operadriver"
  end

  # No zap stanza required

  caveats do
    requires_rosetta
  end
end
