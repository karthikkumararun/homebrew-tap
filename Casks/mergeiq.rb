cask "mergeiq" do
  version "0.2.0"
  sha256 "738e3070e8482aafaef05463b20686c738dc391116502d1a790b5d9883366d2d"

  url "https://github.com/karthikkumararun/mergeIQ/releases/download/v#{version}/MergeIQ_#{version}_universal.dmg"
  name "MergeIQ"
  desc "Merge conflict resolver with a three-pane editor"
  homepage "https://github.com/karthikkumararun/mergeIQ"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "MergeIQ.app"
  binary "#{appdir}/MergeIQ.app/Contents/MacOS/mergeiq"

  zap trash: [
    "~/Library/Application Support/dev.mergeiq.app",
    "~/Library/Application Support/MergeIQ",
    "~/Library/Caches/dev.mergeiq.app",
    "~/Library/Logs/MergeIQ",
    "~/Library/Preferences/dev.mergeiq.app.plist",
    "~/Library/Saved Application State/dev.mergeiq.app.savedState",
    "~/Library/WebKit/dev.mergeiq.app",
  ]

  caveats <<~EOS
    MergeIQ is not signed or notarized yet, so macOS Gatekeeper may refuse to open it.
    After installing, clear the quarantine attribute once:

      xattr -dr com.apple.quarantine "#{appdir}/MergeIQ.app"

    Or right-click the app in Applications and choose Open.
  EOS
end
