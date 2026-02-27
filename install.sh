#!/bin/bash
# Claude Skills 安装脚本
# 用于将所有 skills 安装到 Claude Code

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"

# 确定 Claude skills 目录
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    CLAUDE_SKILLS_DIR="$USERPROFILE/.claude/skills"
else
    CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
fi

echo -e "${BLUE}Claude Skills 安装脚本${NC}"
echo "================================"
echo "Skills 源目录: $SKILLS_DIR"
echo "Claude 目录: $CLAUDE_SKILLS_DIR"
echo ""

# 创建 Claude skills 目录（如果不存在）
mkdir -p "$CLAUDE_SKILLS_DIR"

# 计数器
installed=0
skipped=0

# 遍历所有 skill 文件夹
for skill_path in "$SKILLS_DIR"/*; do
    if [ -d "$skill_path" ]; then
        skill_name=$(basename "$skill_path")
        target_path="$CLAUDE_SKILLS_DIR/$skill_name"

        # 检查是否已存在
        if [ -e "$target_path" ]; then
            echo -e "  ${GREEN}✓${NC} $skill_name (已存在，跳过)"
            ((skipped++))
        else
            # 创建符号链接
            if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
                # Windows: 复制文件夹
                cp -r "$skill_path" "$target_path"
            else
                # macOS/Linux: 创建符号链接
                ln -s "$skill_path" "$target_path"
            fi
            echo -e "  ${GREEN}✓${NC} $skill_name (已安装)"
            ((installed++))
        fi
    fi
done

echo ""
echo "================================"
echo -e "安装完成: ${GREEN}$installed${NC} 个新 skills, $skipped 个已存在"
echo ""
echo "使用方法: 在 Claude Code 中输入 /<skill-name>"
echo "例如: /pdf, /docx, /scientific-writing"
