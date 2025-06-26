# NoneBot


## linux apt install

```bash
apt update -y && apt upgrade -y
apt install tmux vim curl wget tar ffmpeg git fonts-noto-cjk fonts-noto-color-emoji -y
```



## Git download

```bash
git clone https://github.com/anyliew/none_bot /opt/none_bot/
git clone https://github.com/anyliew/meme_emoji /opt/meme/meme_emoji/
https://github.com/jinjiao007/meme-generator-jj /opt/meme/meme-generator-jj/
git clone https://github.com/MemeCrafters/meme-generator-contrib /opt/meme/meme-generator-contrib/
```



## Linux fonts

```bash

cp -r /opt/none_bot/myfonts/ /usr/share/fonts/myfonts/
fc-cache -fv
```


## Meme config

```bash
mkdir -pv ~/.config/meme_generator
cp /opt/none_bot/config.toml ~/.config/meme_generator
```



## How to install 

```bash
python3 -m venv /opt/python
source /opt/python/bin/activate
python3 -m pip install --upgrade pip
pip install -r /opt/none_bot/requirements.txt
```



## bash shell

```bash
chmod +x install_nonebot.sh && sudo ./install_nonebot.sh
```

