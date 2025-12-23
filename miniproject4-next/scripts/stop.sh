#!/usr/bin/env bash
APP_DIR="/home/ubuntu/app/miniproject4-next"
PID_FILE="$APP_DIR/app.pid"
LOG_FILE="$APP_DIR/app.log"

echo "===== STOP $(date) =====" >> "$LOG_FILE"

if [ -f "$PID_FILE" ]; then
  PID=$(cat "$PID_FILE")

  if kill -0 "$PID" 2>/dev/null; then
    kill -TERM "$PID" || true
    sleep 2
  fi

  rm -f "$PID_FILE"
  echo "App stopped (PID: $PID)" >> "$LOG_FILE"
else
  echo "No PID file found" >> "$LOG_FILE"
fi