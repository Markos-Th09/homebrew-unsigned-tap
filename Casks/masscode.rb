cask "masscode" do
  arch arm: "-arm64"

  version "5.10.0"
  sha256 arm:   "533a0621491646c849268ff319907e4a6ef884a8b9c775413162fbf9b93f7d64",
         intel: "22f4feb38c1a59f1928f244dacc38efe1f4b9462b1b71243b226f9a6f54bb388"

  url "https://github.com/massCodeIO/massCode/releases/download/v#{version}/massCode-#{version}#{arch}.dmg"
  name "massCode"
  desc "Code snippets manager for developers"
  homepage "https://masscode.io/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  depends_on macos: :big_sur

  app "massCode.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/massCode.app"
  end

  zap trash: [
        "~/Library/Application Support/massCode",
        "~/Library/Preferences/io.masscode.app.plist",
        "~/Library/Saved Application State/io.masscode.app.savedState",
      ],
      rmdir: "~/massCode"
end
