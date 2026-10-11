cask "mergeiq" do
  version "0.2.3"
  sha256 "9d4ac47c2e25e27d711dc07ad16f79d7de4fc5a8f9cca2901522338f17d30b61"

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

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MergeIQ.app"]
  end

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
    MergeIQ is not signed or notarized yet. This cask clears macOS's quarantine attribute for you,
    so it opens normally after installing. If you downloaded the .dmg yourself instead, right-click
    the app and choose Open the first time.
  EOS
end
