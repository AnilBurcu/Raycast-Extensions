# raycast-scripts

My Raycast script commands. Mostly stuff I got tired of doing manually.

## What's in here

- **brew-maintenance.sh** -- update + upgrade + cleanup homebrew in one go
- **dev-cache-clean.sh** -- nuke npm/watchman/metro/cocoapods/xcode/gradle caches (asks for confirmation)
- **clear-copyboard.sh** -- wipe the clipboard
- **flush-dns.sh** -- flush DNS (restarts mDNSResponder, prompts for your admin password)
- **nasa-picture.sh** -- NASA astronomy pic of the day
- **today-in-history.sh** -- what happened on this day (from Wikipedia)
- **todays-word.sh** -- random word + definition
- **random-article.sh** -- random Wikipedia page
- **timer.sh** -- simple minute timer with notification

## Setup

Clone it, then in Raycast go to Settings > Extensions > Script Commands > Add Script Directory and point it at this folder.

```bash
git clone https://github.com/AnilBurcu/Raycast-Extensions.git
```

Needs [Homebrew](https://brew.sh) for the brew script, obviously. The NASA, history and word scripts need `jq`, which ships with macOS 15+ (`brew install jq` on older versions).

## Raycast 2.x notes

Raycast 2.x runs script commands from its own Node backend with a bare `PATH`
(`/usr/bin:/bin:/usr/sbin:/sbin`) and no terminal attached. That means:

- Nothing from Homebrew, rbenv, nvm etc. is on `PATH`. Scripts that need those
  tools set up `PATH` themselves at the top (see `brew-maintenance.sh`).
- `sudo` can't ask for a password. Use `osascript ... with administrator privileges`
  instead (see `flush-dns.sh`).
- Raycast waits for the script's stdout/stderr to close. Background jobs must be
  started with `nohup ... >/dev/null 2>&1 &` or the command appears to hang
  (see `timer.sh`).
- `TMPDIR` is not set. Use `getconf DARWIN_USER_TEMP_DIR` as a fallback.
- `@raycast.currentDirectoryPath ~` is passed to the process verbatim, so the spawn
  fails with ENOENT and Raycast sits on "Running..." forever. Drop the directive
  and `cd "$HOME"` inside the script instead.

## Author

([@AnilBurcu](https://github.com/AnilBurcu))

MIT license.
