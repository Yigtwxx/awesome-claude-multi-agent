#!/bin/sh
# Checks GitHub repos in README.md for last push date.
# Prints repos whose last push is older than 12 months.
# Usage: sh scripts/check-staleness.sh [path/to/README.md]
set -eu

README="${1:-README.md}"
NOW=$(date +%s)
TWELVE_MONTHS=31536000

printf 'repo\tlast_push\tmonths_stale\n'

grep -oE 'https://github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' "$README" \
  | sort -u \
  | while IFS= read -r url; do
      slug=$(printf '%s' "$url" | sed 's|https://github\.com/||')
      api_url="https://api.github.com/repos/${slug}"
      response=$(curl -sf -H "Accept: application/vnd.github+json" "$api_url" 2>/dev/null) || continue
      pushed=$(printf '%s' "$response" | grep '"pushed_at"' | head -1 | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}')
      [ -z "$pushed" ] && continue
      pushed_ts=$(date -j -f "%Y-%m-%d" "$pushed" "+%s" 2>/dev/null \
                  || date -d "$pushed" "+%s" 2>/dev/null \
                  || echo 0)
      diff=$(( (NOW - pushed_ts) ))
      months=$(( diff / 2592000 ))
      if [ "$diff" -gt "$TWELVE_MONTHS" ]; then
        printf '%s\t%s\t%d\n' "$slug" "$pushed" "$months"
      fi
    done
