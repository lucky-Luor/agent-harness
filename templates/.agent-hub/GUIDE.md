# Agent Hub 路由(先读这里，别全量读 AGENTS.md)

> 这是薄路由：只给"这类任务去读哪一小节 + 用哪个 skill"的指针，不复制内容。
> 目标是"读尽可能少的正确信息"，而不是每次全量 load `AGENTS.md`。
> 本文件是个人运行态（gitignore，可随时删）。团队权威规范在 `AGENTS.md`。

## 开工前 30 秒
1. 看 `tasks/_index.md` → 有没有在办任务
2. 有 → 读该任务 `handoff.md`（"从这接"）→ 按需回看 `status.md`
3. 无 → 按下面"任务类型 → 读什么"走，然后在 `tasks/_index.md` 登记新任务

## 任务类型 → 读哪一小节（填成你项目的真实映射）
| 你要做 | 读 AGENTS.md 的 | 用 skill | 相关 memory |
|---|---|---|---|
| <改后端/接口> | §<小节名> | <skill-name> | <memory-name> |
| <数据库写入> | §<小节名> | <skill-name> | <memory-name> |
| <前端联调> | §<小节名> | <skill-name> | — |
| <代码审查> | §<小节名> | <skill-name> | — |
| <提交/推送> | — | <skill-name> | — |

> 参考 `agent-harness/examples/homad-GUIDE.md` 看一份填好的真实样例。

## 验证钩子（AI 自称"测试完成"不算数）
- 跑真实定向测试/命令，把**命令 + 结果**写进对应任务的 `status.md` 验证证据栏。
- 未留证据的"已完成"不作为切换会话/交接的依据。

## 持久层分工（不要互相重复）
- `AGENTS.md` / `docs/`：人写的团队规范与正式方案（提交入库、权威）。
- `.agent-hub/`：会话级临时状态、交接、私人薄路由（gitignore、可删）。
- beatrice_memory：跨会话的偏好/决策/项目约束（结构化、持久）。
- `status.md` 只**链接**到正式方案文档，不把方案内容抄进来。

---

## 可选升级：ai-memory 自动化交接（D3，后续再做）
手搓 markdown 版跑顺后，若想让 Codex↔Claude 交接自动化，试装 [ai-memory](https://github.com/akitaonrails/ai-memory)：
1. 在一个 throwaway 分支上按其 README 注册 MCP + 生命周期 hook（Claude Code 与 Codex 都是一等公民）。
2. 开"零 LLM 模式"（纯全文检索，不烧 token、不需要 key）先验证。
3. 在 Claude Code 里干到一半退出，同目录起 Codex，看它第一个 prompt 前能否读到"你上次干到哪"。顺手就把状态交接交给它自动跑，`.agent-hub/` 只留薄路由 + 模板。
