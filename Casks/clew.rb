cask "clew" do
  version "0.1.0"
  sha256 "1e9e8372d0db018fb105ef4e3ded1fcbbbf0e353b538403791738fb65bdd7e48"

  url "https://github.com/karthikkumararun/clew/releases/download/v#{version}/Clew_#{version}_universal.dmg"
  name "Clew"
  desc "Open-source database IDE for SQL and NoSQL databases"
  homepage "https://github.com/karthikkumararun/clew"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Clew.app"
  binary "#{appdir}/Clew.app/Contents/MacOS/clew"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Clew.app"]
  end

  zap trash: [
    "~/Library/Application Support/Clew",
    "~/Library/Application Support/dev.adk.clew",
    "~/Library/Caches/dev.adk.clew",
    "~/Library/HTTPStorages/dev.adk.clew",
    "~/Library/Logs/Clew",
    "~/Library/Preferences/dev.adk.clew.plist",
    "~/Library/Saved Application State/dev.adk.clew.savedState",
    "~/Library/WebKit/dev.adk.clew",
  ]

  caveats <<~EOS
    Clew is not signed or notarized yet. This cask clears macOS's quarantine attribute for you,
    so it opens normally after installing. If you downloaded the .dmg yourself instead, right-click
    the app and choose Open the first time, or run:
      xattr -dr com.apple.quarantine /Applications/Clew.app

    Saved connection passwords stay in the keychain (service "Clew") after uninstalling; remove
    them in Keychain Access. Your SQL scripts in ~/Documents/Clew are never removed.
  EOS
end
