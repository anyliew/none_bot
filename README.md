# NoneBot


## linux apt install

```
apt update -y && apt upgrade -y
apt install tmux vim curl wget tar ffmpeg git fonts-noto-cjk fonts-noto-color-emoji -y
```



## Git download

```
git clone https://github.com/anyliew/none_bot /opt/none_bot/
git clone https://github.com/anyliew/meme_emoji /opt/meme_emoji/
```



## Linux fonts

```

cp -r /opt/none_bot/myfonts/ /usr/share/fonts/myfonts/
fc-cache -fv
```


## Meme config

```
mkdir -pv ~/.config/meme_generator
cp /opt/none_bot/config.toml ~/.config/meme_generator
```



## How to install 

```
python3 -m venv /opt/python
source /opt/python/bin/activate
python3 -m pip install --upgrade pip
pip install -r /opt/none_bot/requirements.txt
```

