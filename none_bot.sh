#!/bin/bash

# NoneBot 一键安装脚本
# 作者anyliew
# 使用方法：chmod +x install_nonebot.sh && sudo ./install_nonebot.sh

set -e  # 遇到错误立即退出

echo "=== 开始安装 NoneBot ==="

# 1. 系统更新及基础依赖安装
echo ">> 正在更新系统并安装依赖..."
apt update -y && apt upgrade -y
apt install -y tmux vim curl wget tar ffmpeg git fonts-noto-cjk fonts-noto-color-emoji

# 2. 克隆代码仓库
echo ">> 正在克隆代码仓库..."

git clone https://github.com/anyliew/none_bot /opt/none_bot/
git clone https://github.com/anyliew/meme_emoji /opt/meme_emoji/

# 3. 安装字体
echo ">> 正在安装字体..."
cp -r /opt/none_bot/myfonts/ /usr/share/fonts/myfonts/
fc-cache -fv

# 4. 配置 Meme Generator
echo ">> 配置 Meme Generator..."
mkdir -pv ~/.config/meme_generator
cp /opt/none_bot/config.toml ~/.config/meme_generator/

# 5. 创建 Python 虚拟环境并安装依赖
echo ">> 正在设置 Python 环境..."
python3 -m venv /opt/python
source /opt/python/bin/activate
python3 -m pip install --upgrade pip
pip install -r /opt/none_bot/requirements.txt

echo "=== 安装完成！ ==="
echo "请手动激活虚拟环境：source /opt/python/bin/activate"
echo "然后运行 NoneBot 项目"
echo "nb run"