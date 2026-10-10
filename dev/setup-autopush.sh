#!/bin/sh
# ติดตั้ง auto-push hook (ใช้เมื่อย้ายเครื่อง หรือ clone repo นี้ใหม่)
#   รันด้วย:  sh dev/setup-autopush.sh
set -e
root=$(git rev-parse --show-toplevel)
cp "$root/dev/post-commit.sh" "$root/.git/hooks/post-commit"
chmod +x "$root/.git/hooks/post-commit"
echo "✓ ติดตั้ง auto-push hook เรียบร้อย — ทุก git commit จะ push ขึ้น GitHub เอง"
