# CLAUDE.md — Claude Code 入口

> Claude Code 会自动读取项目根的本文件。这是"多智能体适配层"的 Claude 侧入口。
> Codex / 其它 Agent 请读同目录 `AGENTS.md` + `.agent-hub/GUIDE.md`（同一套路由，双入口）。
> 本文件是个人运行态（gitignore，可删），不是团队规范。

## 第一步：先读薄路由，别全量读 AGENTS.md
先读 `.agent-hub/GUIDE.md`（薄路由），按任务类型只读必要的 `AGENTS.md` 小节。
`AGENTS.md` 可能很大，全量读会造成"上下文过重"。

## 有在办任务？
`.agent-hub/tasks/_index.md` → 找到任务 → 读其 `handoff.md`（"从这接"）→ 按需回看 `status.md`。

## 权威边界
- `AGENTS.md` / `docs/`：人写的团队规范与正式方案（权威）。
- `.agent-hub/`：Agent 生成的临时状态与交接（个人、gitignore、可删），不获得规范权威。
- 完成任何任务后，把"改了什么（delta）+ 验证证据"写回该任务的 `status.md`，把"下一步 / 失败方案"写回 `handoff.md`。
