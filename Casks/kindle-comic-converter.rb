cask "kindle-comic-converter" do
  arch arm: "arm", intel: "i386"

  version "11.1.0"
  sha256 arm:   "c00586026f0d8d28c5e44569365917ba3ebfc85f7ce72d0d0902a1099fdadf17",
         intel: "3d7f40c73f851c5ecafcda00aeb6b895621f31c238002e8121bc040b69c79fc8"

  on_arm do
    depends_on macos: :big_sur
  end
  on_intel do
    depends_on macos: :catalina
  end

  url "https://github.com/ciromattia/kcc/releases/download/v#{version}/kcc_macos_#{arch}_#{version}.dmg"
  name "Kindle Comic Converter"
  name "KCC"
  desc "Comic and manga converter for ebook readers"
  homepage "https://github.com/ciromattia/kcc"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  app "Kindle Comic Converter.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/Kindle Comic Converter.app"
  end

  zap trash: "~/Library/Preferences/com.kindlecomicconverter.KindleComicConverter.plist"
end
