cask "corelocationcli" do
  version "4.0.7"
  sha256 "ac55d0abf7c9ca20dd8b933ce523d1d560004d9b3432963ba1730b573eba9c8c"

  url "https://github.com/fulldecent/corelocationcli/releases/download/#{version}/CoreLocationCLI.zip"
  name "Core Location CLI"
  desc "Prints location information from CoreLocation"
  homepage "https://github.com/fulldecent/corelocationcli"

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on macos: :big_sur

  app "CoreLocationCLI.app"
  binary "#{appdir}/CoreLocationCLI.app/Contents/MacOS/CoreLocationCLI"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/CoreLocationCLI.app"
  end

  # no zap stanza required
end
