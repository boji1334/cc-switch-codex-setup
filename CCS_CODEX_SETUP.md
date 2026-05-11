# CC Switch Codex 配置教程

中文 | [English](#english-guide)

> 本教程用于在 Windows、macOS 和 Ubuntu 上安装 CC Switch，并把 Codex 配置到指定 API 服务。默认供应商名称为 `boji1334`，API Key 请填写我单独提供给你的 Key。

## 一键配置

如果你已经安装好 CC Switch，可以直接执行下面对应系统的命令。命令会让你输入 API Key，然后自动打开 CC Switch 的导入确认窗口。

### Windows

打开 PowerShell，粘贴执行：

```powershell
$Key = Read-Host "请输入 API Key"; $EncodedKey = [uri]::EscapeDataString($Key); $Url = "ccswitch://v1/import?resource=provider&app=codex&name=boji1334&endpoint=http%3A%2F%2F47.100.93.204%3A8080&apiKey=$EncodedKey&model=gpt-5-codex&homepage=http%3A%2F%2F47.100.93.204%3A8080&enabled=true"; Start-Process $Url
```

### macOS

打开 Terminal，粘贴执行：

```bash
printf "请输入 API Key: "
stty -echo
IFS= read -r KEY
stty echo
echo
if command -v python3 >/dev/null 2>&1; then
  API_KEY="$(python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1], safe=""))' "$KEY")"
elif command -v node >/dev/null 2>&1; then
  API_KEY="$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$KEY")"
else
  API_KEY="$KEY"
fi
open "ccswitch://v1/import?resource=provider&app=codex&name=boji1334&endpoint=http%3A%2F%2F47.100.93.204%3A8080&apiKey=${API_KEY}&model=gpt-5-codex&homepage=http%3A%2F%2F47.100.93.204%3A8080&enabled=true"
```

### Ubuntu

打开 Terminal，粘贴执行：

```bash
if ! command -v xdg-open >/dev/null 2>&1; then
  echo "缺少 xdg-open，请先执行：sudo apt install -y xdg-utils"
  exit 1
fi
printf "请输入 API Key: "
stty -echo
IFS= read -r KEY
stty echo
echo
if command -v python3 >/dev/null 2>&1; then
  API_KEY="$(python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1], safe=""))' "$KEY")"
elif command -v node >/dev/null 2>&1; then
  API_KEY="$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$KEY")"
else
  API_KEY="$KEY"
fi
xdg-open "ccswitch://v1/import?resource=provider&app=codex&name=boji1334&endpoint=http%3A%2F%2F47.100.93.204%3A8080&apiKey=${API_KEY}&model=gpt-5-codex&homepage=http%3A%2F%2F47.100.93.204%3A8080&enabled=true"
```

执行后会弹出 CC Switch 的导入确认窗口，确认导入即可。导入完成后，在 CC Switch 的 Codex 页面选择 `boji1334`，点击启用或保存，然后重启 Codex 终端/CLI。

以后如果要换供应商名称、接口地址或模型，也可以使用官方深度链接生成工具：

https://farion1231.github.io/cc-switch/deplink.html

## 安装 CC Switch

CC Switch 官方仓库：

https://github.com/farion1231/cc-switch

如果你还没有安装 CC Switch，请先按你的系统安装。

### Windows 安装

方式一：打开 Releases 页面，下载最新的 `Windows.msi` 安装包。

https://github.com/farion1231/cc-switch/releases/latest

方式二：PowerShell 一键下载并启动安装：

```powershell
$Release = Invoke-RestMethod "https://api.github.com/repos/farion1231/cc-switch/releases/latest"; $Asset = $Release.assets | Where-Object { $_.name -like "*Windows.msi" } | Select-Object -First 1; if (-not $Asset) { throw "未找到 Windows.msi，请手动打开 Releases 页面下载。" }; $Out = Join-Path $env:TEMP $Asset.name; Invoke-WebRequest $Asset.browser_download_url -OutFile $Out; Start-Process msiexec.exe -ArgumentList "/i `"$Out`"" -Wait
```

### macOS 安装

推荐使用 Homebrew：

```bash
brew tap farion1231/ccswitch
brew install --cask cc-switch
```

如果没有 Homebrew，也可以到 Releases 页面下载最新的 `macOS.dmg`：

https://github.com/farion1231/cc-switch/releases/latest

### Ubuntu 安装

一键下载最新 `.deb` 并安装：

```bash
set -e
sudo apt update
sudo apt install -y curl ca-certificates xdg-utils
arch="$(uname -m)"
case "$arch" in aarch64|arm64) arch="arm64" ;; *) arch="x86_64" ;; esac
tmp="$(mktemp -d)"
cd "$tmp"
url="$(curl -s https://api.github.com/repos/farion1231/cc-switch/releases/latest | grep -oE "https://[^\"]+CC-Switch-[^\"]+Linux-${arch}\.deb" | head -n 1)"
if [ -z "$url" ]; then
  echo "未找到 Linux ${arch} 安装包，请手动打开 Releases 页面下载。"
  exit 1
fi
curl -L "$url" -o cc-switch.deb
sudo apt install -y ./cc-switch.deb
```

如果命令失败，也可以手动打开 Releases 页面，下载最新的 `Linux-x86_64.deb` 或 `Linux-arm64.deb` 后执行：

```bash
sudo apt install ./CC-Switch-*-Linux-*.deb
```

## 手动配置方式

如果一键导入没有弹出窗口，可以手动添加。

1. 打开 CC Switch。
2. 切换到 Codex 页面。
3. 点击添加供应商或编辑供应商。
4. 按下面内容填写。

| 字段 | 填写内容 |
| --- | --- |
| 供应商名称 | `boji1334` |
| 官网链接 | `http://47.100.93.204:8080` |
| API Key | 我提供给你的 Key |
| API 请求地址 | `http://47.100.93.204:8080` |
| 模型名称 | `gpt-5-codex` |

`完整 URL` 开关保持关闭即可，除非你拿到的是已经包含 `/v1/responses` 的完整请求地址。

保存前可以对照配置内容。

### auth.json

```json
{
  "OPENAI_API_KEY": "这里填写我提供给你的 Key"
}
```

### config.toml

```toml
model_provider = "boji1334"
model = "gpt-5-codex"
model_reasoning_effort = "high"
disable_response_storage = true

[model_providers.boji1334]
name = "boji1334"
base_url = "http://47.100.93.204:8080"
wire_api = "responses"
requires_openai_auth = true
```

如果你修改了供应商名称，需要同时修改 `model_provider` 和 `[model_providers.xxx]` 中的名称，保持完全一致。

## 验证是否成功

1. 保存供应商配置。
2. 在 CC Switch 的 Codex 页面启用 `boji1334`。
3. 重启终端或 Codex CLI。
4. 运行一次 Codex，确认能正常请求模型。

如果提示 Key 错误，请检查 API Key 是否复制完整；如果提示连接失败，请检查网络是否能访问 `http://47.100.93.204:8080`。

## 小提示

API Key 属于敏感信息，不要发到公开群、Issue、截图或 GitHub 仓库里。深度链接里也会包含 Key，只建议在你信任的设备上使用。

觉得这个教程有用的话，欢迎顺手给我的 GitHub 点个 Star，哈哈哈。

---

# English Guide

[中文](#cc-switch-codex-配置教程) | English

> This guide helps you install CC Switch on Windows, macOS, or Ubuntu and configure Codex with the provided API service. The default provider name is `boji1334`. Use the API Key I provide separately.

## One-Command Setup

If CC Switch is already installed, run the command for your operating system. It will ask for your API Key and open the CC Switch import confirmation window automatically.

### Windows

Open PowerShell and run:

```powershell
$Key = Read-Host "Enter API Key"; $EncodedKey = [uri]::EscapeDataString($Key); $Url = "ccswitch://v1/import?resource=provider&app=codex&name=boji1334&endpoint=http%3A%2F%2F47.100.93.204%3A8080&apiKey=$EncodedKey&model=gpt-5-codex&homepage=http%3A%2F%2F47.100.93.204%3A8080&enabled=true"; Start-Process $Url
```

### macOS

Open Terminal and run:

```bash
printf "Enter API Key: "
stty -echo
IFS= read -r KEY
stty echo
echo
if command -v python3 >/dev/null 2>&1; then
  API_KEY="$(python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1], safe=""))' "$KEY")"
elif command -v node >/dev/null 2>&1; then
  API_KEY="$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$KEY")"
else
  API_KEY="$KEY"
fi
open "ccswitch://v1/import?resource=provider&app=codex&name=boji1334&endpoint=http%3A%2F%2F47.100.93.204%3A8080&apiKey=${API_KEY}&model=gpt-5-codex&homepage=http%3A%2F%2F47.100.93.204%3A8080&enabled=true"
```

### Ubuntu

Open Terminal and run:

```bash
if ! command -v xdg-open >/dev/null 2>&1; then
  echo "Missing xdg-open. Run first: sudo apt install -y xdg-utils"
  exit 1
fi
printf "Enter API Key: "
stty -echo
IFS= read -r KEY
stty echo
echo
if command -v python3 >/dev/null 2>&1; then
  API_KEY="$(python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1], safe=""))' "$KEY")"
elif command -v node >/dev/null 2>&1; then
  API_KEY="$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$KEY")"
else
  API_KEY="$KEY"
fi
xdg-open "ccswitch://v1/import?resource=provider&app=codex&name=boji1334&endpoint=http%3A%2F%2F47.100.93.204%3A8080&apiKey=${API_KEY}&model=gpt-5-codex&homepage=http%3A%2F%2F47.100.93.204%3A8080&enabled=true"
```

After the confirmation window opens, confirm the import. Then select `boji1334` in the Codex page, enable or save it, and restart your Codex terminal/CLI.

If you need to change the provider name, endpoint, or model later, you can also use the official deep link generator:

https://farion1231.github.io/cc-switch/deplink.html

## Install CC Switch

Official repository:

https://github.com/farion1231/cc-switch

### Windows

Option 1: Download the latest `Windows.msi` installer from Releases:

https://github.com/farion1231/cc-switch/releases/latest

Option 2: Download and start the installer from PowerShell:

```powershell
$Release = Invoke-RestMethod "https://api.github.com/repos/farion1231/cc-switch/releases/latest"; $Asset = $Release.assets | Where-Object { $_.name -like "*Windows.msi" } | Select-Object -First 1; if (-not $Asset) { throw "Could not find Windows.msi. Please download it manually from Releases." }; $Out = Join-Path $env:TEMP $Asset.name; Invoke-WebRequest $Asset.browser_download_url -OutFile $Out; Start-Process msiexec.exe -ArgumentList "/i `"$Out`"" -Wait
```

### macOS

Recommended Homebrew installation:

```bash
brew tap farion1231/ccswitch
brew install --cask cc-switch
```

Without Homebrew, download the latest `macOS.dmg` from Releases:

https://github.com/farion1231/cc-switch/releases/latest

### Ubuntu

Download and install the latest `.deb` package:

```bash
set -e
sudo apt update
sudo apt install -y curl ca-certificates xdg-utils
arch="$(uname -m)"
case "$arch" in aarch64|arm64) arch="arm64" ;; *) arch="x86_64" ;; esac
tmp="$(mktemp -d)"
cd "$tmp"
url="$(curl -s https://api.github.com/repos/farion1231/cc-switch/releases/latest | grep -oE "https://[^\"]+CC-Switch-[^\"]+Linux-${arch}\.deb" | head -n 1)"
if [ -z "$url" ]; then
  echo "Could not find the Linux ${arch} installer. Please download it manually from Releases."
  exit 1
fi
curl -L "$url" -o cc-switch.deb
sudo apt install -y ./cc-switch.deb
```

If that fails, manually download the latest `Linux-x86_64.deb` or `Linux-arm64.deb` file from Releases and run:

```bash
sudo apt install ./CC-Switch-*-Linux-*.deb
```

## Manual Setup

If the one-command import does not open, add the provider manually.

1. Open CC Switch.
2. Switch to the Codex page.
3. Click Add Provider or Edit Provider.
4. Fill in the fields below.

| Field | Value |
| --- | --- |
| Provider Name | `boji1334` |
| Website | `http://47.100.93.204:8080` |
| API Key | The Key I provide |
| API Endpoint | `http://47.100.93.204:8080` |
| Model | `gpt-5-codex` |

Keep the `Full URL` toggle off unless your endpoint already includes `/v1/responses`.

### auth.json

```json
{
  "OPENAI_API_KEY": "Paste the API Key here"
}
```

### config.toml

```toml
model_provider = "boji1334"
model = "gpt-5-codex"
model_reasoning_effort = "high"
disable_response_storage = true

[model_providers.boji1334]
name = "boji1334"
base_url = "http://47.100.93.204:8080"
wire_api = "responses"
requires_openai_auth = true
```

If you change the provider name, make sure `model_provider` and `[model_providers.xxx]` match exactly.

## Verify

1. Save the provider.
2. Enable `boji1334` on the Codex page.
3. Restart your terminal or Codex CLI.
4. Run Codex once and confirm it can request the model normally.

If you see an API Key error, check whether the Key was copied completely. If you see a connection error, check whether your network can access `http://47.100.93.204:8080`.

## Note

API Keys are sensitive. Do not publish them in chat groups, Issues, screenshots, or GitHub repositories. Deep links also contain the Key, so use them only on trusted devices.

If this guide helps, feel free to give my GitHub a Star. Thanks!
