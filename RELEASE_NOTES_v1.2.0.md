# v1.2.0 自定义 sub2api 地址版

GitHub 仓库地址：

https://github.com/boji1334/cc-switch-codex-setup

## 这次改了什么

- sub2api 接口地址不再写死为默认地址。
- 在线页面新增「sub2api 接口地址」输入框。
- 导入链接里的 `endpoint` 和 `homepage` 会使用用户自己填写的 sub2api 地址。
- Windows 脚本版会要求输入 sub2api 地址和 API Key。
- macOS 脚本版会要求输入 sub2api 地址和 API Key。
- README 和教程里的手动配置示例也改成自定义 sub2api 地址。

## 推荐使用方式

打开在线版：

https://boji1334.github.io/cc-switch-codex-setup/

使用顺序：

1. 点击「自动下载」安装 CC Switch。
2. 输入自己的 sub2api 接口地址。
3. 输入 API Key。
4. 点击「一键导入」。
5. 在 CC Switch 里确认导入并保存，然后重启 Codex。

## Release 文件

- `CCS-Codex-OneClick.html`：Windows/macOS/Ubuntu 通用图形化页面。
- `CCS-Codex-OneClick.zip`：包含 HTML、Windows 脚本和 macOS 脚本。
- `CCS-Codex-Setup-Windows.bat`：Windows 自动下载 + 自定义 sub2api 地址 + 导入脚本。
- `CCS-Codex-Setup-macOS.command`：macOS 自动下载 + 自定义 sub2api 地址 + 导入脚本。
