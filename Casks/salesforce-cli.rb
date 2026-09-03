cask "salesforce-cli" do
  arch arm: "arm64", intel: "x64"

  version "2.150.6,c049970"
  sha256 arm:   "d3c99f86f31039797565cd080e3be9336c8d4633ca4a67325c823e632db940f1",
         intel: "2f02dfa498c71917f1ef677b7e168be9deea8eca18fdb93e5b7ffff1f704b0fd"

  url "https://github.com/salesforcecli/cli/releases/download/#{version.csv.first}/sf-v#{version.csv.first}-#{version.csv.second}-#{arch}.pkg"
  name "Salesforce CLI"
  desc "CLI tools for Salesforce"
  homepage "https://developer.salesforce.com/tools/salesforcecli"

  livecheck do
    url "https://developer.salesforce.com/media/salesforce-cli/sf/channels/stable/sf-darwin-#{arch}-buildmanifest"
    strategy :json do |json|
      next if json["version"].blank? || json["sha"].blank?

      "#{json["version"]},#{json["sha"]}"
    end
  end

  depends_on :macos

  pkg "sf-v#{version.csv.first}-#{version.csv.second}-#{arch}.pkg"

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/sf-v#{version.csv.first}-#{version.csv.second}-#{arch}.pkg"
  end

  uninstall pkgutil: "com.salesforce.cli",
            delete:  [
              "/usr/local/bin/sf",
              "/usr/local/bin/sfdx",
            ]

  zap trash: [
    "~/.cache/sf",
    "~/.config/sf",
    "~/.local/share/sf",
    "~/.sf",
  ]
end
