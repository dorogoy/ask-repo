
# ask-repo

A bash utility to interact with GitHub repositories and GitHub Pages via the GitMCP service using the `goose` AI agent. Ask questions to AI agents about the full content of public GitHub repositories.

## Requirements

- **goose**: This script requires the `goose` CLI tool to be installed and available in your `PATH`.
  - You can find goose at: <https://github.com/pressly/goose>
    **Note:** This project expects a custom AI agent tool named `goose`, not the database migration tool. If you are unsure, check with your team for the correct binary.
  - Minimum recommended version: 1.0.0 (or the latest available)
  - To check if goose is installed and available:

    ```bash
    goose --version
    ```

  - If not installed, follow your organization's instructions or download the binary and place it in a directory included in your `PATH`.

## Installation

1. Ensure you have `goose`, the CLI version, installed and available in your PATH.
2. Place the `ask-repo` script in a directory included in your PATH (e.g., `~/bin` or `/usr/local/bin`).
3. Make the script executable: `chmod +x ask-repo`

## Usage

```bash
ask-repo [github_url|user/repo] [-- goose options]
```

- You can pass additional options to the underlying `goose session` command by using `--`.
- Use `ask-repo --upgrade` to automatically update the script to the latest version from GitHub.

### Examples

- **Ask about a specific repository:**

    ```bash
    ask-repo https://github.com/dorogoy/ask-repo
    ```

- **Use the shorthand format (defaults to docs):**

    ```bash
    ask-repo
    ```

## Features

- Supports public GitHub repositories and GitHub Pages URLs
- Normalizes various URL formats for seamless AI analysis
- Launches interactive AI sessions for repository exploration

## Supported URL Formats

- GitHub repositories:
  - `github.com/user/repo`
  - `https://github.com/user/repo`
  - `user/repo`
- GitHub Pages:
  - `username.github.io/repo`
  - `https://username.github.io/repo`
  - `http://username.github.io/repo`
  - URLs with additional paths: `username.github.io/repo/path/to/file`

## URL Transformation

- GitHub repository: `https://github.com/user/repo` → `https://gitmcp.io/user/repo`
- GitHub Pages: `https://username.github.io/repo` → `https://username.gitmcp.io/repo`

## Error Handling

- Invalid or malformed URLs are rejected with a clear error message
- Dependency on `goose` is checked before execution

## License

MIT
