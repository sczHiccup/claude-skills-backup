---
name: prompt-optimizer
description: 分析和优化用户提示的清晰度、具体性和完整性，使用互动问卷或直接分析。当用户请求模糊、含糊、不完整或缺乏必要细节时，请使用此技能。支持两种模式 - 互动模式（使用 AskUserQuestion 工具进行引导性澄清）和直接分析模式（提供优化建议）。当提示中包含模糊语言如“某些东西”、“东西”、“东西”、“它”时，或者请求缺乏上下文、技术规格、成功标准或示例时，触发此技能。当用户请求互动/问卷模式时，使用 AskUserQuestion 引导他们通过结构化问题。帮助将不清晰的请求转变为结构良好、可操作的提示。
allowed-tools: AskUserQuestion
---

# 提示优化器

此技能分析用户提示并提供更清晰、更具体和更可操作的优化版本。

## 目的

将模糊、不完整或含糊的用户请求转变为结构良好的提示，从而带来更好的结果。通过根据质量标准分析提示并提供优化版本，此技能帮助用户更有效地传达他们的需求。

## 何时使用此技能

当用户提示出现以下一个或多个问题时，请使用此技能：

### 清晰度问题
- 模糊语言：“某些东西”、“东西”、“东西”、“它”、“这个”
- 含糊的代词没有明确的指代
- 多种可能的解释
- 不明确的期望结果

### 具体性问题
- 缺少关于问题领域的上下文
- 没有技术规格（语言、框架、版本）
- 缺少示例（当示例有帮助时）
- 范围或边界未定义

### 完整性问题
- 缺少必要的信息或输入
- 没有定义成功标准
- 边缘情况的行为未定义
- 缺少约束或要求

### 结构问题
- 信息杂乱无章
- 复杂请求没有清晰结构
- 将上下文与请求混合
- 没有逻辑流程

### 可操作性问题
- 没有明确的行动动词或请求
- 被动语态使意图不明确
- 混淆或相互矛盾的指示
- 缺少输出格式规范

## 激活触发器

当检测到以下情况时激活此技能：
- 模糊词： “某些东西”、“东西”、“东西”、“它”、“这个”、“那个”
- 质量指标：“更好”、“好”、“不错”（没有标准）
- 不完整的请求：“帮助...”、“你能...”、“修复...” （没有细节）
- 过于宽泛的请求：“构建一个应用程序”、“创建一个系统”
- 技术请求中缺少规格
- 没有明确成功标准的请求

## 分析工作流程

**可用两种模式：**

### 模式 1：互动问卷（推荐用于复杂请求）
使用 AskUserQuestion 工具引导用户通过结构化问题。这种协作方法帮助用户逐步澄清他们的需求。

**何时使用**：中等到复杂请求，或者当用户更喜欢引导互动时。

### 模式 2：直接分析（快速）
分析提示并在一次响应中提供建议改进。

**何时使用**：简单的优化需求，或者当用户想要快速结果时。

**默认**：从模式 2（直接分析）开始。如果用户请求互动模式或请求非常复杂，则切换到模式 1。

---

## 模式 2：直接分析工作流程

### 步骤 1：接收并阅读提示

仔细阅读用户的原始提示，以理解他们的意图。

### 步骤 2：识别问题

使用 `references/optimization-principles.md` 系统地检查问题：

**清晰度检查**：
- 语言是否具体且明确？
- 所有术语是否清晰定义？
- 是否只有一个合理的解释？

**具体性检查**：
- 是否提供了足够的上下文？
- 是否指定了技术要求？
- 是否在有帮助时包含示例？

**完整性检查**：
- 是否存在所有必要的信息？
- 是否定义了成功标准？
- 是否考虑了边缘情况？

**结构检查**：
- 信息是否逻辑组织？
- 请求是否易于解析？
- 上下文是否与任务分开？

**可操作性检查**：
- 是否有明确的请求行动？
- 是否指定了输出格式？
- 指示是否明确？

### 步骤 3：分类问题

按类别列出所有识别的问题：
- 清晰度问题：[列表]
- 具体性缺口：[列表]
- 完整性缺陷：[列表]
- 结构问题：[列表]
- 可操作性问题：[列表]

### 步骤 4：生成优化提示

创建一个改进版本，遵循以下原则：

**增加具体性**：
- 用具体描述替换模糊术语
- 添加缺失的技术规格
- 包含相关上下文

**提高清晰度**：
- 使用清晰、明确的语言
- 定义所有术语
- 消除多种解释

**确保完整性**：
- 添加缺失的要求
- 定义成功标准
- 指定约束

**增强结构**：
- 逻辑组织信息
- 使用项目符号和部分
- 将上下文与任务分开

**使其可操作**：
- 以明确的行动动词开头
- 指定输出格式
- 提供具体的交付物

参考 `references/optimization-principles.md` 获取模式和示例。

### 步骤 5：呈现分析

提供结构化响应：

1. **原始提示**：显示用户的原始请求

2. **识别的问题**：列出发现的具体问题
   - 按类型分类
   - 每个问题的简要解释

3. **优化提示**：提供改进版本
   - 结构良好
   - 完整
   - 可操作

4. **关键改进**：突出主要变化
   - 添加了什么
   - 澄清了什么
   - 为什么更好

5. **可选**：提供进一步完善或继续使用优化提示的选项

---

## 模式 1：互动问卷工作流程

### 当用户请求互动模式时

如果用户明确要求互动/问卷模式，或者提示有多个复杂问题，请使用此工作流程。

### 步骤 1：快速初步分析

快速识别缺失信息的主要类别：
- 需要技术规格吗？
- 功能要求不明确？
- 缺少设计/样式偏好？
- 范围或约束未定义？

### 步骤 2：设计问题集

根据分析，准备 1-4 个针对性问题，使用 AskUserQuestion 工具。

**问题结构**：
- 每个问题应有清晰的标题（最多 12 个字符）
- 提供 2-4 个具体选项
- 包括解释每个选项的描述
- 允许“其他”以便自定义输入（自动提供）

**问题类别**：

**针对代码请求**：
1. 技术栈（React、Vue、原生 JS 等）
2. 类型系统（TypeScript、JavaScript）
3. 样式方案（Tailwind、CSS Modules、styled-components 等）
4. 功能需求（需要的具体功能）

**针对组件请求**：
1. 组件类型（按钮、表单、卡片、模态框等）
2. 需要的变体（主/次、尺寸、状态）
3. Props/API（应该接受什么？）
4. 用例（如何使用？）

**针对 UI/设计请求**：
1. 平台（Web、移动、桌面应用）
2. 设计风格（现代、简约、多彩、企业）
3. 响应需求（移动优先、桌面专用、自适应）
4. 关键特性（必须包含什么？）

### 步骤 3：使用 AskUserQuestion 工具

调用 AskUserQuestion 工具，提出结构化问题。

**重要**：始终包括一个最终的开放式问题，允许用户使用“其他”选项添加自定义要求。

```typescript
AskUserQuestion({
  questions: [
    {
      question: "What technology stack should this use?",
      header: "Tech Stack",
      multiSelect: false,
      options: [
        {
          label: "React + TypeScript",
          description: "Modern React with full type safety"
        },
        {
          label: "React + JavaScript",
          description: "React without TypeScript"
        },
        {
          label: "Vue 3",
          description: "Vue 3 Composition API"
        },
        {
          label: "Vanilla JavaScript",
          description: "Plain JS without frameworks"
        }
      ]
    },
    {
      question: "What styling approach would you like?",
      header: "Styling",
      multiSelect: false,
      options: [
        {
          label: "Tailwind CSS",
          description: "Utility-first CSS framework"
        },
        {
          label: "CSS Modules",
          description: "Scoped CSS with modules"
        },
        {
          label: "styled-components",
          description: "CSS-in-JS solution"
        }
      ]
    },
    {
      question: "Which features are needed?",
      header: "Features",
      multiSelect: true,
      options: [
        {
          label: "Multiple variants",
          description: "Different color/style variants (primary, secondary, etc.)"
        },
        {
          label: "Size options",
          description: "Different sizes (sm, md, lg)"
        },
        {
          label: "Loading state",
          description: "Show spinner during async operations"
        },
        {
          label: "Disabled state",
          description: "Disabled/inactive state"
        }
      ]
    },
    {
      question: "Any additional requirements or constraints?",
      header: "Extra Needs",
      multiSelect: false,
      options: [
        {
          label: "No, that's all",
          description: "I don't need anything else"
        },
        {
          label: "Yes, let me specify",
          description: "I have additional requirements (use 'Other' to describe)"
        }
      ]
    }
  ]
})
```

**注意**：AskUserQuestion 工具自动提供“其他”选项，允许用户为任何问题输入自定义文本。

### 步骤 4：处理答案

在收到用户的答案后：
1. 从每个问题中提取所有选定的选项
2. 处理“其他”响应，如果用户提供了自定义输入
3. 特别关注“额外需求”问题：
   - 如果用户选择“是的，让我指定”并在“其他”中提供了文本，则包括这些要求
   - 如果用户选择“没有，就这些”，则在没有额外要求的情况下继续
4. 将所有答案与原始请求结合

### 步骤 5：生成优化提示

使用收集到的信息，创建一个完整、结构良好的提示：

```markdown
## 优化后的提示（基于您的答案）

[将原始意图 + 用户的答案结合成结构化提示]

**技术**：[答案 1]
**样式**：[答案 2]
**功能**：[答案 3，答案 4，...]

[完整详细要求...]
```

### 步骤 6：确认并继续

询问用户优化后的提示是否看起来不错，或者他们是否想调整任何内容：

```markdown
### 这样可以吗？

1. ✅ 可以，继续使用此规格
2. 🔄 我想调整一些细节
3. ➕ 添加更多要求
```

### 示例互动流程

**用户**：“生成个按钮”

**提示优化器（互动模式）**：
```
我会通过几个问题来帮你明确需求。

[调用 AskUserQuestion 提出 4 个针对性问题]

问题 1：使用什么技术栈？
- React + TypeScript
- React + JavaScript
- Vue 3
- 其他

问题 2：使用什么样式方案？
- Tailwind CSS
- CSS Modules
- styled-components
- 其他

问题 3：需要哪些功能？（可多选）
- 多种变体（primary、secondary、danger等）
- 多种尺寸（sm、md、lg）
- Loading 状态
- Disabled 状态

问题 4：还有其他需求或约束吗？
- 不需要，就这些
- 需要，让我补充（可以在“其他”中输入）
```

**示例 1 - 用户没有额外需求**：
用户选择：React + TypeScript，Tailwind CSS，[多种变体，Loading 状态]，“不需要，就这些”

**提示优化器**：
```
## 优化后的需求

基于你的选择，这是完整的需求规格：

创建一个 React Button 组件，使用 TypeScript 和 Tailwind CSS。

技术栈：
- React + TypeScript
- Tailwind CSS 样式

功能需求：
- 支持多种变体：primary（蓝色）、secondary（灰色）、danger（红色）
- 支持 loading 状态（显示 spinner）
- Props 定义：
  - variant: 'primary' | 'secondary' | 'danger'
  - loading?: boolean
  - onClick?: () => void
  - children: React.ReactNode
  - className?: string

这样可以吗？
1. ✅ 可以，开始生成
2. 🔄 我想调整一下
```

**示例 2 - 用户有额外需求**：
用户选择：React + TypeScript，Tailwind CSS，[多种变体，Loading 状态]，“其他：需要支持图标，并且要有 fullWidth 选项让按钮占满整行”

**提示优化器**：
```
## 优化后的需求

基于你的选择，这是完整的需求规格：

创建一个 React Button 组件，使用 TypeScript 和 Tailwind CSS。

技术栈：
- React + TypeScript
- Tailwind CSS 样式

功能需求：
- 支持多种变体：primary（蓝色）、secondary（灰色）、danger（红色）
- 支持 loading 状态（显示 spinner）
- ✨ 支持图标显示（用户补充）
- ✨ 支持 fullWidth 选项让按钮占满整行（用户补充）

Props 定义：
  - variant: 'primary' | 'secondary' | 'danger'
  - loading?: boolean
  - icon?: React.ReactNode
  - iconPosition?: 'left' | 'right'
  - fullWidth?: boolean
  - onClick?: () => void
  - children: React.ReactNode
  - className?: string

这样可以吗？
1. ✅ 可以，开始生成
2. 🔄 我想调整一下
```

---

## 输出格式

将输出结构化如下：

```markdown
## 提示分析

### 原始提示
[用户的原始请求]

### 识别的问题

**清晰度**：
- [问题 1]
- [问题 2]

**具体性**：
- [问题 1]
- [问题 2]

**完整性**：
- [问题 1]

[其他类别如适用]

### 优化提示

[改进的、结构良好的版本]

### 关键改进
- ✅ [改进 1]
- ✅ [改进 2]
- ✅ [改进 3]

### 下一步
您想让我：
1. 继续使用优化提示？
2. 根据您的反馈进一步完善？
3. 专注于某个特定方面？
```

## 示例工作流程

### 示例 1：模糊代码请求

**用户**：“做一个按钮”

**分析**：
- 缺失：语言/框架
- 缺失：样式要求
- 缺失：功能细节
- 缺失：props/API

**优化**：
```
创建一个可重用的 Button 组件，使用 React 和 TypeScript 以及 Tailwind CSS。

要求：
- 支持变体：primary、secondary、danger
- 支持尺寸：sm、md、lg
- 接受 onClick 处理程序和 children
- 包含 loading 和 disabled 状态
- 为所有 props 提供适当的 TypeScript 类型

示例用法：
<Button variant="primary" size="md" onClick={handleClick}>
  点击我
</Button>
```

### 示例 2：不完整的错误报告

**用户**：“应用崩溃了”

**分析**：
- 缺失：崩溃的地点/时间
- 缺失：错误信息
- 缺失：重现步骤
- 缺失：期望行为

**优化**：
```
调试并修复购物车组件中的崩溃问题。

当前行为：
- 点击“结账”按钮时应用崩溃
- 仅在购物车中有超过 5 个项目时
- 控制台错误：“无法读取未定义的属性 'price'”

位置：
- 文件：src/components/ShoppingCart.tsx
- 在最近的定价逻辑重构后开始

期望行为：
- 无论购物车大小，结账按钮都应正常工作
- 应导航到结账页面

重现步骤：
1. 向购物车添加 6 个以上的项目
2. 点击“结账”按钮
3. 观察崩溃
```

### 示例 3：宽泛请求

**用户**：“构建一个仪表板”

**分析**：
- 过于宽泛，没有范围
- 缺失：要显示的数据
- 缺失：技术要求
- 缺失：设计要求

**优化**：
```
创建一个响应式分析仪表板，具有以下要求：

要显示的数据：
- 用户统计（总用户、活跃用户、新注册用户）
- 收入指标（每日、每周、每月）
- 流量来源（图表显示细分）
- 最近活动记录

技术要求：
- 使用 React 和 TypeScript
- 图表库：Chart.js 或 Recharts
- 状态管理：Zustand
- 样式：Tailwind CSS
- 响应式设计（移动、平板、桌面）

功能：
- 日期范围过滤器
- 数据刷新按钮
- CSV 导出功能
- 数据获取的加载状态

布局：
- 顶部的统计卡片网格布局
- 中间部分的图表
- 侧边或底部的活动记录
```

## 质量标准参考

请参考 `references/optimization-principles.md` 获取：

- **提示质量检查表** - 系统评估标准
- **常见提示模式** - 不同请求类型的模板
- **红旗** - 差提示质量的指标
- **优化策略** - 按问题类型的技术
- **完整示例** - 优化前后的示例

## 特殊情况

### 当提示已经很好时

如果用户的提示已经清晰、具体且完整：
1. 认可提示的质量
2. 注明其有效性
3. 直接进行任务
4. 不要过度优化

### 当需要澄清时

如果缺少关键信息且无法合理假设：
1. 确定缺失内容
2. 提出针对性的澄清问题
3. 在适用时提供选项
4. 建议他们答案的框架

### 当存在多种解释时

如果提示含糊不清：
1. 确定不同的可能解释
2. 清晰地向用户呈现
3. 询问哪个解释是正确的
4. 或者建议最可能的解释并请求确认

### 当请求过于宽泛时

如果范围不切实际：
1. 将其分解为阶段或组件
2. 建议从特定部分开始
3. 提供优先级列表
4. 推荐 MVP 方法

## 与其他技能的集成

### 在其他技能激活之前

此技能可以作为“预处理器”：
1. 首先优化提示
2. 优化后的提示触发适当的技能
3. 其他技能在更清晰的要求下工作

### 与 request-analyzer 一起工作

当 `request-analyzer` 技能可用时：
- `request-analyzer` 识别何时需要优化
- `prompt-optimizer` 执行优化
- 然后 `request-analyzer` 可以重新分析优化后的提示

## 最佳实践

1. **提供帮助，而不是教条** - 关注有意义的改进
2. **保持用户意图** - 不要改变他们的请求
3. **增加价值** - 仅在真正有帮助时进行优化
4. **简洁** - 不要过度解释显而易见的变化
5. **保持尊重** - 将其框定为有帮助的增强，而不是批评
6. **提供选项** - 当存在多个有效解释时
7. **知道何时跳过** - 如果提示已经很好，直接进行

## 重要说明

- 始终保留用户的核心意图和目标
- 除非必要，否则不要对技术选择做出假设
- 在做出假设时清楚标记
- 提供根据用户反馈进行进一步完善的选项
- 有时提出澄清问题比假设更好
- 在全面性和实用性之间取得平衡
- 目标是更好的结果，而不是完美的提示
