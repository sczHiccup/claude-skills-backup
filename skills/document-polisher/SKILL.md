---
name: document-polisher
description: "使用世界级品牌风格转换任何 DOCX 文档。选择 10 种优质品牌美学（《经济学人》，麦肯锡，德勤，KPMG，Stripe，苹果，IBM，Notion，Linear，Figma），为文档增添专业的排版、颜色和格式。当用户想要时使用： (1) 将优质品牌风格应用于文档，(2) 使文档看起来更专业，(3) 匹配特定品牌的视觉识别，(4) 创建精美的报告、提案或演示文稿。"
---

# Document Polisher

使用世界级品牌美学将任何文档转换为精美、专业风格的杰作。

## 概述

此 Skill 将来自 10 个精心挑选品牌的优质品牌风格应用于 DOCX 文档。每个品牌都经过分析，以其排版、调色板和设计原则创建真实感的文档。

## 品牌选择菜单

当用户想要美化文档时，始终展示此选择菜单：

```
╔══════════════════════════════════════════════════════════════════════════╗
║                        DOCUMENT POLISHER                                 ║
║                    Select Your Brand Style                               ║
╠══════════════════════════════════════════════════════════════════════════╣
║                                                                          ║
║  EDITORIAL                                                               ║
║  ─────────                                                               ║
║  1. The Economist    │ 深海军蓝 + 衬线排版                                 ║
║                      │ 最适合：报告、分析、思想领导                        ║
║                                                                          ║
║  CONSULTING                                                              ║
║  ──────────                                                              ║
║  2. McKinsey         │ 锐角 + 大胆的蓝色点缀                               ║
║                      │ 最适合：战略演示、执行摘要                          ║
║                                                                          ║
║  3. Deloitte         │ 青蓝色 + 药丸形元素                                 ║
║                      │ 最适合：审计、评估、正式报告                        ║
║                                                                          ║
║  4. KPMG             │ 双色蓝 + 压缩标题                                   ║
║                      │ 最适合：财务报告、合规文档                          ║
║                                                                          ║
║  TECH                                                                    ║
║  ────                                                                    ║
║  5. Stripe           │ 深蓝色 + 紫色渐变                                   ║
║                      │ 最适合：API 文档、开发者指南、规格                  ║
║                                                                          ║
║  6. Apple            │ 极简风格 + 宽敞的空白                               ║
║                      │ 最适合：产品文档、用户指南                          ║
║                                                                          ║
║  7. IBM              │ Plex 排版 + Carbon 设计                            ║
║                      │ 最适合：技术文档、企业报告                          ║
║                                                                          ║
║  8. Linear           │ 现代紫色 + 精确排版                                ║
║                      │ 最适合：产品规格、更新日志、开发文档                ║
║                                                                          ║
║  PRODUCTIVITY                                                            ║
║  ────────────                                                            ║
║  9. Notion           │ 干净的蓝色 + 微妙的点缀                             ║
║                      │ 最适合：维基、项目计划、文档                        ║
║                                                                          ║
║  DESIGN                                                                  ║
║  ──────────                                                              ║
║  10. Figma           │ 鲜艳的多色调色板                                   ║
║                      │ 最适合：创意简报、设计文档、品牌                    ║
║                                                                          ║
╚══════════════════════════════════════════════════════════════════════════╝
```

## 工作流程

### 第一步：询问用户

当用户想要美化文档时：
1. 显示上述品牌选择菜单
2. 询问：“您想应用哪种品牌风格？您也可以告诉我文档的目的，我会推荐一种风格。”

### 第二步：应用样式

**重要：始终使用带有 python-docx 的 Python 脚本。切勿直接使用 XML/OOXML 操作，因为这可能会损坏文档。**

#### 主要方法：Python 脚本（必需）

该脚本使用 python-docx 安全地重建带有品牌样式的文档。它：
- 读取源文档
- 创建应用了品牌样式的新文档
- 复制所有内容并保持正确的格式
- 保留粗体、斜体、列表和结构

```bash
# 确保在环境中安装了 python-docx
pip install python-docx

# 应用品牌样式
python scripts/apply_brand.py <input.docx> <brand_name> <output.docx>

# 示例：
python scripts/apply_brand.py report.docx economist polished_report.docx
python scripts/apply_brand.py proposal.docx mckinsey styled_proposal.docx
python scripts/apply_brand.py guide.docx stripe tech_guide.docx
```

#### 可用品牌名称：
- `economist` - The Economist（编辑，衬线）
- `mckinsey` - McKinsey & Company（咨询，锐角）
- `deloitte` - Deloitte（咨询，青蓝色）
- `kpmg` - KPMG（咨询，大胆蓝色）
- `stripe` - Stripe（技术，深蓝色/紫色）
- `apple` - Apple（技术，极简）
- `ibm` - IBM（技术，企业）
- `notion` - Notion（生产力，干净）
- `linear` - Linear（技术，现代紫色）
- `figma` - Figma（设计，多彩）

### 脚本功能

1. **加载品牌配置** 从 `templates/brand-mapping.json`
2. **创建新文档** （避免因 XML 编辑而损坏）
3. **应用文档级样式：**
   - 正文样式（字体、大小、颜色）
   - 标题 1、2、3 样式（字体、大小、颜色、间距）
   - 标题样式
   - 页面边距
4. **复制内容并保持格式：**
   - 保留正确级别的标题
   - 维护项目符号和编号列表
   - 保留粗体、斜体、下划线格式
   - 保留段落对齐
   - 复制带样式的表格
5. **保存为新文件** （绝不覆盖原文件）

## 品牌参考文件

详细的品牌指南存储在 `brands/` 目录中：

| 品牌           | 参考文件              | 关键元素                              |
|----------------|-----------------------|---------------------------------------|
| The Economist   | `brands/economist.md` | Georgia 衬线，#1F2E7A 海军蓝，最小边框 |
| McKinsey       | `brands/mckinsey.md` | Helvetica Neue，#051C2C 深色，锐角    |
| Deloitte       | `brands/deloitte.md` | Open Sans，#007CB0 青蓝色，圆形元素  |
| KPMG           | `brands/kpmg.md`     | Open Sans，#1E49E2 蓝色               |
| Stripe         | `brands/stripe.md`   | Helvetica Neue，#0A2540 + #9966FF 紫色 |
| Apple          | `brands/apple.md`    | Helvetica Neue，#0071E3 蓝色，极简    |
| IBM            | `brands/ibm.md`      | Arial，#0F62FE 蓝色，锐角            |
| Notion         | `brands/notion.md`   | Arial，#0075DE 蓝色，基于块          |
| Linear         | `brands/linear.md`   | Arial，#5E6AD2 紫色，现代            |
| Figma          | `brands/figma.md`    | Arial，多色调色板                     |

## 样式映射

`templates/brand-mapping.json` 文件包含用于编程样式的结构化数据：

```json
{
  "brands": {
    "economist": {
      "name": "The Economist",
      "colors": {
        "primary": "#1F2E7A",
        "accent": "#E3120B",
        "textPrimary": "#0D0D0D"
      },
      "typography": {
        "headingFont": "Georgia",
        "bodyFont": "Georgia"
      },
      "styles": {
        "h1": { "size": 28, "color": "#1F2E7A", "bold": true },
        "h2": { "size": 22, "color": "#1F2E7A", "bold": true },
        "body": { "size": 11, "color": "#0D0D0D" }
      }
    }
  }
}
```

## 示例

### 示例 1：使用麦肯锡风格美化报告

用户：“让我的季度报告看起来更专业”

1. 显示品牌菜单
2. 用户选择“麦肯锡”
3. 应用样式：

```bash
cd /path/to/project
source venv/bin/activate  # 如果使用虚拟环境
python .claude/skills/document-polisher/scripts/apply_brand.py quarterly_report.docx mckinsey polished_quarterly_report.docx
```

### 示例 2：将经济学人风格应用于指南

用户：“像《经济学人》那样为这个指南加样式”

```bash
python .claude/skills/document-polisher/scripts/apply_brand.py guide.docx economist guide_economist.docx
```

### 示例 3：使用 Stripe 风格的技术文档

用户：“让这个 API 文档看起来像 Stripe 的文档”

```bash
python .claude/skills/document-polisher/scripts/apply_brand.py api_doc.docx stripe api_doc_stripe.docx
```

## 依赖项

- **Python 3.x**
- **python-docx**: `pip install python-docx`

脚本将检查 python-docx 并在缺失时提供安装说明。

## 提高效果的技巧

1. **匹配品牌与内容**：对商业文档使用咨询品牌，对技术内容使用技术品牌
2. **考虑受众**：经济学人适合学术，Stripe 适合开发者，苹果适合消费者
3. **不要过度品牌化**：目标是专业的打磨，而不是完全复制品牌
4. **使用 PDF 导出进行测试**：某些样式在 PDF 和 Word 中看起来不同
5. **使用虚拟环境**：保持依赖项隔离

## 故障排除

### “找不到模块：docx”
```bash
pip install python-docx
```

### 文档看起来不正确
- 确保源文档使用标准 Word 样式（标题 1、2、3、正常）
- 检查列表是否使用内置的项目符号/编号样式

### 脚本路径问题
始终从项目根目录运行或使用绝对路径：
```bash
python /full/path/to/.claude/skills/document-polisher/scripts/apply_brand.py input.docx brand output.docx
```

## 添加新品牌

要添加新品牌：
1. 使用 FireCrawl 提取品牌：`mcp__firecrawl__firecrawl_extract_branding`
2. 在 `brands/<brand_name>.md` 中创建新文件
3. 在 `templates/brand-mapping.json` 中添加条目，包括：
   - `name`，`description`，`category`
   - `colors`：primary，accent，background，textPrimary，textSecondary
   - `typography`：headingFont，bodyFont
   - `styles`：h1，h2，h3，body，包含大小、颜色、粗体
4. 使用示例文档进行测试