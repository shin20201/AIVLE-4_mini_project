#!/usr/bin/env bash
APP_DIR="/home/ubuntu/app/miniproject4-next"
PID_FILE="$APP_DIR/app.pid"
LOG_FILE="$APP_DIR/app.log"

cd "$APP_DIR" || exit 1

echo "===== START $(date) =====" >> "$LOG_FILE"

if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "App already running (PID: $(cat "$PID_FILE"))" >> "$LOG_FILE"
  exit 0
fi

if [ ! -d "node_modules" ]; then
  echo "node_modules not found. Running npm ci..." >> "$LOG_FILE"
  npm ci --omit=dev >> "$LOG_FILE" 2>&1
fi

rm -f "$PID_FILE"
nohup npm run start >> "$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"

echo "App started (PID: $(cat "$PID_FILE"))" >> "$LOG_FILE"