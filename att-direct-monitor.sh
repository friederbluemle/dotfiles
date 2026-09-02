#!/bin/bash

LOG="$HOME/att-direct-monitor.csv"

TARGETS=(
  "bgw:192.168.99.254"
  "att1:162.231.240.1"
  "att2:71.148.149.126"
  "cloudflare:1.1.1.1"
  "google:8.8.8.8"
)

if [ ! -f "$LOG" ]; then
  echo "timestamp,bgw_ms,att1_ms,att2_ms,cloudflare_ms,google_ms" > "$LOG"
fi

ping_once() {
  local host="$1"
  local result

  result=$(ping -c 1 -W 1 "$host" 2>/dev/null)

  if echo "$result" | grep -q "time="; then
    echo "$result" | sed -n 's/.*time=\([0-9.]*\).*/\1/p'
  else
    echo "LOSS"
  fi
}

TMPDIR_MONITOR=$(mktemp -d)
trap 'rm -rf "$TMPDIR_MONITOR"' EXIT INT TERM

echo "Direct BGW monitor started"
echo "Logging to $LOG"
echo

while true; do
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')

  i=0
  for target in "${TARGETS[@]}"; do
    host="${target#*:}"
    ping_once "$host" > "$TMPDIR_MONITOR/$i" &
    ((i++))
  done

  wait

  bgw=$(cat "$TMPDIR_MONITOR/0")
  att1=$(cat "$TMPDIR_MONITOR/1")
  att2=$(cat "$TMPDIR_MONITOR/2")
  cf=$(cat "$TMPDIR_MONITOR/3")
  google=$(cat "$TMPDIR_MONITOR/4")

  printf '%s | BGW %7s | ATT1 %7s | ATT2 %7s | CF %7s | Google %7s\n' \
    "$timestamp" "$bgw" "$att1" "$att2" "$cf" "$google"

  echo "$timestamp,$bgw,$att1,$att2,$cf,$google" >> "$LOG"

  sleep 1
done
EOF
