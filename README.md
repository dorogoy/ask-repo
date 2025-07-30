# ask-repo

Ask questions to AI agents about the full content of public GitHub repositories.

## Installation

1.  Ensure you have `goose` installed.
2.  Place the `ask-repo` script in a directory that is in your `PATH` (e.g., `~/bin`).
3.  Make the script executable: `chmod +x ask-repo`

## Usage

```bash
ask-repo [github_url|user/repo]
```

### Examples

-   `ask-repo github.com/dorogoy/ask-repo`
-   `ask-repo https://github.com/dorogoy/ask-repo`
-   `ask-repo dorogoy/ask-repo`
-   `ask-repo` (defaults to `gitmcp.io/docs`)

## How it Works

The script takes a GitHub repository URL or a `user/repo` string as input, normalizes it, and then uses the `goose` command to start a session with the `gitmcp.io` extension. This allows you to ask questions about the repository's content.

## Error Handling

The script includes error handling for:

-   Invalid repository formats
-   Missing `goose` installation

## Requirements

-   [goose](https://github.com/gemini-cli/goose) must be installed.

## Example Questions

-   "What is the main purpose of this repository?"
-   "Summarize the README file."
-   "Where is the main entry point of the application?"
