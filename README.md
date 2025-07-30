# ask-repo

Ask questions to AI agents about the full content of public GitHub repositories.

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
- Use `ask-repo --version` to print the script version.
- Use `ask-repo --upgrade` to automatically update the script to the latest version from GitHub.

### Examples

- **Ask about a specific repository:**

    ```bash
    ask-repo https://github.com/dorogoy/ask-repo
    ```

- **Use the shorthand format:**

    ```bash
    ask-repo dorogoy/ask-repo
    ```

- **Use the default repository (`gitmcp.io/docs`):**

    ```bash
    ask-repo
    ```

- **Pass options to goose:**

    ```bash
    ask-repo dorogoy/ask-repo -- --temperature 0.2
    ```

- **Show script version:**

    ```bash
    ask-repo --version
    ```

- **Upgrade to the latest version:**

    ```bash
    ask-repo --upgrade
    ```

## How it Works

The script takes a GitHub repository URL or a `user/repo` string as input, normalizes it, and then constructs a `gitmcp.io` URL. It then initiates a `goose` session with the appropriate remote extension, allowing you to interact with the repository's content.

## Error Handling

The script includes error handling for:

- **Invalid repository formats:** If the input doesn't match the expected formats, it will display a usage message.
- **Missing `goose` installation:** It checks for the `goose` command and provides an error message if it's not found.
- **`goose` command failures:** If the `goose` session fails to start, it will report an error.

## Example Questions

Once the session starts, you can ask questions like:

- "What is the main purpose of this repository?"
- "Show me the implementation of the `ask-repo` function."
- "What are the main dependencies of this project?"
