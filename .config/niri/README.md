# Niri

滚动式 Wayland 合成器配置，搭配 noctalia-shell 桌面栏使用。

## 文件说明

- `config.kdl` - 主配置文件，通过 `include` 引入各模块
- `cfg/` - 模块化配置片段
  - `autostart.kdl` - 自启动应用（noctalia-shell、polkit、clipse 剪贴板）
  - `keybinds.kdl` - 快捷键绑定
  - `input.kdl` - 输入设备设置（鼠标加速 profile 为 flat）
  - `display.kdl` - 显示器设置
  - `layout.kdl` - 窗口布局（首个窗口居中）
  - `rules.kdl` - 窗口规则（全局圆角 8px、fcitx 浮动、noctalia 壁纸置于底层）
  - `misc.kdl` - 其他设置
  - `animation.kdl` - 动画参数（spring 临界阻尼平滑动画）
  - `colors.kdl` - 焦点环颜色（由 morandi-gen.py 自动生成，动态流动渐变）

## 主要配置

- 全局窗口透明度 0.98 + 背景模糊（Krita / Steam / Loupe / Kando 等除外）
- 鼠标加速关闭（flat profile）
- 光标主题 Bibata-Modern-Classic，大小 16
- fcitx5 输入法环境变量已配置

## 快捷键一览

完整、与当前配置同步的快捷键文档见 **[USAGE.md](./USAGE.md)**。

常用：

| 快捷键 | 功能 |
|--------|------|
| `Mod+Q` | 终端 (kitty) |
| `Mod+R` | 应用启动器 |
| `Mod+G` | 文件管理器 (Nautilus) |
| `Mod+E` | 浏览器 (Firefox) |
| `Mod+W` | 关闭窗口 |
| `Mod+T` | 浮动/平铺切换 |
| `Mod+Tab` | 概览 |
| `Mod+1~9` | 切换工作区 |
| `Mod+Shift+Esc` | 快捷键面板 |
| `Mod+Esc` | 解除快捷键抑制 |

## 窗口规则

- 所有窗口：圆角 8px，裁剪到几何体
- fcitx：自动浮动
- noctalia 壁纸层：置于底层背景
- 全局窗口透明度 0.8 + 背景模糊
- Krita：不透明、无模糊
- Kando：浮动、无边框、无阴影、无圆角

## 动画

使用 macOS 风格的临界阻尼平滑动画系统：
- 阻尼比 (damping-ratio) 统一设置为 1.0 实现零回弹的极致丝滑体验
- 硬度 (stiffness) 按用途分档：工作区切换 450、水平视图 400、窗口类 130~150；越高越快
- 边框颜色采用 relative-to="workspace-view" 锚定工作区，实现拖动时的动态流彩边框动画
- 窗口关闭使用带有掉落和轻微旋转的魔法 Shader 着色器

## 相关链接

- [Niri GitHub](https://github.com/YaLTeR/niri)
- [配置文档](https://github.com/YaLTeR/niri/wiki/Configuration:-Introduction)
- [快捷键文档](https://github.com/YaLTeR/niri/wiki/Configuration:-Key-Bindings)
