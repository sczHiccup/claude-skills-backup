# Claude Skills 安装脚本 (Windows PowerShell)
# 用于将所有 skills 安装到 Claude Code

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsDir = Join-Path $ScriptDir "skills"
$ClaudeSkillsDir = Join-Path $env:USERPROFILE ".claude\skills"

Write-Host "Claude Skills 安装脚本" -ForegroundColor Blue
Write-Host "================================"
Write-Host "Skills 源目录: $SkillsDir"
Write-Host "Claude 目录: $ClaudeSkillsDir"
Write-Host ""

# 创建 Claude skills 目录（如果不存在）
if (-not (Test-Path $ClaudeSkillsDir)) {
    New-Item -ItemType Directory -Path $ClaudeSkillsDir -Force | Out-Null
}

$installed = 0
$skipped = 0

# 遍历所有 skill 文件夹
Get-ChildItem -Path $SkillsDir -Directory | ForEach-Object {
    $skillName = $_.Name
    $targetPath = Join-Path $ClaudeSkillsDir $skillName

    if (Test-Path $targetPath) {
        Write-Host "  ✓ $skillName (已存在，跳过)" -ForegroundColor Green
        $skipped++
    } else {
        # 复制文件夹
        Copy-Item -Path $_.FullName -Destination $targetPath -Recurse
        Write-Host "  ✓ $skillName (已安装)" -ForegroundColor Green
        $installed++
    }
}

Write-Host ""
Write-Host "================================"
Write-Host "安装完成: $installed 个新 skills, $skipped 个已存在" -ForegroundColor Green
Write-Host ""
Write-Host "使用方法: 在 Claude Code 中输入 /<skill-name>"
Write-Host "例如: /pdf, /docx, /scientific-writing"
