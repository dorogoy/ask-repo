# Copilot Instructions

## Project Overview

This is a bash utility script that provides a convenient wrapper around the `goose` AI agent tool to interact with GitHub repositories via the GitMCP service. The script normalizes various GitHub URL formats and launches interactive AI sessions for repository analysis.

## Architecture

- **Single executable**: `ask-repo` - A standalone bash script that serves as the main entry point
- **External dependency**: Requires `goose` CLI tool to be installed and available in PATH
- **Service integration**: Connects to `gitmcp.io` service which provides GitHub repository access for AI agents


## Key Patterns

### URL Normalization Pipeline
The script implements a multi-step normalization process for both GitHub repository and GitHub Pages URLs:

#### GitHub Repository URLs
```bash
# Input: https://github.com/user/repo.git
# Step 1: Strip protocol and domain
REPO_PATH=$(echo "$REPO_INPUT" | sed -E 's/^(https?:\/\/)?(www\.)?github\.com\///')
# Step 2: Remove .git suffix and trailing slashes
REPO_PATH=$(echo "$REPO_PATH" | sed 's/\.git$//' | sed 's/\/$//')
# Result: user/repo
```

#### GitHub Pages URLs
```bash
# Input: https://username.github.io/repo or username.github.io/repo
# Step 1: Detect username.github.io/repo pattern
# Step 2: Extract username and repo
# Step 3: Transform to username.gitmcp.io/repo (do not preserve subpaths)
# Result: https://username.gitmcp.io/repo
```

### URL Construction
- Standard repo: `user/repo` → `https://gitmcp.io/user/repo`
- GitHub Pages: `username.github.io/repo` → `https://username.gitmcp.io/repo`

### Supported Input Formats
- GitHub repository URLs (with or without protocol, with or without .git)
- GitHub Pages URLs (with or without protocol, with or without subpaths)

### Expected Behavior for GitHub Pages URLs
- Recognizes URLs like `username.github.io/repo`, `https://username.github.io/repo`, and `http://username.github.io/repo`
- Transforms to `https://username.gitmcp.io/repo` for GitMCP service
- Preserves any additional subpaths or query parameters
- Validates that both username and repo are present
- Rejects malformed GitHub Pages URLs with a clear error message

### Relationship to Repository Structure
- The `username.github.io/repo` pattern corresponds to the `repo` repository owned by `username` on GitHub
- The transformation allows AI agents to analyze the source repository behind a GitHub Pages site

### Error Handling for GitHub Pages URLs
- Malformed or incomplete GitHub Pages URLs are rejected
- Only valid `username/repo` pairs are accepted

### Example Transformations
- `https://username.github.io/repo` → `https://username.gitmcp.io/repo`
- `username.github.io/repo` → `https://username.gitmcp.io/repo`

### Default Behavior
- When no repository is specified, defaults to `gitmcp.io/docs`
- This provides immediate value for users exploring the service documentation

### URL Construction
- Transforms normalized `user/repo` format into `https://gitmcp.io/user/repo`
- This is the critical integration point with the GitMCP service

## Development Workflow

### Testing the Script
```bash
# Make executable if not already
chmod +x ask-repo

# Test with different input formats
./ask-repo dorogoy/ask-repo
./ask-repo https://github.com/dorogoy/ask-repo.git
./ask-repo  # Uses default repo
```

### Validation Logic
The script enforces strict repository path validation:
- Must match pattern: `^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+$`
- Rejects malformed inputs and shows usage help

## Error Handling Patterns

1. **Dependency checking**: Validates `goose` availability before proceeding
2. **Input validation**: Regex-based format checking with helpful error messages
3. **Command failure detection**: Checks goose exit status and reports failures

## Installation Context

This is designed as a system-wide utility:
- Should be placed in PATH (e.g., `~/bin`, `/usr/local/bin`)
- Requires execute permissions
- Depends on external `goose` installation

## Key Files

- `ask-repo`: Main executable script containing all logic
- `README.md`: User documentation with installation and usage examples
