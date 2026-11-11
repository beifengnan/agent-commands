---
name: lesson
description: 把刚才被纠正的错误写进项目的 agent 指令文件（CLAUDE.md / AGENTS.md 等），避免以后再犯。仅在用户明确调用 /lesson 时使用。
argument-hint: "[可选：要记住的教训]"
disable-model-invocation: true
---

# /lesson — 记住教训，别再犯

> 原文（Anthropic Claude Code 团队）："Update your CLAUDE.md so you don't make that mistake again."
> 中文：更新你的 CLAUDE.md，别再犯这个错。

团队建议：**每次纠正 AI 之后都说一句。**

## 做法

1. 找出刚才被用户纠正的错误；用户若附带了参数，以参数为准。弄清楚：错在哪里，正确做法是什么，为什么。
2. 找到项目的 agent 指令文件，按以下顺序取第一个存在的：`CLAUDE.md`、`AGENTS.md`、`GEMINI.md`、`.cursor/rules/`。都不存在就在项目根目录新建 `CLAUDE.md`。
3. 先读一遍现有内容：
   - 已有类似规则 → 修改或强化那一条，不要重复添加
   - 与新教训冲突的旧规则 → 更新它，并在报告里指出
4. 写成**一条简短、可执行、具体**的规则，放在最相关的小节下（没有合适的小节就放到 "注意事项"）。
   - 好："不要用 TypeScript enum，一律用字面量联合类型。"
   - 差："写代码时要注意类型。"
5. 不要写进本次任务的临时细节，只写以后会反复用到的规则。

## 报告

给出新增或修改的那一行，以及写到了哪个文件。
