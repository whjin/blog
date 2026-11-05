#!/usr/bin/env bash
#
# Blog 一键部署脚本（优化版）
# 流程：
#   1. 清理 .git 内 macOS 元数据（._* AppleDouble）——non-monotonic index 的根因
#   2. 读取 Commit.md，提交源码到 dev 分支并 push
#   3. hexo generate → deploy，把静态站推到 GitHub main 分支
#
# 日常部署默认不跑 hexo clean（增量生成，快很多）。
# 如果改了主题配置、删了文章或样式异常，手动跑一次：hexo clean && bash Deploy.sh
#
# 使用：bash Deploy.sh   或双击 Deploy.command
#
set -euo pipefail

# ========== 路径与配置 ==========
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd "${SCRIPT_DIR}"

SOURCE_BRANCH="dev"
COMMIT_FILE="Commit.md"
DEFAULT_MESSAGE="提交更新"
TIME_THRESHOLD=600  # 提交信息有效期 10 分钟（秒）

# ========== 颜色 ==========
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GRAY='\033[0;90m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
step()  { echo -e "\n${BLUE}========== $1 ==========${NC}"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
elapsed() { echo -e "${GRAY}    ⏱ 耗时 $(( SECONDS - t0 ))s${NC}"; }

# ========== 0. 前置检查 ==========
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  error "当前目录不是 Git 仓库：${SCRIPT_DIR}"
  exit 1
fi

if [ ! -d "./node_modules/hexo" ]; then
  error "未安装依赖，请先执行：pnpm install"
  exit 1
fi

# ========== 1. 清理 .git 内 macOS 元数据 ==========
# 清主仓库 .git/ 和 hexo deploy 缓存仓库 .deploy_git/.git/ 下的 ._*——
# 这是 non-monotonic index 的直接原因（exFAT 上 macOS 会给 pack 文件生成 AppleDouble 副本）。
# 工作区的 ._* / .DS_Store 已被 .gitignore 忽略，不影响 git 和 hexo，无需每次遍历。
step "1/3 清理 .git 内 macOS 元数据"
t0=${SECONDS}
clean_git=$(find .git -name "._*" -print -delete 2>/dev/null | wc -l | tr -d ' ' || echo 0)
clean_deploy=0
if [ -d ".deploy_git/.git" ]; then
  clean_deploy=$(find .deploy_git/.git -name "._*" -print -delete 2>/dev/null | wc -l | tr -d ' ' || echo 0)
fi
total_clean=$((clean_git + clean_deploy))
if [ "${total_clean}" -gt 0 ]; then
  info "已清理 ${total_clean} 个 ._* 文件（主仓库 ${clean_git} + deploy 缓存 ${clean_deploy}）"
else
  info ".git 内无冗余元数据"
fi
elapsed

# ========== 2. 提交源码到 dev 分支 ==========
step "2/3 提交源码到 ${SOURCE_BRANCH} 分支"
t0=${SECONDS}

# 2.1 读取 Commit.md
[ -f "${COMMIT_FILE}" ] || touch "${COMMIT_FILE}"
latest_commit_line=$(sed '/^[[:space:]]*$/d' "${COMMIT_FILE}" | head -n 1 || true)
commit_timestamp_str=$(echo "${latest_commit_line}" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' || true)

if [[ -n "${commit_timestamp_str}" ]]; then
  latest_commit=$(echo "${latest_commit_line}" | sed "s/^${commit_timestamp_str}//" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
  commit_ts=$(date -j -f "%Y-%m-%d %H:%M:%S" "${commit_timestamp_str}" +%s 2>/dev/null || echo "")
  if [[ -n "${commit_ts}" ]]; then
    now_ts=$(date +%s)
    diff=$(( now_ts - commit_ts )); diff=${diff#-}
    if [[ ${diff} -gt ${TIME_THRESHOLD} ]]; then
      warn "Commit.md 记录已超时（${diff}s），使用默认信息"
      latest_commit=""
    fi
  fi
else
  latest_commit="${latest_commit_line}"
fi
[[ -z "${latest_commit}" ]] && latest_commit="${DEFAULT_MESSAGE}"
info "提交信息：${latest_commit}"

# 2.2 确认分支
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "${CURRENT_BRANCH}" != "${SOURCE_BRANCH}" ]]; then
  warn "当前在 ${CURRENT_BRANCH}，切换到 ${SOURCE_BRANCH}..."
  git checkout "${SOURCE_BRANCH}"
fi

# 2.3 拉取远程
info "拉取 origin/${SOURCE_BRANCH}..."
git pull --no-rebase --quiet origin "${SOURCE_BRANCH}" 2>&1 || warn "pull 失败，继续本地提交"

# 2.4 提交并推送
git add -A
if ! git diff --cached --quiet; then
  CHANGED=$(git diff --cached --stat | tail -n 1)
  info "变更：${CHANGED}"
  git commit --quiet -m "${latest_commit}"
  info "推送到 origin/${SOURCE_BRANCH}..."
  git push --quiet origin "${SOURCE_BRANCH}"
  info "源码提交完成"
else
  info "无文件变更，跳过提交"
fi
elapsed

# ========== 3. Hexo 生成并部署到 main 分支 ==========
step "3/3 Hexo 生成并部署到 main 分支"

# 3.1 增量生成（不跑 hexo clean，日常部署快很多）
#     如果改了主题配置/删了文章/样式异常，手动 hexo clean 后再跑本脚本
info "生成静态文件（hexo generate，增量）..."
t0=${SECONDS}
npx hexo generate 2>&1 | tail -5
elapsed

# 3.2 清 public 里的 macOS 元数据（防止被 deploy 带到 main 分支）
[ -d "public" ] && find public \( -name "._*" -o -name ".DS_Store" \) -delete 2>/dev/null || true

# 3.3 部署
info "部署到 GitHub main 分支（hexo deploy）..."
t0=${SECONDS}
npx hexo deploy 2>&1 | tail -5
elapsed

echo ""
info "🎉 全部完成！"
