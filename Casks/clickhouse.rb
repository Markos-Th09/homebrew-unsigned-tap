cask "clickhouse" do
  arch arm: "-aarch64"

  version "26.8.2.7-lts"
  sha256 arm:   "68bcd026b17da3987fa9015e13fff999cc48ea63f25efe4072f74dbe2767a4be",
         intel: "c2e082d682d398c5615920395e40ef62cf6ea2377a000448405b10b1c09c6fa5"

  url "https://github.com/ClickHouse/ClickHouse/releases/download/v#{version}/clickhouse-macos#{arch}"
  name "Clickhouse"
  desc "Column-oriented database management system"
  homepage "https://clickhouse.com/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+[._-](lts|stable))$/i)
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on :macos

  binary "clickhouse-macos#{arch}", target: "clickhouse"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/clickhouse-macos#{arch}"
  end

  # No zap stanza required
end
