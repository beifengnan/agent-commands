#!/usr/bin/env bash
# 把 skills/ 下的每个命令安装到本机已有的 agent 客户端。
# 用法: ./install.sh          只装到已存在配置目录的客户端
#       ./install.sh --all    所有客户端都装（目录不存在就创建）
# 更新: git pull 后重新运行即可（会覆盖旧版本）。
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
FORCE=0
[ "${1:-}" = "--all" ] && FORCE=1

want() { [ "$FORCE" = 1 ] || [ -d "$1" ]; }

# 去掉 SKILL.md 开头的 YAML frontmatter，只留正文
body() { awk 'f>=2 {print; next} /^---[[:space:]]*$/ {f++; next} f==0 {print}' "$1"; }
desc() { sed -n 's/^description:[[:space:]]*//p' "$1" | head -n1; }

for dir in "$ROOT"/skills/*/; do
  name="$(basename "$dir")"
  src="$dir/SKILL.md"
  [ -f "$src" ] || continue
  echo "== $name"

  # Claude Code: 原生 Agent Skills -> /name
  if want "$HOME/.claude"; then
    mkdir -p "$HOME/.claude/skills"
    rm -rf "$HOME/.claude/skills/$name"
    cp -R "$dir" "$HOME/.claude/skills/$name"
    echo "   Claude Code  -> ~/.claude/skills/$name"
  fi

  # Codex: 原生 Agent Skills -> \$name 或 /skills
  if want "$HOME/.codex"; then
    mkdir -p "$HOME/.codex/skills"
    rm -rf "$HOME/.codex/skills/$name"
    cp -R "$dir" "$HOME/.codex/skills/$name"
    echo "   Codex        -> ~/.codex/skills/$name"
  fi

  # Cursor: 全局自定义命令 (纯 Markdown) -> /name
  if want "$HOME/.cursor"; then
    mkdir -p "$HOME/.cursor/commands"
    body "$src" > "$HOME/.cursor/commands/$name.md"
    echo "   Cursor       -> ~/.cursor/commands/$name.md"
  fi

  # Gemini CLI: 自定义命令 (TOML) -> /name
  if want "$HOME/.gemini"; then
    mkdir -p "$HOME/.gemini/commands"
    {
      printf 'description = "%s"\n' "$(desc "$src" | sed 's/\\/\\\\/g; s/"/\\"/g')"
      printf "prompt = '''\n"
      body "$src"
      printf "\n用户附加的参数：{{args}}\n'''\n"
    } > "$HOME/.gemini/commands/$name.toml"
    echo "   Gemini CLI   -> ~/.gemini/commands/$name.toml"
  fi
done

echo "完成。重启客户端后输入 /<命令名> 即可使用。"
