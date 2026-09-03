cask "deepstream" do
  version "10.2.1"
  sha256 "ba352f1df8002a76d7beb2298fffb30968858e422562eded36205331243d7dc9"

  url "https://github.com/deepstreamIO/deepstream.io/releases/download/v#{version}/deepstream.io-mac-#{version}.pkg"
  name "deepstream"
  desc "Data-sync realtime server"
  homepage "https://deepstream.io/"

  depends_on :macos

  pkg "deepstream.io-mac-#{version}.pkg"

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/deepstream.io-mac-#{version}.pkg"
  end

  uninstall pkgutil: "deepstream.io"

  # No zap stanza required

  caveats do
    files_in_usr_local
  end
end
