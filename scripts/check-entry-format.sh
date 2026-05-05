#!/bin/sh
# Validates README.md entry format against the awesome-list style rules.
# Exit 0 = all clear. Exit 1 = violations found.
# Usage: sh scripts/check-entry-format.sh [path/to/README.md]
set -eu

README="${1:-README.md}"
ERRORS=0
lineno=0

# Entry lines are those starting with "- [" (list items with a link).
# Expected format: - [Name](url) - Description.
#   - Description starts with an uppercase letter.
#   - Description ends with a period.
while IFS= read -r line; do
  lineno=$((lineno + 1))

  case "$line" in
    '- ['*)
      # Skip ToC anchor-only links (url starts with #).
      if printf '%s' "$line" | grep -qE '^- \[[^]]+\]\(#'; then
        continue
      fi
      # Must match: - [Text](url) - Uppercase...period.
      if ! printf '%s' "$line" | grep -qE '^- \[[^]]+\]\([^)]+\) - [A-Z].+\.$'; then
        printf 'Line %d: bad entry format: %s\n' "$lineno" "$line"
        ERRORS=$((ERRORS + 1))
      fi
      ;;
    '  - '*)
      # Nested bullet — not permitted.
      printf 'Line %d: nested bullet not allowed: %s\n' "$lineno" "$line"
      ERRORS=$((ERRORS + 1))
      ;;
  esac
done < "$README"

if [ "$ERRORS" -gt 0 ]; then
  printf '\n%d format violation(s) found.\n' "$ERRORS"
  exit 1
fi

printf 'Entry format OK.\n'
