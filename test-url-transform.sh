#!/usr/bin/env bash
set -euo pipefail

# Test cases: input → expected output
# Format: input|expected
TESTS=(
  "https://github.com/user/repo|https://gitmcp.io/user/repo"
  "http://github.com/user/repo|https://gitmcp.io/user/repo"
  "github.com/user/repo|https://gitmcp.io/user/repo"
  "user/repo|https://gitmcp.io/user/repo"
  "https://user.github.io/repo|https://user.gitmcp.io/repo"
  "http://user.github.io/repo|https://user.gitmcp.io/repo"
  "user.github.io/repo|https://user.gitmcp.io/repo"
  "user.github.io/repo/extra/path|https://user.gitmcp.io/repo"
)

failures=0
for test in "${TESTS[@]}"; do
  input="${test%%|*}"
  expected="${test##*|}"
  # Simulate the normalization logic from ask-repo
  if [[ "$input" =~ ^(https?://)?([a-zA-Z0-9_-]+)\.github\.io/([a-zA-Z0-9_-]+) ]]; then
    username="${BASH_REMATCH[2]}"
    repo="${BASH_REMATCH[3]}"
    url="https://$username.gitmcp.io/$repo"
  else
    path=$(echo "$input" | sed -E 's/^(https?:\/\/)?(www\.)?github\.com\///' | sed 's/\.git$//' | sed 's/\/$//')
    if [[ "$path" =~ ^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+$ ]]; then
      url="https://gitmcp.io/$path"
    else
      url="INVALID"
    fi
  fi
  if [[ "$url" == "$expected" ]]; then
    echo "PASS: $input → $url"
  else
    echo "FAIL: $input → $url (expected $expected)" >&2
    failures=$((failures+1))
  fi
done

if [[ $failures -gt 0 ]]; then
  echo "$failures test(s) failed." >&2
  exit 1
else
  echo "All tests passed."
fi
