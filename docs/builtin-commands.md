# Claude Code 常用内置斜杠命令（中文版）

这些命令是 **Claude Code 自带的**，不需要安装本仓库；其他客户端（Codex、Cursor、Gemini CLI）一般没有，或者名字不同。
输入 `/help` 可以看到你当前版本的完整列表。

来源：Anthropic 官方《[Claude Code power user tips](https://support.claude.com/en/articles/14554000-claude-code-power-user-tips)》等。

## 代码质量

| 命令 | 作用 |
|---|---|
| `/code-review` | 审查当前改动（或某个 PR）里的 bug，可以指定审查强度 |
| `/simplify` | 检查改动里的代码复用、简化和效率问题，并直接修好 |
| `/security-review` | 对当前分支的改动做安全审查 |
| `/init` | 分析项目，生成 CLAUDE.md |

## 批量与自动化

| 命令 | 作用 | 示例 |
|---|---|---|
| `/batch <任务>` | 把大型迁移拆给多个 worktree 代理并行完成，每个代理各开一个 PR | `/batch 把 src/ 从 JavaScript 迁移到 TypeScript` |
| `/loop <间隔> <命令>` | 按固定间隔重复执行一个提示词或命令 | `/loop 5m /babysit` |
| `/schedule` | 创建在云端按计划运行的任务 | `/schedule 每天早上检查昨天合并的 PR 并更新文档` |
| `/agents` | 创建和管理子代理 | |

## 对话控制

| 命令 | 作用 |
|---|---|
| `/btw <问题>` | 任务进行中顺便问一句（单轮、不调用工具），不打断当前任务 |
| `/effort <级别>` | 设置推理强度：low / medium / high / xhigh / max / auto |
| `/branch` | 把当前会话分叉出一个新会话 |
| `/add-dir <路径>` | 给当前会话添加额外的目录 |
| `Shift+Tab` | （快捷键）切换计划模式和权限模式 |

## 记忆与配置

| 命令 | 作用 |
|---|---|
| `/memory` | 查看和配置自动记忆 |
| `/dream` | 整理记忆 |
| `/permissions` | 预先允许某些命令，减少确认弹窗 |
| `/sandbox` | 开启沙箱运行环境 |
| `/config` | 设置主题、编辑器模式（Vim）、输出风格、远程控制等 |
| `/statusline` | 自定义状态栏 |
| `/keybindings` | 修改快捷键 |
| `/terminal-setup` | 让终端支持 Shift+Enter 换行 |
| `/color` | 修改输入框颜色 |
| `/voice` | 语音输入（按住空格说话） |

## 插件与集成

| 命令 | 作用 |
|---|---|
| `/plugin` | 安装和管理插件（本仓库也可以用它安装） |
| `/install-github-app` | 安装 GitHub App，之后可以在 PR 里 `@claude` |

## 远程与多端

| 命令 | 作用 |
|---|---|
| `/remote-control` | 用手机或网页控制本地会话 |
| `/teleport` | 把云端会话拉到本地继续 |
| `&` | （放在消息开头）把会话发到云端运行 |
