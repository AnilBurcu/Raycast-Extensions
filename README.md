# raycast-scripts

My Raycast script commands. Mostly stuff I got tired of doing manually.

## What's in here

- **brew-maintenance.sh** -- update + upgrade + cleanup homebrew in one go
- **dev-cache-clean.sh** -- nuke npm/watchman/metro/cocoapods/xcode/gradle caches
- **clear-copyboard.sh** -- wipe the clipboard
- **flush-dns.sh** -- flush DNS (restarts mDNSResponder)
- **nasa-picture.sh** -- NASA astronomy pic of the day
- **today-in-history.sh** -- what happened on this day (from Wikipedia)
- **todays-word.sh** -- random word + definition
- **random-article.sh** -- random Wikipedia page
- **timer.sh** -- simple minute timer with notification

## Setup

Clone it, then in Raycast go to Settings > Extensions > Script Commands > Add Script Directory and point it at this folder.

```bash
git clone https://github.com/AnilBurcu/raycast-scripts.git
```

Needs [Homebrew](https://brew.sh) for the brew script, obviously.

## Author

Perikles ([@AnilBurcu](https://github.com/AnilBurcu))

MIT license.
