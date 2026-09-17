# Agent Hub 路由 · homad 项目（填好的真实样例）

> 这是一份"填好"的样例，展示如何把薄路由骨架落到真实项目。
> homad = 药食同源产品开发平台（前端 Next.js / 后端 Java+PostgreSQL）。
> homad 托管在 GitHub（origin: lucky-Luor/homad），**GitLab 专用的 `ronan-*` skill 不适用**。

## 开工前 30 秒
1. 看 `tasks/_index.md` → 有没有在办任务
2. 有 → 读该任务 `handoff.md` → 按需回看 `status.md`
3. 无 → 按下表走，然后在 `tasks/_index.md` 登记新任务

## 任务类型 → 读哪一小节（homad 真实映射）
| 你要做 | 读 AGENTS.md 的 | 用 skill | 相关 memory |
|---|---|---|---|
| 改后端接口 / 业务规则 | §核心业务规则、§数据与安全 | java-env（沙箱 mvn/JAVA_HOME）| — |
| 数据库写入 / 建表 | §数据与安全 | java-env（PG 5432/5433 拓扑）| project_homad-db-write-constraints、project_homad-postgres-topology |
| 前端联调 / 页面 | §前端开发规范、§Mock 状态与交互 | webapp-testing / playwright | — |
| 排查 bug | — | systematic-debugging | — |
| 代码审查 | §测试与验收 | adversarial-review | — |
| 出文档 / 图 / 图片 | §文档维护 | pdf、archify、image-gen | — |
| 提交 / 推送（→ GitHub）| §文档维护 | 手动 git（非 GitLab，`ronan-*` 不用）| — |

## 验证钩子（自称"测试完成"不算数）
- 后端：沙箱里 `java-env` 激活后跑定向 `mvn -pl homad-backend test -Dtest=…`，命令+结果写进 `status.md`。
- 数据库写入：先看两条 PG memory（UUIDv7、resource_registry 触发器、contacts 禁明文、5433 会被整库 DROP），别在 5433 测试库写留存数据。
- 前端：`webapp-testing` 起本地页面核对，排除等待/动画/登录态再判缺陷。

## 持久层分工
- `AGENTS.md`（19KB，团队规范）/ `docs/`（知识库、PRD、方案）：权威、提交入库。
- `docs/plans/`：正式方案与里程碑（团队可见）。`status.md` 只链接过去。
- `.agent-hub/`：会话级临时状态与交接（gitignore、可删）。
- beatrice_memory：跨会话约束/偏好（已有 homad PG 两条 project 分片）。
