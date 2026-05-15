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

printf "请输入 sub2api 接口地址，例如 http://127.0.0.1:8080: "
IFS= read -r ENDPOINT

if [ -z "$ENDPOINT" ]; then
  echo "sub2api 接口地址不能为空。"
  echo
  read "unused?按 Enter 退出..."
  exit 1
fi

while [[ "$ENDPOINT" == */ ]]; do
  ENDPOINT="${ENDPOINT%/}"
done

if [[ "$ENDPOINT" != http://* && "$ENDPOINT" != https://* ]]; then
  echo "sub2api 接口地址需要以 http:// 或 https:// 开头。"
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
  API_ENDPOINT="$(python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1], safe=""))' "$ENDPOINT")"
elif command -v node >/dev/null 2>&1; then
  API_KEY="$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$KEY")"
  API_ENDPOINT="$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$ENDPOINT")"
else
  API_KEY="$KEY"
  API_ENDPOINT="${ENDPOINT//:/%3A}"
  API_ENDPOINT="${API_ENDPOINT//\//%2F}"
fi

open "ccswitch://v1/import?resource=provider&app=codex&name=boji1334cat&endpoint=${API_ENDPOINT}&apiKey=${API_KEY}&model=gpt-5.3-codex&homepage=${API_ENDPOINT}&enabled=true"

echo
echo "已尝试打开 CC Switch，请在弹窗里确认导入。"
echo "导入后保存配置，并重启 Codex 终端或 CLI。"
echo
read "unused?按 Enter 退出..."
