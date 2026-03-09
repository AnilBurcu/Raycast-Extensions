# Raycast Script Commands

A collection of useful macOS script commands for [Raycast](https://raycast.com).

## Scripts

### System

| Script | Description |
|--------|-------------|
| [Clear Clipboard History](clear-copyboard.sh) | Clears the system clipboard contents. |
| [Flush DNS Cache](flush-dns.sh) | Flushes the macOS DNS cache by restarting mDNSResponder. |

### Development Tools

| Script | Description |
|--------|-------------|
| [Homebrew Maintenance](brew-maintenance.sh) | Updates, upgrades, cleans, and checks for issues with Homebrew packages. |
| [Clean Development Caches](dev-cache-clean.sh) | Cleans all development caches: NPM, Watchman, Metro, CocoaPods, Xcode, and Gradle. |

### Learning

| Script | Description |
|--------|-------------|
| [Today's Word](todays-word.sh) | Displays a daily English word with its definition, pronunciation, and usage example. |
| [Today in History](today-in-history.sh) | Shows notable historical events that happened on today's date. |
| [NASA Picture of the Day](nasa-picture.sh) | Fetches and displays NASA's Astronomy Picture of the Day. |
| [Random Wikipedia Article](random-article.sh) | Opens a random English Wikipedia article in the default browser. |

### Productivity

| Script | Description |
|--------|-------------|
| [Timer](timer.sh) | Sets a timer for a specified number of minutes and sends a macOS notification when done. |

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/AnilBurcu/raycast-scripts.git
   ```

2. Open Raycast Settings → Extensions → Script Commands → Add Script Directory.

3. Select the cloned folder and you're good to go.

## Requirements

- macOS
- [Raycast](https://raycast.com)
- [Homebrew](https://brew.sh) (for `brew-maintenance.sh`)

## Author

**Perikles** — [@AnilBurcu](https://github.com/AnilBurcu)

## License

MIT
