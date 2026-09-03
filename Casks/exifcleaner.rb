cask "exifcleaner" do
  version "4.2.1"
  sha256 "29f052d00c46c6fd2b26d76f8b9853f625d2ecd380c8a32c21c5f711489f7ba4"

  url "https://github.com/szTheory/exifcleaner/releases/download/v#{version}/ExifCleaner-#{version}.dmg"
  name "ExifCleaner"
  desc "Metadata cleaner"
  homepage "https://exifcleaner.com/"

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on :macos

  app "ExifCleaner.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/ExifCleaner.app"
  end

  zap trash: [
    "~/Library/Application Support/ExifCleaner",
    "~/Library/Saved Application State/com.exifcleaner.savedState",
  ]

  caveats do
    requires_rosetta
  end
end
