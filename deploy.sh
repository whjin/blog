#!/usr/bin/env bash
#
# Blog 一键部署脚本
# 流程：
#   1. 清理 macOS 元数据（._* AppleDouble / .DS_Store）——exFAT 移动硬盘上 git 报
#      "non-monotonic index .git/objects/pack/._pack-*.idx" 的根因
#   2. 读取 Commit.md，提交源码到 dev 分支并 push
#   3. hexo clean → generate → deploy，把静态站推到 GitHub main 分支
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
TIME_THRESHOLD=600  # 提交信息有效期 10 分钟（秒），超时则回退默认信息

# ========== 颜色 ==========
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
step()  { echo -e "\n${BLUE}========== $1 ==========${NC}"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ========== 0. 前置检查 ==========
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  error "当前目录不是 Git 仓库：${SCRIPT_DIR}"
  exit 1
fi

if [ ! -d "./node_modules/hexo" ]; then
  error "未安装依赖，请先执行：pnpm install"
  exit 1
fi

# ========== 1. 清理 macOS 冗余元数据 ==========
step "1/3 清理 macOS 元数据（._* / .DS_Store）"

# 工作区（排除 node_modules / .git，避免遍历耗时）
clean_wt=$(find . \( -name "._*" -o -name ".DS_Store" \) \
  -not -path "./node_modules/*" -not -path "./.git/*" \
  -print -delete 2>/dev/null | wc -l | tr -d ' ' || echo 0)

# .git 内部（non-monotonic index 的直接原因）
clean_git=$(find .git -name "._*" -print -delete 2>/dev/null | wc -l | tr -d ' ' || echo 0)

# .deploy_git（hexo deploy 的缓存仓库）和 themes 嵌套仓库
[ -d ".deploy_git" ] && find .deploy_git \( -name "._*" -o -name ".DS_Store" \) -print -delete 2>/dev/null >/dev/null || true
[ -d "themes" ]      && find themes -name "._*" -print -delete 2>/dev/null >/dev/null || true

total=$((clean_wt + clean_git))
if [ "${total}" -gt 0 ]; then
  info "已清理 ${total} 个 macOS 元数据文件"
else
  info "无冗余元数据"
fi

# ========== 2. 提交源码到 dev 分支 ==========
step "2/3 提交源码到 ${SOURCE_BRANCH} 分支"

# 2.1 读取 Commit.md（兼容旧格式：第一行可带 YYYY-MM-DD HH:MM:SS 时间戳）
[ -f "${COMMIT_FILE}" ] || touch "${COMMIT_FILE}"
latest_commit_line=$(sed '/^[[:space:]]*$/d' "${COMMIT_FILE}" | head -n 1 || true)
commit_timestamp_str=$(echo "${latest_commit_line}" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' || true)

if [[ -n "${commit_timestamp_str}" ]]; then
  latest_commit=$(echo "${latest_commit_line}" | sed "s/^${commit_timestamp_str}//" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
  # macOS BSD date 解析时间戳；超时则丢弃该提交信息
  commit_ts=$(date -j -f "%Y-%m-%d %H:%M:%S" "${commit_timestamp_str}" +%s 2>/dev/null || echo "")
  if [[ -n "${commit_ts}" ]]; then
    now_ts=$(date +%s)
    diff=$(( now_ts - commit_ts )); diff=${diff#-}
    if [[ ${diff} -gt ${TIME_THRESHOLD} ]]; then
      warn "Commit.md 记录已超时（${diff}s > ${TIME_THRESHOLD}s），使用默认信息"
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

# 2.3 拉取远程（已清过 .git 内 ._*，不会再 non-monotonic index）
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

# ========== 3. Hexo 生成并部署到 main 分支 ==========
step "3/3 Hexo 生成并部署到 main 分支"

info "清理 Hexo 缓存（hexo clean）..."
npx hexo clean 2>&1 | tail -3

info "生成静态文件（hexo generate）..."
npx hexo generate 2>&1 | tail -5

# 生成后再清一次 public 里的元数据，避免被 deploy 带到 main 分支
[ -d "public" ] && find public \( -name "._*" -o -name ".DS_Store" \) -delete 2>/dev/null || true

info "部署到 GitHub main 分支（hexo deploy）..."
npx hexo deploy 2>&1 | tail -5

echo ""
info "🎉 全部完成！"
