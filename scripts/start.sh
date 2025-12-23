cat << 'EOF' > /home/ubuntu/app/scripts/start.sh
#!/usr/bin/env bash
APP_DIR="/home/ubuntu/app/miniproject4-next"
PID_FILE="$APP_DIR/app.pid"
LOG_FILE="$APP_DIR/app.log"

cd "$APP_DIR" || exit 1

echo "===== START $(date) =====" >> "$LOG_FILE"

# 이미 실행 중이면 중복 실행 방지
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "App already running (PID: $(cat "$PID_FILE"))" >> "$LOG_FILE"
  exit 0
fi

# node_modules 없으면 설치
if [ ! -d "node_modules" ]; then
  echo "node_modules not found. Running npm ci..." >> "$LOG_FILE"
  npm ci --omit=dev >> "$LOG_FILE" 2>&1
fi

# 기존 pid 파일 제거
rm -f "$PID_FILE"

# 앱 실행
nohup npm run start >> "$LOG_FILE" 2>&1 &

# PID 저장
echo $! > "$PID_FILE"

echo "App started (PID: $(cat "$PID_FILE"))" >> "$LOG_FILE"
EOF