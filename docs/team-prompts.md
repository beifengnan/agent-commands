# Anthropic 官方整理的团队常用提示词（中文版）

来源：Anthropic 官方《[Claude Code power user tips](https://support.claude.com/en/articles/14554000-claude-code-power-user-tips)》，内容整理自 Claude Code 团队工程师的日常工作流。下面是中文翻译和用法说明。

标注了 **命令** 的条目，本仓库已经做成斜杠命令，安装后可以直接用。

## 新模型上线时

| 原文 | 中文 | 本仓库命令 |
|---|---|---|
| Read this entire project and find everything that's broken, inconsistent, inefficient, or no longer needed. Fix what you're sure about and list the rest for me to review. | 通读整个项目，找出所有坏掉的、不一致的、低效的、已经不需要的东西。有把握的就修掉，其余的列出来给我审。 | **命令** `/audit` |

> 来自 Anthropic 的 Alex Albert：每次有新模型，他都会在自己所有项目上跑这一句。（[原帖](https://x.com/alexalbert__/status/2119884951550386671)）

## 写提示词的技巧

| 原文 | 中文 | 用途 | 本仓库命令 |
|---|---|---|---|
| Grill me on these changes and don't make a PR until I pass your test. | 就这些改动来考我，我没通过你的考核之前不要提 PR。 | 让 AI 反过来考你，确认你真的理解了改动 | **命令** `/grill` |
| Prove to me this works. | 向我证明这能用。 | 让 AI 对比主分支和功能分支的实际行为 | **命令** `/prove` |
| Knowing everything you know now, scrap this and implement the elegant solution. | 基于你现在掌握的全部信息，推翻重来，实现一个优雅的方案。 | 第一版写得别扭时让它重写 | **命令** `/redo` |
| Update your CLAUDE.md so you don't make that mistake again. | 更新你的 CLAUDE.md，别再犯这个错。 | 每次纠正 AI 之后都说一句 | **命令** `/lesson` |
| hey claude make this code change then run /simplify | 帮我改这段代码，改完运行 /simplify。 | 改完自动检查复用、质量和效率 | 内置 `/simplify` |
| use subagents | 使用子代理 | 加在任何请求末尾，让它并行投入更多算力 | — |
| Migrate all sync IO to async. Batch the changes and launch 10 parallel agents with worktree isolation. | 把所有同步 IO 改成异步。分批处理，开 10 个隔离在各自工作树里的并行代理。 | 大规模批量改造 | — |
| go fix the failing CI tests | 去把失败的 CI 测试修好 | 配合 Slack 等工具直接修 bug | — |
| /btw what does the retry logic do? | /btw 这段重试逻辑是干什么的？ | 任务进行中顺便问一句，不打断当前任务 | 内置 `/btw` |

## 团队自定义命令示例

下面这些是 Anthropic 团队**自己写**的命令（不是内置的），文中拿来做示例：

| 命令 | 中文说明 | 本仓库命令 |
|---|---|---|
| `/techdebt` | 每次会话结束时运行，找出并清理重复代码等技术债 | **命令** `/techdebt` |
| `/loop 5m /babysit` | 每 5 分钟自动处理评审意见、rebase、推进 PR 合并 | — |
| `/loop 30m /slack-feedback` | 每 30 分钟根据 Slack 里的反馈自动开 PR | — |
| `/loop 1h /pr-pruner` | 每小时关闭过期的 PR | — |
| `/schedule a daily job that looks at all PRs shipped since yesterday and updates our docs…` | `/schedule` 创建每日任务：检查昨天以来合并的所有 PR，并据此更新文档…… | — |

## 其他要点

- **验证最重要**：给 AI 一个检查自己成果的手段（测试、运行、截图），效果会好很多。
- **先计划再动手**：按 Shift+Tab 进入计划模式，计划确认后再让它写代码。
- **CLAUDE.md 要持续更新**：在 PR 评论里 `@claude` 也能让它把规则补进 CLAUDE.md。
