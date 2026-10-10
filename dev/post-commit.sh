#!/bin/sh
# Auto-push ขึ้น GitHub ทุกครั้งที่ commit สำเร็จ
# ปิดชั่วคราว:  NO_AUTOPUSH=1 git commit -m "..."
# ปิดถาวร:     chmod -x .git/hooks/post-commit

[ -n "$NO_AUTOPUSH" ] && exit 0

branch=$(git symbolic-ref --short HEAD 2>/dev/null) || exit 0

printf '\n\033[36m[auto-push]\033[0m กำลังส่ง %s ขึ้น GitHub...\n' "$branch"

if git push -u origin "$branch" >/tmp/autopush.log 2>&1; then
  url=$(git remote get-url origin | sed 's/\.git$//')
  printf '\033[32m[auto-push] ✓ สำเร็จ\033[0m  %s/commits/%s\n\n' "$url" "$branch"
else
  printf '\033[31m[auto-push] ✗ ไม่สำเร็จ\033[0m — commit ยังอยู่ในเครื่องปลอดภัย\n'
  tail -4 /tmp/autopush.log
  printf 'แก้แล้วส่งใหม่ด้วย:  git push\n\n'
fi
exit 0
