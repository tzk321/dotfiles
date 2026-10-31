#!/usr/bin/env bash
# 把仓库里的配置软链到 $HOME。已存在的文件/目录会先备份为 *.bak-<时间戳>。
# 用法: ./install.sh [--dry-run]
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
DRY=0
[[ "${1:-}" == "--dry-run" ]] && DRY=1

link() {
  local src="$1" dst="$2"
  if [[ -L "$dst" && "$(readlink -f "$dst")" == "$(readlink -f "$src")" ]]; then
    echo "ok    $dst"
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    echo "bak   $dst -> $dst.bak-$STAMP"
    (( DRY )) || mv "$dst" "$dst.bak-$STAMP"
  fi
  echo "link  $dst -> $src"
  (( DRY )) || { mkdir -p "$(dirname "$dst")"; ln -s "$src" "$dst"; }
}

# ~/.config/* 逐个软链
for entry in "$REPO"/.config/*; do
  name="$(basename "$entry")"
  link "$entry" "$HOME/.config/$name"
done

# Firefox 的 user.js 需要放进实际 profile 目录（名字每台机器不同）
for prof in "$HOME"/.config/mozilla/firefox/*/; do
  [[ -f "${prof}prefs.js" ]] || continue
  link "$REPO/firefox/user.js" "${prof}user.js"
done

cat <<'EOF'

完成。注意：
  - fontconfig / gtk 的改动重启对应程序即可生效；environment.d 需要重新登录。
  - 已安装的额外字体（如 LXGW Neo XiHei）不在仓库里，需要自行放到 ~/.local/share/fonts/。
EOF
