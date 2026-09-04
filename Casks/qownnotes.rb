cask "qownnotes" do
  version "26.9.1"
  sha256 "2c476cd00c078c1b1762f94c694c64aff362c1359386ab36b119376c9ca3cf0e"

  url "https://github.com/pbek/QOwnNotes/releases/download/v#{version}/QOwnNotes.dmg"
  name "QOwnNotes"
  desc "Plain-text file notepad and todo-list manager"
  homepage "https://www.qownnotes.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  auto_updates true
  depends_on macos: :monterey

  app "QOwnNotes.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/QOwnNotes.app"
  end

  zap trash: [
    "~/Library/Preferences/com.pbe.QOwnNotes.plist",
    "~/Library/Saved Application State/com.PBE.QOwnNotes.savedState",
  ]
end
