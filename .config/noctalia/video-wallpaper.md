# 视频壁纸（mp4 当桌面壁纸）

播放由 noctalia 官方插件 `noctalia/mpvpaper`（Video Wallpaper, 1.2.2）负责；
选择有两种入口：插件自己的影片面板，以及 **noctalia 自带的壁纸面板**（靠海报代理实现，见下）。

## 组成

| 部件 | 位置 | 作用 |
| --- | --- | --- |
| 播放/选择面板 | 插件 `noctalia/mpvpaper` | 点缩略图选视频；`Stop` 停止；按输出分配（`*` = 所有输出） |
| 插件设置 | `[plugin_settings."noctalia/mpvpaper"]` | `video_directory`、`extract_last_frame = false` |
| 海报代理 | `~/Pictures/WallPapers/<视频>.jpg` | 视频抽帧 + 播放角标，让自带壁纸面板能列出视频 |
| 海报生成 | `video-wallpaper posters` + `video-wallpaper-posters.path` | 目录里有新视频时自动补海报 |
| 配色联动脚本 | `~/.local/bin/video-wallpaper` | 抽帧取色 → noctalia palette + 各应用配色 |
| 自动触发 | `video-wallpaper-sync.path`（systemd 用户单元） | 监听插件的 `assignments.json`，换视频/停止时自动跑 `sync` |
| 壁纸切换 hook | `[hooks] wallpaper_changed` 第 2 条命令 | 点海报→起视频；点静态图→`clear-all` 让视频退出 |

## 为什么要有海报

noctalia 自带的壁纸面板（`内置/壁纸/社区/自定义/M3 Content`）只扫图片扩展名，
白名单写死在 `src/core/files/directory_scanner.cpp` 的 `kImageExtensions` 里，没有视频。
所以给每个视频在旁边生成一张同名海报 `<视频>.jpg`：面板里就是正常的缩略图瓦片，
点它时 `wallpaper_changed` hook 认出 `.mp4.jpg` 结尾，找到真视频交给插件播放。

改源码重编也能直接支持视频，但要多维护一份 patch，所以选了不动二进制的海报方案。

## 日常操作

- **换成视频壁纸**：自带壁纸面板里点带播放角标的瓦片（名字是 `xxx.mp4.jpg`）；
  或用插件自己的影片面板点缩略图。
- **换成静态壁纸**：照常点普通图片，视频会自动停掉（hook 触发）。
- **临时停视频**：影片面板里的 `Stop`。
- **换视频目录**：插件设置里的 `video_directory`（当前 `~/Pictures/WallPapers`）；
  换目录后海报单元也要跟着改（`~/.config/systemd/user/video-wallpaper-posters.path`）。
- **补海报**：`video-wallpaper posters`（幂等，只处理新视频）。

## 配色是怎么来的

`video-wallpaper colors <视频> [秒]` 抽一帧（默认视频中点），然后：

0. 抽帧只取长边 1600px 的 jpg（原视频 4K，取色用不上全分辨率）；
1. `noctalia theme <帧> --scheme muted -o ~/.config/noctalia/colors.json` —— 扁平 token 表，
   给 morandi-gen 和各应用用；
2. `noctalia theme <帧> --scheme <theme.wallpaper_scheme>` + 转成 v2 格式，写
   `~/.config/noctalia/palettes/video-wallpaper.json`，再 `color-scheme-set custom video-wallpaper`
   —— noctalia 自己的 UI 用这份（近白/线稿画面不能用 muted，会退化成全白，丢强调色）；
3. `morandi-gen.py --wallpaper <帧>` —— niri 边框、kitty/alacritty、fcitx5、starship、fastfetch、Qt、limine 等。

停止视频后 `sync` 会把配色源切回 `wallpaper <theme.wallpaper_scheme>`。

## 缓存与耗时

- 缓存键 = 视频路径 + 大小/mtime + 指定时间点（`cache_key()`），目录
  `~/.cache/video-wallpaper/palette-cache/<key>/`，存 `frame.jpg` / `colors.json` / `palette.json`。
- 命中时跳过 theme + morandi-gen（只拷回 palette 并 `color-scheme-set`）：**约 1.5s**。
- 首次遇到一支视频要跑完整链路：**约 8s**，绝大部分耗在 `morandi-gen.py`（它会重写
  VS Code / IntelliJ / fcitx5 等一堆应用配置，CPU 飙高、风扇转）。
- 帧文件 252K / overview 帧 44K（原来 4K 原帧几 MB）。

## overview

走「静态壁纸路线」：取色时抽的那帧会同时喂给 noctalia 自己的壁纸层，所以 overview 里看到的是
**这一帧静态图**（和静态壁纸切换后 overview 自动同步是同一套机制）。

为什么需要本地插件 `local/video-frame`：视频在播时 mpvpaper 插件会把该输出标成 externally-managed
（`Wallpaper::setOutputExternallyManaged`，`src/shell/wallpaper/wallpaper.cpp:907`），壁纸层直接不创建；
而 `wallpaper-set` 不会清这个标记（`m_externallyManagedOutputs` 只由插件调 `setWallpaperEnabled(conn, true)`
清除）。所以小插件收到 IPC `frame <路径>` 后依次 `setWallpaperEnabled(name, true)` + `setWallpaper(name, 路径)`。

- 插件位置：`~/.local/share/noctalia/plugins/video-frame/{plugin.toml,main.luau}`（local 源优先级最高，
  不会被官方插件更新覆盖），启用状态：`noctalia msg plugins list`。
- 桌面仍是 mpvpaper 的视频（壁纸层在它下面），overview 是这一帧。
- 喂给壁纸层的是 **1280px + 高斯模糊**的小图（`~/.cache/video-wallpaper/overview.jpg`，44K），
  不是 4K 原帧——它只做背景底，细节没意义，大图会拖纹理内存和 overview 帧率。
- 推送后会用 `niri msg layers` 验证 `noctalia-wallpaper` 层真的在（mpvpaper 插件重启会把层撤掉，
  而且可能发生在推送之后），不在就重推，最多 4 次。
- 点海报切到「正在播的那支视频」时也会重推干净帧，否则 overview 会留带播放角标的海报。

## 已知限制

- 海报是普通 jpg，会出现在壁纸目录里，文件名带 `.mp4.jpg`；删视频后海报要手动删。
- 切换视频是「改 `assignments.json` + 重启插件服务」实现的：插件 IPC 没有「播放指定路径」的入口，
  服务只在启动时读分配文件。代价是切换瞬间有一次插件重启（不到 1 秒），正在播的视频会从头开始。
- 插件停止视频后不会回收 mpvpaper 子进程，会留一个 `[mpvpaper] <defunct>` zombie（父进程是 noctalia），
  无害；脚本里判断「是否在播放」时会过滤 zombie，否则会误判。
- systemd 用户管理器的 `WAYLAND_DISPLAY` 可能是旧会话残留（本机出现过 `wayland-2` 而实际是 `wayland-1`），
  那样 `noctalia msg` 会报 `noctalia is not running`。脚本的 `nmsg()` 会按
  `$XDG_RUNTIME_DIR/noctalia-wayland-*.sock` 反推正确 display 重试。
- `extract_last_frame = false` 是刻意的：否则停止视频时插件会把视频帧写成静态壁纸，覆盖用户选的图。
  同时要保证 `~/.cache/noctalia/mpvpaper/` 里没有旧的抽帧缓存，否则插件会复用它。

## 排查

```fish
video-wallpaper status                     # 当前视频 / 进程 / 配色源
video-wallpaper posters                    # 重新补海报
journalctl --user -u video-wallpaper-sync.service -f
journalctl --user -u video-wallpaper-posters.service -n 20
niri msg layers | grep -E "mpvpaper|noctalia-wallpaper"   # 哪个层在画背景
noctalia msg plugin noctalia/mpvpaper:service all reapply # 手动拉起视频
noctalia msg plugin noctalia/mpvpaper:service all clear-all
```

## 配色源自愈

`video-wallpaper reconcile` 由 `video-wallpaper-reconcile.timer`（每 20s）调用，
只修一种偏差：已经没有视频分配、配色源却停在 `custom video-wallpaper` 时切回
`wallpaper <theme.wallpaper_scheme>`。其他情况不动，避免抢用户手选的配色源。
