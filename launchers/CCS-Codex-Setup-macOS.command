#!/bin/zsh

clear
echo
echo "CC Switch Codex 一键配置"
echo "GitHub: https://github.com/boji1334/cc-switch-codex-setup"
echo

if [ ! -d "/Applications/CC Switch.app" ]; then
  echo "没有检测到 /Applications/CC Switch.app。"
  echo "正在下载官方最新版 macOS 安装包..."
  url="$(curl -s https://api.github.com/repos/farion1231/cc-switch/releases/latest | grep -oE 'https://[^"]+CC-Switch-[^"]+macOS\.dmg' | head -n 1)"
  if [ -z "$url" ]; then
    echo "未找到 macOS.dmg，即将打开官方下载页面。"
    open "https://github.com/farion1231/cc-switch/releases/latest"
    echo
    read "unused?按 Enter 退出..."
    exit 1
  fi
  file="$HOME/Downloads/$(basename "$url")"
  curl -L "$url" -o "$file"
  echo "下载完成，正在打开安装包：$file"
  open "$file"
  echo
  echo "请把 CC Switch 拖入 Applications 文件夹。安装完成后，再次运行本文件导入 Codex。"
  echo
  read "unused?按 Enter 退出..."
  exit 1
fi

printf "请输入 API Key: "
stty -echo
IFS= read -r KEY
stty echo
echo

if [ -z "$KEY" ]; then
  echo "API Key 不能为空。"
  echo
  read "unused?按 Enter 退出..."
  exit 1
fi

if command -v python3 >/dev/null 2>&1; then
  API_KEY="$(python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1], safe=""))' "$KEY")"
elif command -v node >/dev/null 2>&1; then
  API_KEY="$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$KEY")"
else
  API_KEY="$KEY"
fi

open "ccswitch://v1/import?resource=provider&app=codex&name=boji1334&endpoint=http%3A%2F%2F47.100.93.204%3A8080&apiKey=${API_KEY}&model=gpt-5-codex&homepage=http%3A%2F%2F47.100.93.204%3A8080&enabled=true"

echo
echo "已尝试打开 CC Switch，请在弹窗里确认导入。"
echo "导入后保存配置，并重启 Codex 终端或 CLI。"
echo
read "unused?按 Enter 退出..."
