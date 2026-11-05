#!/usr/bin/env bash
#
# macOS 双击入口：调用 Deploy.sh，完成后只关闭当前终端窗口
# 核心逻辑在 Deploy.sh，本文件只负责窗口管理
#
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd "${SCRIPT_DIR}"

# 调用核心部署脚本（不加 clear，避免双击时输出前大片空白）
bash ./Deploy.sh

# ========== 按任意键后关闭（仅交互终端） ==========
if [ -t 0 ]; then
  echo ""
  read -n 1 -s -t 5 -r -p "按任意键关闭窗口（5 秒后自动关闭）..." || true
fi

# ========== 只关闭当前脚本所在的终端窗口 ==========
# 通过 tty 精确匹配，避免误关用户原本打开的终端
MY_TTY=$(tty 2>/dev/null || true)

if [[ -n "${MY_TTY}" && -e "${MY_TTY}" ]]; then
  if [[ "${TERM_PROGRAM:-}" == "Apple_Terminal" ]]; then
    osascript - "${MY_TTY}" 2>/dev/null <<'APPLESCRIPT' || true
on run argv
    set targetTty to item 1 of argv
    tell application "Terminal"
        repeat with w in windows
            repeat with t in tabs of w
                try
                    if (tty of t) is targetTty then
                        close w
                        exit repeat
                    end if
                end try
            end repeat
        end repeat
    end tell
end run
APPLESCRIPT
  elif [[ "${TERM_PROGRAM:-}" == "iTerm.app" || "${TERM_PROGRAM:-}" == "iTerm2" ]]; then
    osascript - "${MY_TTY}" 2>/dev/null <<'APPLESCRIPT' || true
on run argv
    set targetTty to item 1 of argv
    tell application "iTerm"
        repeat with w in windows
            repeat with t in tabs of w
                repeat with s in sessions of t
                    try
                        if (tty of s) is targetTty then
                            close w
                            exit repeat
                        end if
                    end try
                end repeat
            end repeat
        end repeat
    end tell
end run
APPLESCRIPT
  fi
fi

exit 0
