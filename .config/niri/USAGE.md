# Niri 使用文档（按当前配置生成）

> 配置文件：`~/.config/niri/config.kdl` + `cfg/*.kdl`
> `Mod` = **Super 键**（Windows 键）。配置保存后 niri 自动热重载，可用 `niri validate` 校验语法。
> 忘记快捷键时按 `Mod+Shift+Esc` 呼出快捷键面板。

---

## 一、应用启动

| 快捷键 | 功能 |
|---|---|
| `Mod+Q` | 终端（kitty） |
| `Mod+R` | 应用启动器（noctalia launcher） |
| `Mod+G` | 文件管理器（Nautilus，Ubuntu 同款） |
| `Mod+E` | 浏览器（Firefox） |
| `Mod+V` | 剪贴板历史（noctalia clipboard） |
| `Mod+A` | 控制中心（noctalia control-center） |
| `Mod+Shift+Z` | Kando 轮盘菜单（Krita 菜单） |

## 二、会话 / 系统

| 快捷键 | 功能 |
|---|---|
| `Mod+Alt+L` | 锁屏 |
| `Mod+Shift+Q` | 会话菜单（关机 / 重启 / 注销） |
| `Ctrl+M` | 退出 niri（会结束整个会话） |
| `Mod+Shift+P` | 关闭显示器（OLED 省电 / 隐私） |
| `Mod+Esc` | 切换快捷键抑制（全屏程序抢占按键时用来夺回控制权） |
| `Mod+Shift+Esc` | 显示快捷键覆盖层 |

## 三、媒体与亮度（锁屏时也生效）

| 快捷键 | 功能 |
|---|---|
| `XF86AudioRaiseVolume` / `LowerVolume` | 音量 + / - |
| `XF86AudioMute` | 静音 |
| `XF86AudioMicMute` | 麦克风静音 |
| `XF86AudioPlay` / `XF86AudioPause` | 播放 / 暂停 |
| `XF86AudioNext` / `XF86AudioPrev` | 下一首 / 上一首 |
| `XF86MonBrightnessUp` / `Down` | 亮度 + / - |

## 四、窗口基础操作

| 快捷键 | 功能 |
|---|---|
| `Mod+W` | 关闭当前窗口 |
| `Mod+T` | 切换浮动 / 平铺 |
| `Mod+F` | 当前列最大化（再按恢复） |
| `Mod+Ctrl+F` | 真·全屏（隐藏面板等） |
| `Mod+C` | 居中当前列 |
| `Mod+Ctrl+C` | 居中所有可见列 |

## 五、焦点移动

| 快捷键 | 功能 |
|---|---|
| `Mod+H` / `Mod+←` | 聚焦左列 |
| `Mod+L` / `Mod+→` | 聚焦右列 |
| `Mod+K` / `Mod+↑` | 聚焦上方窗口 |
| `Mod+J` / `Mod+↓` | 聚焦下方窗口 |
| `Mod+Home` | 聚焦第一列 |
| `Mod+End` | 聚焦最后一列 |
| `Mod+Z` | 回到上一个工作区（配合 `workspace-auto-back-and-forth`） |

> 另已启用 `focus-follows-mouse`：鼠标移到窗口上会自动聚焦。

## 六、移动窗口 / 列

| 快捷键 | 功能 |
|---|---|
| `Mod+Ctrl+H` / `Mod+Ctrl+←` | 当前列左移 |
| `Mod+Ctrl+L` / `Mod+Ctrl+→` | 当前列右移 |
| `Mod+Ctrl+K` / `Mod+Ctrl+↑` | 当前窗口上移 |
| `Mod+Ctrl+J` / `Mod+Ctrl+↓` | 当前窗口下移 |
| `Mod+Ctrl+Home` | 当前列移到最前 |
| `Mod+Ctrl+End` | 当前列移到最后 |

## 七、多显示器

| 快捷键 | 功能 |
|---|---|
| `Mod+Shift+←/→/↑/↓` | 聚焦相邻显示器 |
| `Mod+Shift+Ctrl+←/→/↑/↓` | 把当前列移到相邻显示器 |

当前输出：`eDP-1`（2560x1440@165，scale 1.25，支持 VRR）、`HDMI-A-1`（scale 1）。

## 八、工作区

| 快捷键 | 功能 |
|---|---|
| `Mod+1` … `Mod+9` | 切换到工作区 1–9 |
| `Mod+Ctrl+1` … `Mod+Ctrl+9` | 把当前列移到工作区 1–9 |
| `Mod+Z` | 切回上一个工作区 |
| `Mod+滚轮上 / 下` | 上一个 / 下一个工作区（150ms 冷却，防误触） |
| `Mod+Ctrl+滚轮上 / 下` | 把当前列移到上 / 下一个工作区 |

> 工作区是动态的：切到空工作区会新建，切走后空工作区自动回收。

## 九、鼠标 / 滚轮操作

| 操作 | 功能 |
|---|---|
| `Mod+滚轮左 / 右` | 聚焦左 / 右列 |
| `Mod+Ctrl+滚轮左 / 右` | 当前列左 / 右移动 |
| `Mod+Shift+滚轮上 / 下` | 聚焦左 / 右列（垂直滚动版） |
| `Mod+Ctrl+Shift+滚轮上 / 下` | 当前列左 / 右移动（垂直滚动版） |
| `Mod+滚轮上 / 下` | 切换工作区 |

## 十、列布局

| 快捷键 | 功能 |
|---|---|
| `Mod+[` | 把左侧窗口吸入当前列 / 把窗口弹出到左侧 |
| `Mod+]` | 把右侧窗口吸入当前列 / 把窗口弹出到右侧 |
| `Mod+,` | 把右侧窗口合并进当前列 |
| `Mod+.` | 把当前窗口从列中弹出 |
| `Mod+-` / `Mod+=` | 当前列宽度 -10% / +10% |
| `Mod+Shift+-` / `Mod+Shift+=` | 当前窗口高度 -10% / +10% |

默认列宽 50%，预设宽度档位：1/3、1/2、2/3。
布局间距 `gaps 8`；单列时自动居中。

## 十一、截图

| 快捷键 | 功能 |
|---|---|
| `Mod+Print` | `mark-shot` 截图（config.kdl 中定义） |
| `Alt+Ctrl+A` | Babry 智能区域截图 |
| `Print` | 截取当前聚焦显示器全屏 |
| `Ctrl+Shift+1` | 交互式区域截图 |
| `Ctrl+Shift+2` | 全屏截图 |
| `Ctrl+Shift+3` | 截取当前窗口 |

截图不写入默认路径（`screenshot-path null`），由截图工具自行处理保存 / 剪贴板。

## 十二、其他

| 快捷键 | 功能 |
|---|---|
| `Mod+Tab` | 切换概览（Overview） |
| `Mod+Shift+U` | 切换 UGEE 数位板按键桥接 |
| `Mod+Shift+Esc` | 快捷键面板 |

## 十三、输入与交互行为

- 键盘布局：`us`，启动时开启 NumLock。
- 触控板：点按即点击、自然滚动。
- 鼠标：`flat` 加速曲线（无指针加速）。
- 数位板：映射到 `HDMI-A-1`。
- `focus-follows-mouse` + `workspace-auto-back-and-forth` 已开启。
- 输入法：fcitx5 随会话启动，环境变量已配好（`XMODIFIERS` / `QT_IM_MODULE` / `GTK_IM_MODULE` / `SDL_IM_MODULE`）。

## 十四、动画调参

动画在 `cfg/animation.kdl`，采用临界阻尼 spring（`damping-ratio=1.0`，无回弹）：

| 动画 | 当前 stiffness | 说明 |
|---|---|---|
| `workspace-switch` | 450 | 工作区切换，越高越快 |
| `horizontal-view-movement` | 400 | 滚动平移视图 |
| `window-open` | 150 | 窗口打开 |
| `window-movement` / `window-resize` | 150 | 窗口移动 / 缩放 |
| `overview-open-close` | 130 | 概览展开 |
| `window-close` | 350ms + `ease-out-quad` | 掉落旋转 shader |

- 想更快：调高 `stiffness`（600–1000 接近瞬切）；
- 想更慢：调低（80–120）；
- 保持 `damping-ratio=1.0` 即可无反冲。

## 十五、常用命令

```bash
niri validate                 # 校验配置
niri msg action quit          # 退出 niri
niri msg outputs              # 查看显示器名称
niri msg workspaces           # 查看工作区
niri msg windows              # 查看窗口
niri msg action toggle-overview
```

## 十六、故障排查

| 现象 | 处理 |
|---|---|
| 全屏游戏里快捷键失灵 | `Mod+Esc` 切掉快捷键抑制 |
| 改了配置没生效 | `niri validate` 看报错；保存后会自动重载 |
| 某个键没反应 | `Mod+Shift+Esc` 面板确认是否被其他程序占用 |
| 画面掉帧 | 检查是否强制独显运行（本配置已改为按需 `prime-run`） |
| 面板 / 壁纸不显示 | 确认 `noctalia` 已启动（`autostart.kdl`） |
