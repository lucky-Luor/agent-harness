# agent-harness

个人可复用的 **Agent Harness**：给多智能体（Claude Code ↔ Codex）编码工作流补一层
**任务状态 + 跨会话交接 + 薄路由**，解决"上下文过重、换会话/换 Agent 全靠重述"的问题。

> 这是母版仓库。任意项目 `clone` 下来跑一次 `install.sh`，即可把这套装进去复用。
> 它**不替代** `AGENTS.md`（团队规范层），只补最后一层"状态 + 交接"。

## 解决什么问题
参考业界诊断：AI 编码的主要矛盾不是系统 bug，而是**上下文过重**（有 30–40% 优化空间）。表现：
- 规范文档越堆越大，每个任务全量读 → token 飙升；
- 跨会话 / 从 Codex 切 Claude 无交接，全靠重述；
- "任务干到哪了""哪些坑已踩过"没有落脚点。

## 设计原则（每条对应一个已验证来源）
| 原则 | 来源 |
|---|---|
| 薄路由 + 渐进式披露（读尽可能少的正确信息） | 视频教训 / Cline Memory Bank "开头读全部不 scale" |
| 人写规范 vs Agent 笔记**物理隔离** | Agent OS 分层 |
| delta 而非全量重述 | OpenSpec |
| 交接含"失败方案"栏（别再走回头路） | ai-memory（Cline 版缺此栏） |
| 自称完成不算数，要留验证证据 | 视频教训 |

## 目录结构
```
agent-harness/
├── install.sh                       # 一键装进目标项目
├── templates/
│   ├── .agent-hub/                  # 拷进目标项目的个人工作区
│   │   ├── GUIDE.md                 # 薄路由骨架(占位符)
│   │   ├── tasks/_index.md          # 活动任务一览
│   │   └── templates/              # status/handoff 模板
│   └── CLAUDE.md                    # 目标项目根的 Claude 入口
├── examples/homad-GUIDE.md          # 一份填好的真实样例
└── docs/技术方案.md                  # 完整设计方案
```

装进目标项目后会长这样（`.agent-hub/` 与 `CLAUDE.md` 均被 gitignore）：
```
<你的项目>/
├── AGENTS.md            # 团队规范(原有, 不动)
├── CLAUDE.md            # Claude 入口(个人, gitignore)
└── .agent-hub/          # 个人任务状态 + 交接(gitignore)
```

## 安装
```bash
git clone https://github.com/lucky-Luor/agent-harness.git
cd agent-harness
./install.sh /path/to/你的项目       # 拷入 .agent-hub/ + CLAUDE.md, 并追加其 .gitignore
```
装完后编辑目标项目的 `.agent-hub/GUIDE.md`，把"任务类型 → 读哪节 AGENTS.md / 用哪个 skill / 哪条 memory"填成本项目的真实映射（参考 `examples/homad-GUIDE.md`）。

## 日常用法
1. 开工先读 `CLAUDE.md` → `.agent-hub/GUIDE.md`（薄路由），按任务类型只读必要的 `AGENTS.md` 小节。
2. 有在办任务：`.agent-hub/tasks/_index.md` → 该任务 `handoff.md`（"从这接"）。
3. 干活中：改了什么（delta）+ 验证证据写进 `status.md`；下一步 / 失败方案写进 `handoff.md`。

## 后续升级：ai-memory（自动化交接）
手搓 markdown 版跑顺后，可试装 [ai-memory](https://github.com/akitaonrails/ai-memory)
把状态交接自动化（Claude Code 与 Codex 都是一等公民，支持零 LLM 模式）。
三步试装清单见 `templates/.agent-hub/GUIDE.md` 末尾。

## 设计详情
见 [`docs/技术方案.md`](docs/技术方案.md)。
