# ask-repo

Ask questions to AI agents about the full content of public GitHub repositories.

## Installation

1.  Ensure you have `goose` installed and available in your PATH.
2.  Place the `ask-repo` script in a directory included in your PATH (e.g., `~/bin` or `/usr/local/bin`).
3.  Make the script executable: `chmod +x ask-repo`

## Usage

```bash
ask-repo [github_url|user/repo]
```

### Examples

-   **Ask about a specific repository:**

    ```bash
    ask-repo https://github.com/dorogoy/ask-repo
    ```

-   **Use the shorthand format:**

    ```bash
    ask-repo dorogoy/ask-repo
    ```

-   **Use the default repository (`gitmcp.io/docs`):**

    ```bash
    ask-repo
    ```

## How it Works

The script takes a GitHub repository URL or a `user/repo` string as input, normalizes it, and then constructs a `gitmcp.io` URL. It then initiates a `goose` session with the appropriate remote extension, allowing you to interact with the repository's content.

## Error Handling

The script includes error handling for:

-   **Invalid repository formats:** If the input doesn't match the expected formats, it will display a usage message.
-   **Missing `goose` installation:** It checks for the `goose` command and provides an error message if it's not found.
-   **`goose` command failures:** If the `goose` session fails to start, it will report an error.

## Example Questions

Once the session starts, you can ask questions like:

-   "What is the main purpose of this repository?"
-   "Show me the implementation of the `ask-repo` function."
-   "What are the main dependencies of this project?"