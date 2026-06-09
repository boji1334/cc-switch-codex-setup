@echo off
chcp 65001 >nul
setlocal
title CC Switch Codex Setup

echo.
echo CC Switch Codex 一键配置
echo GitHub: https://github.com/boji1334/cc-switch-codex-setup
echo.
echo 请先确认已经安装 CC Switch。
echo 如果没有安装，脚本会自动下载并启动官方最新版安装包。
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "if (-not (Test-Path 'Registry::HKEY_CLASSES_ROOT\ccswitch')) { Write-Host '未检测到 CC Switch，正在下载官方最新版 Windows 安装包...'; $release=Invoke-RestMethod 'https://api.github.com/repos/farion1231/cc-switch/releases/latest'; $asset=$release.assets | Where-Object { $_.name -like '*Windows.msi' } | Select-Object -First 1; if (-not $asset) { throw '未找到 Windows.msi，请手动打开 Releases 页面下载。' }; $out=Join-Path $env:TEMP $asset.name; Invoke-WebRequest $asset.browser_download_url -OutFile $out; Write-Host '下载完成，正在启动安装程序...'; Start-Process msiexec.exe -ArgumentList ('/i \"' + $out + '\"') -Wait; if (-not (Test-Path 'Registry::HKEY_CLASSES_ROOT\ccswitch')) { Start-Process 'https://github.com/farion1231/cc-switch/releases/latest'; Write-Host '安装后仍未检测到 ccswitch:// 协议。请确认 CC Switch 已安装，然后重新运行本文件。'; exit 2 } }"
if errorlevel 1 (
  echo 自动安装 CC Switch 没有完成，请先安装后再运行本文件。
  goto end
)

set /p "CCS_ENDPOINT=请输入 sub2api 接口地址，例如 http://127.0.0.1:8080，然后按 Enter: "
if "%CCS_ENDPOINT%"=="" (
  echo sub2api 接口地址不能为空。
  goto end
)

set /p "CCS_API_KEY=请输入 API Key，然后按 Enter: "
if "%CCS_API_KEY%"=="" (
  echo API Key 不能为空。
  goto end
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "$key=$env:CCS_API_KEY; $endpoint=($env:CCS_ENDPOINT).Trim().TrimEnd('/'); if ($endpoint -notmatch '^https?://') { Write-Host 'sub2api 接口地址需要以 http:// 或 https:// 开头。'; exit 2 }; $params=[ordered]@{resource='provider';app='codex';name='boji1334cat';endpoint=$endpoint;apiKey=$key;model='gpt-5.5';homepage=$endpoint;enabled='true'}; $query=($params.GetEnumerator() | ForEach-Object { [uri]::EscapeDataString($_.Key) + '=' + [uri]::EscapeDataString([string]$_.Value) }) -join '&'; Start-Process ('ccswitch://v1/import?' + $query)"
if errorlevel 1 goto end

echo.
echo 已尝试打开 CC Switch，请在弹窗里确认导入。
echo 导入后保存配置，并重启 Codex 终端或 CLI。

:end
echo.
pause
