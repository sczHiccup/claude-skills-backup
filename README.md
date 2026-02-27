# Claude Code Skills 备份

这是我的 Claude Code Skills 备份集合，包含各种实用的技能扩展。

## 包含的 Skills

### 文档处理
| Skill | 描述 |
|-------|------|
| `docx` | 文档创建、编辑、分析，支持跟踪更改和评论 |
| `pdf` | PDF操作工具（提取、创建、合并、表单处理） |
| `pptx` | 演示文稿创建、编辑和分析 |
| `xlsx` | 电子表格创建、编辑、分析和可视化 |
| `markitdown` | 将文件转换为Markdown（PDF/DOCX/PPTX/图像等） |
| `document-polisher` | DOCX文档品牌风格转换（经济学人、麦肯锡等10种风格） |

### 学术研究
| Skill | 描述 |
|-------|------|
| `literature-review` | 多学术数据库系统文献综述 |
| `scientific-writing` | 科学手稿写作（IMRAD结构、引用等） |
| `scientific-schematics` | 创建出版质量的科学图表 |
| `scientific-slides` | 构建研究报告幻灯片和演示文稿 |
| `paper-2-web` | 论文转网站/视频/海报等宣传格式 |
| `openalex-database` | 学术文献数据库查询（2.4亿+学术作品） |
| `exploratory-data-analysis` | 200+种科学数据格式的探索性数据分析 |

### 研究工具
| Skill | 描述 |
|-------|------|
| `research-lookup` | 通过Perplexity查找研究信息 |
| `perplexity-search` | AI驱动网页搜索，获取实时信息 |
| `web-research` | 网络内容研究和最佳实践查找 |
| `market-research-reports` | 生成50+页市场研究报告（麦肯锡/BCG风格） |
| `matplotlib` | 基础绑图库，创建科学可视化图形 |

### 开发工具
| Skill | 描述 |
|-------|------|
| `agent-development` | 代理开发指南，包括结构、系统提示、触发条件等 |
| `command-development` | 斜杠命令开发指南 |
| `mcp-integration` | MCP服务器集成指南 |
| `skill-creator` | 技能创建指南 |

### 提示优化
| Skill | 描述 |
|-------|------|
| `prompt-optimizer` | 分析和优化用户提示的清晰度和完整性 |
| `anti-slop` | 检测和消除低质量AI生成模式，提升内容质量 |

### 插件管理
| Skill | 描述 |
|-------|------|
| `42plugin` | 搜索、安装和管理AI插件 |
| `42plugin-meta` | 创建、改进或打包Claude Code技能 |

### 其他
| Skill | 描述 |
|-------|------|
| `spec-kit-expert` | 规范编写专家（RFC 2119、Gherkin等） |

## 安装方法

### 方法一：使用 42plugin 安装（推荐）

1. 首先安装 [42plugin](https://github.com/anthropics/42plugin)
2. 使用以下命令安装技能：

```bash
# 从本地安装
42plugin install /path/to/skill-folder

# 或从GitHub安装
42plugin install https://github.com/your-username/claude-skills-backup/tree/main/skills/skill-name
```

### 方法二：手动安装

将所需的 skill 文件夹复制到 Claude 的 skills 目录：

**Windows:**
```
C:\Users\<username>\.claude\skills\<skill-name>\
```

**macOS/Linux:**
```
~/.claude/skills/<skill-name>/
```

### 方法三：创建符号链接

```bash
# Windows (以管理员身份运行)
mklink /D "C:\Users\<username>\.claude\skills\skill-name" "D:\path\to\claude-skills-backup\skills\skill-name"

# macOS/Linux
ln -s /path/to/claude-skills-backup/skills/skill-name ~/.claude/skills/skill-name
```

## 使用方法

在 Claude Code 中使用斜杠命令调用：

```
/skill-name
```

例如：
- `/pdf` - 调用PDF处理技能
- `/docx` - 调用文档处理技能
- `/scientific-writing` - 调用科学写作技能

## 更新日志

- **2026-02-27**: 初始备份，包含27个skills

## 来源

这些 skills 来自以下市场：
- [anthropics/skills](https://github.com/anthropics/skills) - 官方技能
- [k-dense-ai/claude-scientific-skills](https://github.com/k-dense-ai/claude-scientific-skills) - 科学技能
- [k-dense-ai/claude-scientific-writer](https://github.com/k-dense-ai/claude-scientific-writer) - 科学写作
- 以及其他社区贡献者

## 许可证

各 skill 遵循其原始仓库的许可证。
