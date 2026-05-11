# v1.1.0 小白自动下载版

GitHub 仓库地址：

https://github.com/boji1334/cc-switch-codex-setup

## 这次改了什么

- 去掉了大头像展示，页面更干净，不会一打开就被图片占满。
- 新增「自动下载 CC Switch」按钮，会识别 Windows、macOS 或 Ubuntu，并下载官方最新版安装包。
- Windows 脚本版会在未安装 CC Switch 时自动下载并启动 `.msi` 安装包。
- macOS 脚本版会在未安装 CC Switch 时自动下载并打开 `.dmg` 安装包。

## 推荐使用方式

最推荐直接打开在线版：

https://boji1334.github.io/cc-switch-codex-setup/

使用顺序：

1. 点击「自动下载」安装 CC Switch。
2. 回到页面输入 API Key。
3. 点击「一键导入」。
4. 在 CC Switch 里确认导入并保存，然后重启 Codex。

## Release 文件

- `CCS-Codex-OneClick.html`：Windows/macOS/Ubuntu 通用图形化页面。
- `CCS-Codex-OneClick.zip`：包含 HTML、Windows 脚本和 macOS 脚本。
- `CCS-Codex-Setup-Windows.bat`：Windows 自动下载 + 导入脚本。
- `CCS-Codex-Setup-macOS.command`：macOS 自动下载 + 导入脚本。
