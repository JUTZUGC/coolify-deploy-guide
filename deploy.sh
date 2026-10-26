#!/usr/bin/env bash
set -euo pipefail
# Coolify 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://coolify.io/docs/installation
# 更新日期：2026-10-26
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }

mkdir -p .download
cd .download

[ "$(uname -s)" = "Linux" ] || { echo "Coolify 需要 Linux；Windows 请用 WSL2 或装到服务器"; exit 1; }
curl -fsSL https://cdn.coollabs.io/coolify/install.sh | sudo bash

echo ""
if command -v curl >/dev/null 2>&1; then
  echo "等待服务启动：http://127.0.0.1:8000"
  ready=0
  for _ in $(seq 1 30); do
    if curl -sS -o /dev/null "http://127.0.0.1:8000" 2>/dev/null; then ready=1; break; fi
    sleep 2
  done
  if [ "$ready" = "1" ]; then
    echo "服务已就绪"
  else
    echo "警告：60 秒内未探测到 http://127.0.0.1:8000，请手动打开确认或查看日志"
    exit 1
  fi
else
  echo "未检测到 curl，跳过启动探测；请手动访问 http://127.0.0.1:8000 确认"
fi
echo "安装完成：浏览器打开 http://127.0.0.1:8000（远程服务器换成对应 IP），首次访问注册管理员账号；云服务器记得放行 8000 端口"
echo "若结果异常或需要改配置，请参考官方文档：https://coolify.io/docs/installation"
