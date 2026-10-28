# Coolify 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://coolify.io/docs/installation
# 更新日期：2026-10-28
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

throw 'Coolify 需要 Linux 服务器；Windows 请先在 WSL2 或远程服务器上执行本指南'

Write-Host ''
$url = 'http://127.0.0.1:8000'
Write-Host "等待服务启动：$url"
$ready = $false
for ($i = 0; $i -lt 30; $i++) {
  try {
    Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec 3 | Out-Null
    $ready = $true
    break
  } catch {
    Start-Sleep -Seconds 2
  }
}
if (-not $ready) { throw "60 秒内未探测到 $url，请手动打开确认或查看日志" }
Write-Host '服务已就绪'
Write-Host '安装完成：浏览器打开 http://127.0.0.1:8000（远程服务器换成对应 IP），首次访问注册管理员账号；云服务器记得放行 8000 端口'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://coolify.io/docs/installation'
