#!/usr/bin/env bash
# Turn the day's audio script into brief.mp3 with xAI Grok text to speech.
# Usage: XAI_API_KEY=... ./templates/scripts/make_audio.sh script.txt [voice] [speed]
# The key is read from the environment only. Never commit it.
set -euo pipefail

SCRIPT_FILE="${1:?usage: make_audio.sh script.txt [voice] [speed]}"
VOICE="${2:-ara}"      # see GET https://api.x.ai/v1/tts/voices for the full list
SPEED="${3:-0.95}"     # 0.7 to 1.5; 0.95 lands about 750 words near 4:35
OUT="${OUT:-brief.mp3}"

: "${XAI_API_KEY:?Set XAI_API_KEY in your environment first}"
command -v jq >/dev/null || { echo "jq is required"; exit 1; }
command -v ffprobe >/dev/null || { echo "ffmpeg (ffprobe) is required"; exit 1; }

# One request handles up to 60,000 characters, far more than a 750-word script.
jq -n --rawfile text "$SCRIPT_FILE" --arg voice "$VOICE" --argjson speed "$SPEED" \
  '{text: $text, voice_id: $voice, language: "en", speed: $speed}' |
curl -sS --fail-with-body -X POST "https://api.x.ai/v1/tts" \
  -H "Authorization: Bearer ${XAI_API_KEY}" \
  -H "Content-Type: application/json" \
  --data-binary @- \
  --output "$OUT.tmp"

mv "$OUT.tmp" "$OUT"   # overwrite, so only the latest audio exists

DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$OUT")
printf 'Wrote %s (%.0f seconds). Target is 270 to 330 seconds.\n' "$OUT" "$DUR"
awk -v d="$DUR" 'BEGIN { exit !(d >= 270 && d <= 330) }' || echo "Warning: outside the 4:30 to 5:30 target. Adjust the script length or the speed."
