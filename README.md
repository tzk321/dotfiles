# dotfiles

sbtzk 的桌面配置（niri + kitty + GTK/Qt + fontconfig + noctalia）。

仓库根目录映射 `$HOME`，所以可以直接软链到 `~/.config`：

```bash
./install.sh          # 建立软链（已存在的会先备份成 .bak-<时间戳>）
```

## 目录

| 路径 | 说明 |
|---|---|
| `.config/niri/` | niri 配置（`config.kdl` + `cfg/*.kdl` 模块化） |
| `.config/kitty/` | 终端（Maple Mono NF CN，morandi 动态配色） |
| `.config/gtk-3.0/`, `.config/gtk-4.0/` | GTK 主题/字体/光标 |
| `.config/fontconfig/` | 字体 fallback 与渲染策略 |
| `.config/environment.d/` | systemd 用户会话环境变量（niri 由 systemd 拉起） |
| `.config/noctalia/` | 状态栏配置（`plugins/` 为第三方下载，未纳入仓库） |
| `firefox/user.js` | Firefox 的 `layout.css.devPixelsPerPx`（见下），需手动拷到 profile 目录 |

`noctalia/state-settings.export.toml` 是 `~/.local/state/noctalia/settings.toml` 的快照（bar 厚度、主题、壁纸等运行时设置），仅供参考，应用会自己写这个文件。

## 屏幕 / 刷新率 / 缩放（2026-11-01 实测结论）

面板：BOE NE173QHM-NY2，17.3" 2560x1440，EDID 报 8bpc / RGB 4:4:4，165.003Hz（另有一个 40Hz 低功耗档）。

- **165Hz 是真实的**：用 `wp_presentation` 测试客户端实测连续重绘，帧间隔 2409/2442 次落在 6.0ms（≈166Hz），掉帧约 0.5%。
- **当前缩放 `scale 1.5`**（逻辑 1706x960）：
  - 支持 `wp_fractional_scale` 的程序（Qt6 / GTK4 / noctalia）按 1.5 原生渲染 → 锐；
  - 不支持的程序（GTK3、XWayland、多数 Electron）：niri 报 `wl_output.scale=2`，它们按 2x 渲染后由 niri 缩到 1.5x，即 **0.75 的非整数重采样** → 文字边缘被摊成 3 像素、发虚。
- **只有整数 scale 能做到 1:1、零重采样**：
  - `scale 1`：2560x1440 逻辑，最锐但 UI 偏小；
  - `scale 2`：1280x720 逻辑，最锐且 UI 大，但工作区只剩一半。
- 试过并已放弃的方案：`scale 1` + 各 toolkit 自行放大（`GDK_DPI_SCALE` / `QT_SCALE_FACTOR` / `kitty font_size` / Firefox `devPixelsPerPx`），因为 GTK 只放大字号不放大控件，观感很别扭。

## 字体（2026-11-01 实测结论）

- Noto Sans CJK 的 hinting 在 FreeType 下几乎是空操作：`pango-view --hinting=none/slight/medium/full` 输出字节完全相同 → 调 hinting 无效。
- 子像素抗锯齿不可用：Wayland 拿不到子像素排列，强制 `rgba=rgb` 会出红蓝彩边。
- 真正有效的是 **字号 + 字重**：`gtk-font-name=Noto Sans CJK SC Medium 11`（Regular→Medium，10→11pt，11pt×1.5=22px），比原来的 Regular 10pt 干净明显。
- `~/.config/fontconfig/fonts.conf` 修掉了 `fc-match sans-serif:lang=zh-cn` 落到 **KR（韩文）字形**的问题。
- 备选字体：`LXGW Neo XiHei`（霞鹜新晰黑），已安装于 `~/.local/share/fonts/`，切换只需改 `gtk-font-name`。

## 恢复

改配置前的原始快照在 `~/backups/config-YYYYMMDD-HHMMSS/`（另有同名 `.tar.gz`）。
