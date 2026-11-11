# agent-commands

我常用的 AI agent 斜杠命令合集。每个命令只写一次（`skills/<名字>/SKILL.md`，采用开放的 [Agent Skills](https://agentskills.io) 格式），由安装脚本分发到各个客户端。

## 命令列表

| 命令 | 作用 |
| --- | --- |
| `/audit [路径或关注点]` | 通读整个项目，找出所有坏掉的、不一致的、低效的、已经不需要的东西。有把握的就修掉，其余的列出来给你审。 |
| `/grill [范围]` | 就当前改动考你，没通过考核之前不提 PR。 |
| `/prove [功能]` | 向你证明改动能用：对比主分支和当前分支的实际运行结果。 |
| `/redo [额外要求]` | 基于目前掌握的全部信息，推翻当前实现，重写一个优雅的方案。 |
| `/lesson [教训]` | 把刚才被纠正的错误写进 CLAUDE.md / AGENTS.md，避免再犯。 |
| `/techdebt [路径]` | 收尾时找出本次改动带来的技术债（尤其是重复代码），有把握的清理掉。 |

`/audit` 来自 Anthropic 的 Alex Albert 每次新模型上线都会跑的提示词，其余命令来自 Anthropic 官方整理的 Claude Code 团队用法。

## 参考资料（中文）

- [Anthropic 官方整理的团队常用提示词](docs/team-prompts.md)：原文 + 中文翻译 + 用途
- [Claude Code 常用内置斜杠命令](docs/builtin-commands.md)：不用安装，Claude Code 自带

## 安装

```bash
git clone https://github.com/beifengnan/agent-commands.git
cd agent-commands
```

macOS / Linux / Git Bash：

```bash
./install.sh
```

Windows PowerShell：

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

脚本只会装到本机**已经存在配置目录**的客户端；加 `--all`（PowerShell 用 `-All`）则全部安装。更新时 `git pull` 后重新运行即可。

| 客户端 | 安装位置 | 触发方式 |
| --- | --- | --- |
| Claude Code（CLI / 桌面 / IDE） | `~/.claude/skills/<名字>/` | `/audit` |
| Codex | `~/.codex/skills/<名字>/` | `$audit` 或从 `/skills` 中选择 |
| Cursor | `~/.cursor/commands/<名字>.md` | `/audit` |
| Gemini CLI | `~/.gemini/commands/<名字>.toml` | `/audit` |

### Claude Code 也可以用插件方式安装

```
/plugin marketplace add beifengnan/agent-commands
/plugin install agent-commands@agent-commands
```

插件方式的命令带命名空间：`/agent-commands:audit`。

## 新增命令

1. 新建 `skills/<命令名>/SKILL.md`，格式：

   ```markdown
   ---
   name: 命令名
   description: 一句话说明做什么、什么时候用
   disable-model-invocation: true   # 只允许手动用斜杠触发
   ---

   给 agent 的完整指令……
   ```

2. 在上面的命令列表里加一行，提交推送，各机器上 `git pull && ./install.sh`。

## 其他客户端

只要客户端支持 Agent Skills 目录或"Markdown 自定义命令"，都可以直接用 `skills/` 里的文件：把整个目录复制到它的 skills 目录，或者把 `SKILL.md` 去掉开头 `---` 之间的部分后放进它的命令目录。
