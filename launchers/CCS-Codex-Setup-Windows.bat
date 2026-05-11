@echo off
chcp 65001 >nul
setlocal
title CC Switch Codex Setup

echo.
echo CC Switch Codex 一键配置
echo GitHub: https://github.com/boji1334/cc-switch-codex-setup
echo.
echo 请先确认已经安装 CC Switch。
echo 如果没有安装，脚本会打开官方下载页面。
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "if (-not (Test-Path 'Registry::HKEY_CLASSES_ROOT\ccswitch')) { Start-Process 'https://github.com/farion1231/cc-switch/releases/latest'; Write-Host '未检测到 ccswitch:// 协议。请先安装 CC Switch，安装完成后再运行本文件。'; exit 2 }"
if errorlevel 2 goto end

set /p "CCS_API_KEY=请输入 API Key，然后按 Enter: "
if "%CCS_API_KEY%"=="" (
  echo API Key 不能为空。
  goto end
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "$key=$env:CCS_API_KEY; $params=[ordered]@{resource='provider';app='codex';name='boji1334';endpoint='http://47.100.93.204:8080';apiKey=$key;model='gpt-5-codex';homepage='http://47.100.93.204:8080';enabled='true'}; $query=($params.GetEnumerator() | ForEach-Object { [uri]::EscapeDataString($_.Key) + '=' + [uri]::EscapeDataString([string]$_.Value) }) -join '&'; Start-Process ('ccswitch://v1/import?' + $query)"

echo.
echo 已尝试打开 CC Switch，请在弹窗里确认导入。
echo 导入后保存配置，并重启 Codex 终端或 CLI。

:end
echo.
pause
