#!/bin/bash

# 脚本名称：setup_nonebot.sh
# 功能：一键安装 NoneBot2 环境及依赖
# 作者：你的名字
# 日期：$(date +%Y-%m-%d)

set -e  # 遇到错误自动退出脚本
set -o pipefail  # 确保管道命令的错误能被捕获

# 颜色定义（用于日志输出）
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1" >&2
    exit 1
}

# 1. 更新系统并安装基础工具
log_info "Updating system packages..."
apt update -y || log_warn "apt update failed (non-critical)"
apt install -y tmux vim curl wget tar ffmpeg git fonts-noto-cjk fonts-noto-color-emoji \
    || log_error "Failed to install system packages"

# 2. 克隆仓库
log_info "Cloning repositories..."
mkdir -p /opt/{none_bot,meme} || log_error "Failed to create directories"

clone_repo() {
    local repo_url=$1
    local target_dir=$2
    if [ -d "$target_dir/.git" ]; then
        log_warn "Repository already exists at $target_dir, skipping clone"
    else
        git clone "$repo_url" "$target_dir" || log_error "Failed to clone $repo_url"
    fi
}

clone_repo "https://github.com/anyliew/none_bot" "/opt/none_bot"
clone_repo "https://github.com/anyliew/meme_emoji" "/opt/meme/meme_emoji"
clone_repo "https://github.com/jinjiao007/meme-generator-jj" "/opt/meme/meme-generator-jj"
clone_repo "https://github.com/MemeCrafters/meme-generator-contrib" "/opt/meme/meme-generator-contrib"

# 3. 安装字体
log_info "Installing fonts..."
if [ -d "/opt/none_bot/myfonts/" ]; then
    mkdir -p /usr/share/fonts/myfonts/
    cp -r /opt/none_bot/myfonts/ /usr/share/fonts/ || log_error "Failed to copy fonts"
    fc-cache -fv || log_warn "Failed to update font cache (non-critical)"
else
    log_warn "Font directory /opt/none_bot/myfonts/ not found, skipping"
fi

# 4. 复制配置文件
log_info "Setting up config files..."
mkdir -p ~/.config/meme_generator
if [ -f "/opt/none_bot/config.toml" ]; then
    cp "/opt/none_bot/config.toml" ~/.config/meme_generator/ \
        || log_warn "Failed to copy config.toml"
else
    log_warn "Config file /opt/none_bot/config.toml not found, skipping"
fi

# 5. 安装Python依赖
log_info "Installing Python dependencies..."
if [ -f "/opt/none_bot/requirements.txt" ]; then
    pip install --upgrade pip || log_warn "Failed to upgrade pip (non-critical)"
    pip install -r /opt/none_bot/requirements.txt \
        || log_error "Failed to install Python dependencies"
else
    log_error "requirements.txt not found at /opt/none_bot/requirements.txt"
fi

log_info "All done! NoneBot2 environment is ready."