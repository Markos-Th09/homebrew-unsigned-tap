cask "forkgram-telegram" do
  arch arm: "arm64", intel: "x86"

  version "7.1.5"
  sha256 arm:   "404c464cb1262fe8fbb939f27a90b7c92c185c46a67dd9267e3b1a50ea3a1d48",
         intel: "16f61589f3c8a36186451ae1423d939b1dc53db7829b3386f694f1e84bd3a03c"

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
