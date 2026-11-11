# 把 skills\ 下的每个命令安装到本机已有的 agent 客户端（Windows PowerShell 5.1+）。
# 用法: .\install.ps1          只装到已存在配置目录的客户端
#       .\install.ps1 -All     所有客户端都装（目录不存在就创建）
# 更新: git pull 后重新运行即可（会覆盖旧版本）。
param([switch]$All)
$ErrorActionPreference = 'Stop'

$Root = $PSScriptRoot
$HomeDir = if ($env:AGENT_HOME) { $env:AGENT_HOME } else { $HOME }
$Utf8 = New-Object System.Text.UTF8Encoding($false)

function Want($path) { return $All -or (Test-Path $path) }

function Get-Body($text) {
    # 去掉开头的 YAML frontmatter
    $m = [regex]::Match($text, '^\s*---\r?\n.*?\r?\n---[ \t]*\r?\n', 'Singleline')
    if ($m.Success) { return $text.Substring($m.Length) } else { return $text }
}

function Get-Desc($text) {
    $m = [regex]::Match($text, '(?m)^description:[ \t]*(.+?)\r?$')
    if ($m.Success) { return $m.Groups[1].Value } else { return '' }
}

function Copy-Skill($dir, $dest) {
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    New-Item -ItemType Directory -Force (Split-Path $dest) | Out-Null
    Copy-Item -Recurse $dir $dest
}

foreach ($dir in Get-ChildItem -Directory (Join-Path $Root 'skills')) {
    $name = $dir.Name
    $src = Join-Path $dir.FullName 'SKILL.md'
    if (-not (Test-Path $src)) { continue }
    $text = [IO.File]::ReadAllText($src, $Utf8)
    $body = Get-Body $text
    Write-Host "== $name"

    # Claude Code: 原生 Agent Skills -> /name
    if (Want (Join-Path $HomeDir '.claude')) {
        Copy-Skill $dir.FullName (Join-Path $HomeDir ".claude\skills\$name")
        Write-Host "   Claude Code  -> ~\.claude\skills\$name"
    }

    # Codex: 原生 Agent Skills -> `$name 或 /skills
    if (Want (Join-Path $HomeDir '.codex')) {
        Copy-Skill $dir.FullName (Join-Path $HomeDir ".codex\skills\$name")
        Write-Host "   Codex        -> ~\.codex\skills\$name"
    }

    # Cursor: 全局自定义命令 (纯 Markdown) -> /name
    if (Want (Join-Path $HomeDir '.cursor')) {
        $d = Join-Path $HomeDir '.cursor\commands'
        New-Item -ItemType Directory -Force $d | Out-Null
        [IO.File]::WriteAllText((Join-Path $d "$name.md"), $body, $Utf8)
        Write-Host "   Cursor       -> ~\.cursor\commands\$name.md"
    }

    # Gemini CLI: 自定义命令 (TOML) -> /name
    if (Want (Join-Path $HomeDir '.gemini')) {
        $d = Join-Path $HomeDir '.gemini\commands'
        New-Item -ItemType Directory -Force $d | Out-Null
        $desc = (Get-Desc $text).Replace('\', '\\').Replace('"', '\"')
        $toml = "description = `"$desc`"`nprompt = '''`n$body`n用户附加的参数：{{args}}`n'''`n"
        [IO.File]::WriteAllText((Join-Path $d "$name.toml"), $toml, $Utf8)
        Write-Host "   Gemini CLI   -> ~\.gemini\commands\$name.toml"
    }
}

Write-Host "完成。重启客户端后输入 /<命令名> 即可使用。"
