# Coolify 一键部署指南

> 第三方部署指南 · 非 Coolify 官方仓库。官方项目：[coollabsio/coolify](https://github.com/coollabsio/coolify)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://coolify.io/docs/installation)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不用自己装 Docker、配反向代理，让百度搭子跑一遍官方脚本，打开面板就能部署应用。

⚠️ 需要一台 Linux 服务器（Ubuntu LTS 可直接用自动脚本，其它发行版走手动安装），建议至少 2 核 / 2 GB 内存 / 30 GB 磁盘。Windows 请用 WSL2 或直接装到服务器。安装需要 sudo / root。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/coolify-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会先确认是 Linux 环境，再运行官方安装脚本；装完会打印面板地址，首次访问注册管理员，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）

4. **打开管理面板**
   浏览器访问 [http://127.0.0.1:8000](http://127.0.0.1:8000)，按官方引导完成初始化配置。

## Coolify 是什么？

Coolify 是开源的开源自托管的 PaaS（Vercel / Heroku 替代）（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/coollabsio/coolify?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把一台服务器变成自己的部署平台：从 Git 仓库构建应用、跑数据库与 360+ 一键服务、自动 HTTPS、Git push 自动部署、备份与多服务器管理；面板、API、CLI 与 MCP 都能操作。

- 部署方式：GitHub / GitLab / Bitbucket / Gitea + Nixpacks / Railpack / Dockerfile / Compose / 现成镜像
- 一键服务：360+ 服务与托管数据库，自动生成凭据与持久化存储
- 运维能力：自定义域名、自动 HTTPS、反向代理、健康检查、备份、多服务器
- 访问方式：面板、API、CLI、MCP

（来源：[官方仓库](https://github.com/coollabsio/coolify)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 65.1k stars | Apache-2.0 开源，更新活跃（v4.5.1） |
| 部署能力强 | Git 自动构建、Dockerfile / Compose、360+ 一键服务 |
| 开箱有 HTTPS | 自定义域名、证书、反向代理都内置 |
| 不止面板 | API、CLI、MCP 都能管理资源 |
| 数据在本地 | 配置和项目都在自己的服务器上 |

| 需要注意 | 说明 |
|---|---|
| 需要 Linux 服务器 | Windows 用户要备服务器或 WSL2 |
| 有最低配置要求 | 官方建议 2 核 / 2 GB / 30 GB 起 |
| 安装要 root | 脚本用 sudo 执行，云主机最好用干净机器 |
| 自动脚本只认 Ubuntu LTS | 其它发行版得手动安装 |
| 服务较重 | 面板本身也占资源，小内存机器容易吃紧 |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 快速部署（官方方式）

```bash
[ "$(uname -s)" = "Linux" ] || { echo "Coolify 需要 Linux；Windows 请用 WSL2 或装到服务器"; exit 1; }
curl -fsSL https://cdn.coollabs.io/coolify/install.sh | sudo bash
```

启动后浏览器访问 [http://127.0.0.1:8000](http://127.0.0.1:8000)（管理面板）。（来源：[https://coolify.io/docs/installation](https://coolify.io/docs/installation)）

## 验证状态

| 场景 | 状态 |
|---|---|
| 官方安装脚本可访问（HTTP 200，text/plain） | 已核对 2026-10-26 |
| 本机为 Windows，安装流程未实测 | 已核对 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

Coolify 提供 MCP 集成，可让 Agent 通过 MCP 管理资源；具体配置以官方文档为准。本仓库的 MCP 只提供安装步骤、服务器要求与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\coolify-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

1. 打开 `http://<服务器IP>:8000`，按提示创建第一个管理员账号
2. 新建 Project → 连接 Git 仓库或选一个一键服务，Coolify 会自动构建并分配域名
3. 云服务器要在安全组放行 8000（面板）以及后续应用的端口
4. 官方建议：Coolify 与部署的应用分开放在不同服务器上更稳

> 自动安装脚本只支持 Ubuntu LTS（20.04 / 22.04 / 24.04）；其它发行版需要按官方文档手动安装。

## 常见坑

- 安装脚本要求 root：用有 sudo 权限的账号，或直接 root 执行
- Ubuntu 非 LTS 版本自动脚本不支持：按官方文档手动安装
- 装完打不开面板：云服务器安全组放行 8000 端口，本机防火墙也要放行
- 面板地址用的是 127.0.0.1：远程服务器要换成公网 IP 或域名
- 内存不足会安装失败：低于 2 GB 的机器建议先加 swap 或换机器
- 不要在已有业务的服务器上直接装：官方建议用干净机器，避免端口与容器冲突
- 想长期用建议配好备份与更新策略，面板本身也要跟着升级

## 免责声明

本仓库为第三方指南，与 Coolify 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://coolify.io/docs/installation)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
