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

# 视频壁纸相关：脚本、本地插件、systemd 用户单元、说明文档
# 这些不能走上面 .config/* 的整目录软链：~/.config/noctalia 与 ~/.config/systemd 里
# 还有实机状态和别的单元，只能逐个文件链。
for f in \
  .local/bin/video-wallpaper \
  .local/share/noctalia/plugins/video-frame/plugin.toml \
  .local/share/noctalia/plugins/video-frame/main.luau \
  .config/systemd/user/video-wallpaper-sync.path \
  .config/systemd/user/video-wallpaper-sync.service \
  .config/systemd/user/video-wallpaper-posters.path \
  .config/systemd/user/video-wallpaper-posters.service \
  .config/noctalia/video-wallpaper.md; do
  link "$REPO/$f" "$HOME/$f"
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
  - 视频壁纸：链接完后执行
      systemctl --user daemon-reload
      systemctl --user enable --now video-wallpaper-sync.path video-wallpaper-posters.path
    并在 noctalia 设置里启用 local/video-frame 插件。
EOF
