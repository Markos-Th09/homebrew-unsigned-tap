cask "archy" do
  version "2.42.2"
  sha256 "2811fa3ce5a3e48a5376872f702a20af95acc81713943b2c58217caef93dbee5"

  url "https://sdk-cdn.mypurecloud.com/archy/#{version}/archy-macos.zip"
  name "Archy"
  desc "YAML processor"
  homepage "https://developer.genesys.cloud/devapps/archy/"

  livecheck do
    url "https://sdk-cdn.mypurecloud.com/archy/versions.json"
    strategy :json do |json|
      json.map { |item| item["version"] }
    end
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  binary "archyBin/archy-macos-#{version}", target: "archy"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/archyBin/archy-macos-#{version}"
  end

  zap trash: "~/.archy_config"

  caveats do
    requires_rosetta
  end
end
