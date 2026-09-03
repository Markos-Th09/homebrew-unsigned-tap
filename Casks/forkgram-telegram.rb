cask "forkgram-telegram" do
  arch arm: "arm64", intel: "x86"

  version "7.1.4"
  sha256 arm:   "4acd1b5a2e9e0dca3ea6ac1e8f76873fe1b1987863bf713aa4ae67b56a3d39dc",
         intel: "719649ef9bea8b8f5b74e6d4a4263e6709e61abe0c051de706dfc3b22f4b2c74"

  url "https://github.com/Forkgram/tdesktop/releases/download/v#{version}/Forkgram.macOS.no.auto-update_#{arch}.zip"
  name "Forkgram"
  desc "Fork of Telegram Desktop"
  homepage "https://github.com/Forkgram/"

  # Not every GitHub release provides a file for macOS, so we check multiple
  # recent releases instead of only the "latest" release.
  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      file_regex = /^Forkgram[._-]macOS[._-].*?#{arch}\.zip$/i

      json.map do |release|
        next if release["draft"] || release["prerelease"]
        next unless release["assets"]&.any? { |asset| asset["name"]&.match?(file_regex) }

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  # Renamed to avoid conflict with telegram

  depends_on :macos

  app "Telegram.app", target: "Forkgram.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/Telegram.app"
  end

  zap trash: "~/Library/Application Support/Forkgram Desktop"
end
