# SoftwareRat/homebrew-unsigned-tap

A Homebrew tap for macOS applications that are unsigned or unnotarized — and therefore rejected by the official [Homebrew/homebrew-cask](https://github.com/Homebrew/homebrew-cask) repository.

## Why this tap exists

Apple requires developers to pay $99/year for a Developer ID certificate and submit every release to Apple's notarization service before macOS will run it without warnings. Homebrew Cask enforces this gate by refusing to host any cask that fails a Gatekeeper check — not because the software is broken or malicious, but purely because it lacks Apple's paid stamp of approval.

The result: perfectly functional, well-maintained open-source applications get quietly dropped from Homebrew the moment their maintainers miss a notarization step or choose not to pay Apple's annual fee. Users who relied on those casks lose them with no warning.

This tap says no to that. It hosts the rejected casks, automatically strips the quarantine attribute after installation so apps launch normally, and keeps definitions up to date. You own your Mac. You decide what runs on it.

> **Note:** "Unsigned" and "unnotarized" mean the developer has not paid Apple for a signing certificate or run the binary through Apple's notarization pipeline — not that the software is inherently untrustworthy. As with any software, use your own judgement: check the upstream project, read the cask definition in `Casks/`, and decide for yourself.

---

## Quickstart

```bash
# 1. Add this tap
brew tap SoftwareRat/unsigned-tap

# 2. Install a cask (example: Alacritty)
brew install --cask alacritty

# 3. Or install using the fully-qualified name
brew install --cask SoftwareRat/unsigned-tap/alacritty

# 4. Keep casks up to date
brew update && brew upgrade --cask
```

---

## Available Casks

This tap tracks the full upstream set of casks that were disabled because of
`fails_gatekeeper_check` and keeps them installable here.

Browse all current entries in `Casks/`.

```bash
# List all tokens in this tap
ls Casks | sed 's/\.rb$//'
```

### Popular Casks in this Tap

These are examples of widely known apps available here, to show why this tap
is practically useful:

- alacritty
- qbittorrent
- chromium
- chromedriver
- darktable
- flameshot
- freetube
- librewolf
- copyq
- lyx
- texstudio
- qownnotes
- qlmarkdown
- wine-stable
- gstreamer-runtime

---

## Removing a Cask

```bash
# Remove an installed cask
brew uninstall --cask alacritty

# Remove this tap entirely
brew untap SoftwareRat/unsigned-tap
```

---

## Contributing

If a cask you use was removed from Homebrew Cask due to a Gatekeeper rejection, feel free to open a pull request adding it here. Please include the upstream source URL, the reason for the Gatekeeper failure, and a working cask definition.
