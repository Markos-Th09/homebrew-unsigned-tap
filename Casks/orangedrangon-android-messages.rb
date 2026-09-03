cask "orangedrangon-android-messages" do
  version "6.1.1"
  sha256 "1a6a423a45dcc440ba6a259d9fe8e4359a6b8ef96df92a0f7872c6523e369cc2"

  url "https://github.com/OrangeDrangon/android-messages-desktop/releases/download/v#{version}/Android-Messages-v#{version}-mac-universal.zip"
  name "Android Messages Desktop"
  desc "Desktop client for Android Messages"
  homepage "https://github.com/OrangeDrangon/android-messages-desktop"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on macos: :big_sur

  app "Android Messages.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/Android Messages.app"
  end

  zap trash: "~/Library/Application Support/android-messages-desktop"
end
