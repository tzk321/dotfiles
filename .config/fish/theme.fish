# ────────────────────────────────
#  theme.fish —— 由「换笺」自动生成，手改会被覆盖
#  当前：玄夜 · 夜阑听雨
# ────────────────────────────────
set -g TZK_THEME 玄
set -g TZK_THEME_DESC "玄夜 · 夜阑听雨"
set -g TZK_C_MAIN 7FA6D8     # 主色
set -g TZK_C_DIM  54637A     # 暗色
set -g TZK_C_ERR  C98A8A     # 警示
set -g TZK_C_TXT  B9C6D8     # 正文

function __osc
    # 发一条 OSC；tmux 里自动套 passthrough，不然色序被吞
    set -l seq (printf ']%s;%s\a' $argv[1] $argv[2])
    if set -q TMUX
        printf '\033Ptmux;\033\033%s\033\\' $seq
    else
        printf '\033%s' $seq
    end
end

function apply_theme
    # 让终端自己换天光（OSC 序列，不认的终端会静静忽略）
    __osc 10 '#B9C6D8'      # 前景
    __osc 11 '#0E1420'      # 背景
    __osc 12 '#7FA6D8'     # 光标
    __osc 17 '#1B2536'   # 选区底
    __osc 19 '#CBD8E8'   # 选区字
    # fish 自己的调色
    set -g fish_color_normal         9BB0C9
    set -g fish_color_command        7FA6D8
    set -g fish_color_error          C98A8A
    set -g fish_color_param          B9C6D8
    set -g fish_color_comment        54637A
    set -g fish_color_autosuggestion 3D4A5E
    set -g fish_color_quote          C9B58A
    set -g fish_color_operator       7FA6D8
    set -g fish_color_selection      --background=1B2536 --bold
end
