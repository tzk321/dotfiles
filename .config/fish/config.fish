# ============================================
#  tzk 的居所 —— 文人雅风 v4.0
#  野狗穿长衫，尾巴还在。
#  配色在 theme.fish，用「换笺」改。
# ============================================

source ~/.config/fish/theme.fish
set -g fish_term24bit 1 # 提示符颜色跟真彩对齐

# --- 入门一句 ---
if status is-interactive
    set -g fish_greeting (sh /usr/local/bin/拾句 2>/dev/null; or echo "此心安处是吾乡。")
    if isatty stdout
        apply_theme
    end
end

# --- 环境 ---
set -gx EDITOR vi
set -gx LANG C.UTF-8
set -gx LC_ALL C.UTF-8
set -gx PATH $PATH $HOME/.local/bin
if test -z "$TERM"; or test "$TERM" = dumb
    set -gx TERM xterm-256color
end

# --- 跳目录，记性比人好 ---
zoxide init fish --cmd j | source 2>/dev/null

# --- 时辰 ---
function 时辰
    set -l names 夜半 鸡鸣 平旦 日出 食时 隅中 日中 日昳 晡时 日入 黄昏 人定
    set -l h (string replace -r '^0+' '' (date +%H) 2>/dev/null)
    test -z "$h"; and set h 0
    set -l i (math -s0 "($h + 1) % 24 / 2 + 1")
    if test -z "$i"; or test $i -lt 1; or test $i -gt 12
        set i 1
    end
    echo $names[$i]
end

# --- 提示符（跟着笺色走）---
function fish_prompt
    set -l last $status
    set_color $TZK_C_MAIN
    echo -n "❯ "
    set_color $TZK_C_TXT
    echo -n (prompt_pwd)
    if test $last -ne 0
        set_color $TZK_C_ERR
        echo -n "  ✗ "$last
    end
    set_color normal
    echo
    set_color $TZK_C_DIM
    echo -n "  ❯ "
    set_color normal
end

function fish_right_prompt
    set_color $TZK_C_DIM
    echo -n (时辰)" · "(date "+%m/%d %H:%M")
    set_color normal
end

# ────────────── 换笺 ──────────────
function 换笺
    set -l out (sh /usr/local/bin/换笺 $argv)
    echo $out
    source ~/.config/fish/theme.fish
    apply_theme
    commandline -f repaint
end

# ────────────── 门楣 ──────────────
function 匾
    set_color $TZK_C_MAIN
    echo ""
    echo "   ──────────  无 米 之 居  ──────────"
    set_color $TZK_C_DIM
    echo "              tzk · 一室清贫 · 聊以自娱"
    set_color normal
    echo ""
end

function 印
    set_color $TZK_C_MAIN
    figlet -w 60 -f slant tzk
    set_color normal
end

# ────────────── 观 ──────────────
function 观
    fastfetch
end
alias 参 观

alias 监 btop
alias 盘 duf
alias 树 'eza --tree --level=2 --group-directories-first'
alias 幕 tmux

# ────────────── 玩 ──────────────
alias 烟 'pipes -p 3 -f 60 -B'
alias 画 chafa
alias 览 w3m
alias 寻 fzf

# ────────────── 缩写：落笔要快 ──────────────
abbr -a g git
abbr -a ga 'git add'
abbr -a gc 'git commit -m'
abbr -a gs 'git status -s'
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a c clear

# ────────────── 新家伙事 ──────────────
alias ls 'eza --group-directories-first'
alias ll 'eza -lah --group-directories-first --git'
alias la 'eza -a --group-directories-first'
alias lt 'eza --tree --level=2'
alias cat 'bat --paging=never'
alias 图 'eza -lah --icons --group-directories-first' # 有 Nerd Font 才好看

# ────────────── 闲情 ──────────────
alias 茗 'echo 一盏清茶，半日浮生。'
alias 卧云 'echo 卧看云起，且睡。'
alias 出游 'echo 竹杖芒鞋，出门两条街。'
alias 囊涩 'echo 囊中羞涩，无米。'
alias 拾句 'sh /usr/local/bin/拾句'
alias 无米 'echo 囊中羞涩，无米。'
alias 典 'echo 妙哉。'

# ────────────── 观 ──────────────
function 吾庐
    set_color $TZK_C_MAIN
    echo "——— 吾 庐 ———"
    set_color normal
    eza -lah --group-directories-first $HOME
    echo ""
    set_color $TZK_C_DIM
    echo "器物在 bin，废纸在 tmp，心事在 notes。"
    set_color normal
end

function 问身
    echo "真身："$(whoami)
end

function 问津
    if python3 -c "import socket;socket.create_connection(('114.114.114.114',53),2)" 2>/dev/null
        echo "津渡可通。"
    else
        echo "此路不通，归去来兮。"
    end
end

# ────────────── 簿：堂上一览 ──────────────
function 簿
    python3 /usr/local/bin/簿 $TZK_C_MAIN $TZK_C_TXT $TZK_C_DIM
end

# ────────────── 键位 ──────────────
function __fzf_history
    set -l line (history | fzf --height 40% --reverse --tac --prompt='寻往 › ')
    test -n "$line"; and commandline -r -- $line
end

function __fzf_cd
    set -l d (fd --type d --hidden --exclude .git | fzf --height 40% --reverse --prompt='入哪 › ')
    test -n "$d"; and cd $d
end

function fish_user_key_bindings
    bind \cr __fzf_history
    bind \ec __fzf_cd
end

# ────────────── 旧名留一线 ──────────────
alias 家 吾庐
alias 谁 问身
alias 网 问津
alias 整活 拾句

alias ff fastfetch
