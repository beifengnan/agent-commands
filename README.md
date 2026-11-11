# agent-commands

常用的 AI agent 斜杠命令合集，一次安装，可在 Claude Code、Codex、Cursor、Gemini CLI 中使用。

## 命令

| 命令 | 作用 |
| --- | --- |
| `/audit [路径或关注点]` | 通读整个项目，找出所有坏掉的、不一致的、低效的、已经不需要的东西。有把握的就修掉，其余的列出来给你审。 |
| `/grill [范围]` | 就当前改动考你，没通过考核之前不提 PR。 |
| `/prove [功能]` | 向你证明改动能用：对比主分支和当前分支的实际运行结果。 |
| `/redo [额外要求]` | 基于目前掌握的全部信息，推翻当前实现，重写一个优雅的方案。 |
| `/lesson [教训]` | 把刚才被纠正的错误写进 CLAUDE.md / AGENTS.md，避免再犯。 |
| `/techdebt [路径]` | 收尾时找出本次改动带来的技术债（尤其是重复代码），有把握的清理掉。 |

方括号里的参数都是可选的，用来限定范围或补充要求。

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

脚本会自动装到本机已安装的客户端；加 `--all`（PowerShell 用 `-All`）则全部安装。装好后重启客户端即可使用。

| 客户端 | 触发方式 |
| --- | --- |
| Claude Code | `/audit` |
| Codex | `$audit`，或从 `/skills` 中选择 |
| Cursor | `/audit` |
| Gemini CLI | `/audit` |

Claude Code 也可以用插件方式安装（命令会带前缀，如 `/agent-commands:audit`）：

```
/plugin marketplace add beifengnan/agent-commands
/plugin install agent-commands@agent-commands
```

## 更新

```bash
git pull
```

然后重新运行一次安装脚本。
