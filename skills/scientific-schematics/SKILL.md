---
name: scientific-schematics
description: "使用 Nano Banana Pro AI 创建出版质量的科学图表，通过智能迭代优化。使用 Gemini 3 Pro 进行质量审核。仅在质量低于您文档类型的阈值时重新生成。专注于神经网络架构、系统图、流程图、生物途径和复杂科学可视化。"
allowed-tools: [Read, Write, Edit, Bash]
---

# 科学图表和图示

## 概述

科学图表和图示将复杂概念转化为清晰的视觉表示，以便出版。**此技能使用 Nano Banana Pro AI 生成图表，并通过 Gemini 3 Pro 进行质量审核。**

**工作原理：**
- 用自然语言描述您的图表
- Nano Banana Pro 自动生成出版质量的图像
- **Gemini 3 Pro 根据文档类型阈值审核质量**
- **智能迭代**：仅在质量低于阈值时重新生成
- 几分钟内输出可出版的结果
- 无需编码、模板或手动绘图

**按文档类型的质量阈值：**
| 文档类型 | 阈值 | 描述 |
|-----------|------|------|
| journal | 8.5/10 | Nature, Science, 同行评审期刊 |
| conference | 8.0/10 | 会议论文 |
| thesis | 8.0/10 | 学位论文、毕业论文 |
| grant | 8.0/10 | 资助提案 |
| preprint | 7.5/10 | arXiv, bioRxiv 等 |
| report | 7.5/10 | 技术报告 |
| poster | 7.0/10 | 学术海报 |
| presentation | 6.5/10 | 幻灯片、演讲 |
| default | 7.5/10 | 一般用途 |

**只需描述您想要的内容，Nano Banana Pro 就会创建它。** 所有图表存储在 figures/ 子文件夹中，并在论文/海报中引用。

## 快速开始：生成任何图表

只需描述即可创建任何科学图表。Nano Banana Pro 自动处理所有内容，采用 **智能迭代**：

```bash
# 为期刊论文生成（最高质量阈值：8.5/10）
python scripts/generate_schematic.py "CONSORT 参与者流动图，500 名筛查，150 名排除，350 名随机" -o figures/consort.png --doc-type journal

# 为演示生成（较低阈值：6.5/10 - 更快）
python scripts/generate_schematic.py "显示多头注意力的变压器编码器-解码器架构" -o figures/transformer.png --doc-type presentation

# 为海报生成（中等阈值：7.0/10）
python scripts/generate_schematic.py "从 EGFR 到基因转录的 MAPK 信号通路" -o figures/mapk_pathway.png --doc-type poster

# 自定义最大迭代次数（最多 2 次）
python scripts/generate_schematic.py "包含运算放大器、电阻和电容的复杂电路图" -o figures/circuit.png --iterations 2 --doc-type journal
```

**后台发生了什么：**
1. **生成 1**：Nano Banana Pro 创建遵循科学图表最佳实践的初始图像
2. **审核 1**：**Gemini 3 Pro** 根据文档类型阈值评估质量
3. **决策**：如果质量 >= 阈值 → **完成**（无需更多迭代！）
4. **如果低于阈值**：根据批评改进提示，重新生成
5. **重复**：直到质量达到阈值或达到最大迭代次数

**智能迭代的好处：**
- ✅ 如果第一次生成足够好，则节省 API 调用
- ✅ 对于期刊论文，标准更高
- ✅ 演示/海报的周转更快
- ✅ 每种用例的适当质量

**输出**：版本化图像以及详细的审核日志，包含质量评分、批评和提前停止信息。

### 配置

设置您的 OpenRouter API 密钥：
```bash
export OPENROUTER_API_KEY='your_api_key_here'
```

获取 API 密钥： https://openrouter.ai/keys

### AI 生成最佳实践

**科学图表的有效提示：**

✓ **好的提示**（具体、详细）：
- "显示参与者流动的 CONSORT 流程图，从筛查（n=500）到随机化再到最终分析"
- "变压器神经网络架构，左侧为编码器堆栈，右侧为解码器堆栈，显示多头注意力和交叉注意力连接"
- "生物信号级联：EGFR 受体 → RAS → RAF → MEK → ERK → 细胞核，标记磷酸化步骤"
- "物联网系统的框图：传感器 → 微控制器 → WiFi 模块 → 云服务器 → 移动应用"

✗ **避免模糊提示**：
- "制作一个流程图"（过于通用）
- "神经网络"（哪种类型？什么组件？）
- "途径图"（哪个途径？什么分子？）

**要包含的关键元素：**
- **类型**：流程图、架构图、途径、电路等
- **组件**：要包含的具体元素
- **流/方向**：元素如何连接（从左到右、从上到下）
- **标签**：要包含的关键注释或文本
- **样式**：任何特定的视觉要求

**科学质量指南**（自动应用）：
- 干净的白色/浅色背景
- 高对比度以提高可读性
- 清晰、可读的标签（最小 10pt）
- 专业排版（无衬线字体）
- 适合色盲的颜色（Okabe-Ito 调色板）
- 适当的间距以防止拥挤
- 适当的比例尺、图例、坐标轴

## 何时使用此技能

当需要时应使用此技能：
- 创建神经网络架构图（变压器、CNN、RNN 等）
- 说明系统架构和数据流图
- 绘制研究设计的方法流程图（CONSORT、PRISMA）
- 可视化算法工作流和处理管道
- 创建电路图和电气原理图
- 描绘生物途径和分子相互作用
- 生成网络拓扑和层次结构
- 说明概念框架和理论模型
- 为技术论文设计框图

## 如何使用此技能

**只需用自然语言描述您的图表。** Nano Banana Pro 会自动生成：

```bash
python scripts/generate_schematic.py "您的图表描述" -o output.png
```

**就是这样！** AI 处理：
- ✓ 布局和构图
- ✓ 标签和注释
- ✓ 颜色和样式
- ✓ 质量审核和优化
- ✓ 可出版的输出

**适用于所有图表类型：**
- 流程图（CONSORT、PRISMA 等）
- 神经网络架构
- 生物途径
- 电路图
- 系统架构
- 框图
- 任何科学可视化

**无需编码，无需模板，无需手动绘图。**

---

# AI 生成模式（Nano Banana Pro + Gemini 3 Pro 审核）

## 智能迭代优化工作流程

AI 生成系统使用 **智能迭代** - 仅在质量低于您文档类型的阈值时重新生成：

### 智能迭代的工作原理

```
┌─────────────────────────────────────────────────────┐
│  1. 使用 Nano Banana Pro 生成图像                 │
│                    ↓                                │
│  2. 使用 Gemini 3 Pro 审核质量                     │
│                    ↓                                │
│  3. 分数 >= 阈值？                                 │
│       是 → 完成！（提前停止）                      │
│       否  → 改进提示，返回第 1 步                  │
│                    ↓                                │
│  4. 重复直到达到质量或达到最大迭代次数            │
└─────────────────────────────────────────────────────┘
```

### 迭代 1：初始生成
**提示构建：**
```
科学图表指南 + 用户请求
```

**输出：** `diagram_v1.png`

### Gemini 3 Pro 的质量审核

Gemini 3 Pro 根据以下标准评估图表：
1. **科学准确性**（0-2 分） - 概念、符号、关系的正确性
2. **清晰度和可读性**（0-2 分） - 易于理解，层次清晰
3. **标签质量**（0-2 分） - 完整、可读、一致的标签
4. **布局和构图**（0-2 分） - 合理流动，平衡，无重叠
5. **专业外观**（0-2 分） - 可出版质量

**示例审核输出：**
```
得分：8.0

优点：
- 从上到下的清晰流动
- 所有阶段均已正确标记
- 专业排版

问题：
- 参与者计数略小
- 排除框上有轻微重叠

裁定：可接受（对于海报，阈值 7.0）
```

### 决策点：继续还是停止？

| 如果得分... | 行动 |
|-------------|------|
| >= 阈值 | **停止** - 质量足够好，适合此文档类型 |
| < 阈值 | 继续下一次迭代，改进提示 |

**示例：**
- 对于 **海报**（阈值 7.0）：得分 7.5 → **完成，经过 1 次迭代！**
- 对于 **期刊**（阈值 8.5）：得分 7.5 → 继续改进

### 后续迭代（仅在需要时）

如果质量低于阈值，系统：
1. 从 Gemini 3 Pro 的审核中提取具体问题
2. 根据改进说明增强提示
3. 使用 Nano Banana Pro 重新生成
4. 再次使用 Gemini 3 Pro 审核
5. 重复直到达到阈值或达到最大迭代次数

### 审核日志
所有迭代都保存为 JSON 审核日志，包含提前停止信息：
```json
{
  "user_prompt": "CONSORT 参与者流动图...",
  "doc_type": "poster",
  "quality_threshold": 7.0,
  "iterations": [
    {
      "iteration": 1,
      "image_path": "figures/consort_v1.png",
      "score": 7.5,
      "needs_improvement": false,
      "critique": "得分：7.5\n优点：..."
    }
  ],
  "final_score": 7.5,
  "early_stop": true,
  "early_stop_reason": "质量得分 7.5 满足海报的阈值 7.0"
}
```

**注意：** 通过智能迭代，如果质量早期达到，您可能只会看到 1 次迭代，而不是完整的 2 次！

## 高级 AI 生成使用

### Python API

```python
from scripts.generate_schematic_ai import ScientificSchematicGenerator

# 初始化生成器
generator = ScientificSchematicGenerator(
    api_key="your_openrouter_key",
    verbose=True
)

# 使用迭代优化生成（最多 2 次迭代）
results = generator.generate_iterative(
    user_prompt="变压器架构图",
    output_path="figures/transformer.png",
    iterations=2
)

# 访问结果
print(f"最终得分：{results['final_score']}/10")
print(f"最终图像：{results['final_image']}")

# 审核各个迭代
for iteration in results['iterations']:
    print(f"迭代 {iteration['iteration']}：{iteration['score']}/10")
    print(f"批评：{iteration['critique']}")
```

### 命令行选项

```bash
# 基本用法（默认阈值 7.5/10）
python scripts/generate_schematic.py "图表描述" -o output.png

# 指定文档类型以获得适当的质量阈值
python scripts/generate_schematic.py "图表" -o out.png --doc-type journal      # 8.5/10
python scripts/generate_schematic.py "图表" -o out.png --doc-type conference   # 8.0/10
python scripts/generate_schematic.py "图表" -o out.png --doc-type poster       # 7.0/10
python scripts/generate_schematic.py "图表" -o out.png --doc-type presentation # 6.5/10

# 自定义最大迭代次数（1-2）
python scripts/generate_schematic.py "复杂图表" -o diagram.png --iterations 2

# 详细输出（查看所有 API 调用和审核）
python scripts/generate_schematic.py "流程图" -o flow.png -v

# 通过标志提供 API 密钥
python scripts/generate_schematic.py "图表" -o out.png --api-key "sk-or-v1-..."

# 组合选项
python scripts/generate_schematic.py "神经网络" -o nn.png --doc-type journal --iterations 2 -v
```

### 提示工程技巧

**1. 明确布局：**
```
✓ "流程图，垂直流动，从上到下"
✓ "架构图，左侧为编码器，右侧为解码器"
✓ "圆形途径图，顺时针流动"
```

**2. 包含定量细节：**
```
✓ "神经网络，输入层（784 节点）、隐藏层（128 节点）、输出（10 节点）"
✓ "流程图，显示 n=500 筛查，n=150 排除，n=350 随机"
✓ "电路，包含 1kΩ 电阻、10µF 电容、5V 电源"
```

**3. 指定视觉风格：**
```
✓ "极简框图，线条干净"
✓ "详细的生物途径，包含蛋白质结构"
✓ "技术原理图，使用工程符号"
```

**4. 请求特定标签：**
```
✓ "标记所有箭头为激活/抑制"
✓ "在每个框中包含层的维度"
✓ "用时间进度标记时间戳"
```

**5. 提及颜色要求：**
```
✓ "使用适合色盲的颜色"
✓ "灰度兼容设计"
✓ "按功能进行颜色编码：输入为蓝色，处理为绿色，输出为红色"
```

## AI 生成示例

### 示例 1：CONSORT 流程图
```bash
python scripts/generate_schematic.py \
  "CONSORT 参与者流动图，随机对照试验。\
   从顶部开始，'评估资格（n=500）'。\
   显示'排除（n=150）'及原因：年龄<18（n=80），拒绝（n=50），其他（n=20）。\
   然后'随机（n=350）'分为两个组：\
   '治疗组（n=175）'和'对照组（n=175）'。\
   每组显示'失访'（n=15 和 n=10）。\
   最后以'分析'（n=160 和 n=165）结束。\
   使用蓝色框表示过程步骤，橙色表示排除，绿色表示最终分析。" \
  -o figures/consort.png
```

### 示例 2：神经网络架构
```bash
python scripts/generate_schematic.py \
  "变压器编码器-解码器架构图。\
   左侧：编码器堆栈，包含输入嵌入、位置编码、\
   多头自注意力、加和归一化、前馈、加和归一化。\
   右侧：解码器堆栈，包含输出嵌入、位置编码、\
   掩蔽自注意力、加和归一化、交叉注意力（接收来自编码器），\
   加和归一化、前馈、加和归一化、线性和 softmax。\
   显示编码器到解码器的交叉注意力连接，使用虚线。\
   编码器使用浅蓝色，解码器使用浅红色。\
   清晰标记所有组件。" \
  -o figures/transformer.png --iterations 2
```

### 示例 3：生物途径
```bash
python scripts/generate_schematic.py \
  "MAPK 信号通路图。\
   从细胞膜顶部开始 EGFR 受体。\
   箭头指向 RAS（标记 GTP）。\
   箭头指向 RAF 激酶。\
   箭头指向 MEK 激酶。\
   箭头指向 ERK 激酶。\
   最后箭头指向细胞核，显示基因转录。\
   标记每个箭头为'磷酸化'或'激活'。\
   使用圆角矩形表示蛋白质，使用不同颜色。\
   在顶部包含膜边界线。" \
  -o figures/mapk_pathway.png
```

### 示例 4：系统架构
```bash
python scripts/generate_schematic.py \
  "物联网系统架构框图。\
   底层：传感器（温度、湿度、运动）用绿色框表示。\
   中间层：微控制器（ESP32）用蓝色框表示。\
   连接到 WiFi 模块（橙色框）和显示器（紫色框）。\
   顶层：云服务器（灰色框）连接到移动应用（浅蓝色框）。\
   显示所有组件之间的数据流箭头。\
   用协议标记连接：I2C、UART、WiFi、HTTPS。" \
  -o figures/iot_architecture.png
```

---

## 命令行用法

生成科学示意图的主要入口点：

```bash
# 基本用法
python scripts/generate_schematic.py "图表描述" -o output.png

# 自定义迭代次数（最多 2 次）
python scripts/generate_schematic.py "复杂图表" -o diagram.png --iterations 2

# 详细模式
python scripts/generate_schematic.py "图表" -o out.png -v
```

**注意：** Nano Banana Pro AI 生成系统在其迭代优化过程中包括自动质量审核。每次迭代都评估科学准确性、清晰度和可访问性。

## 最佳实践总结

### 设计原则

1. **清晰优于复杂** - 简化，去除不必要的元素
2. **一致的样式** - 使用模板和样式文件
3. **色盲可访问性** - 使用 Okabe-Ito 调色板，冗余编码
4. **适当的排版** - 无衬线字体，最小 7-8 pt
5. **矢量格式** - 始终使用 PDF/SVG 进行出版

### 技术要求

1. **分辨率** - 优先使用矢量，或光栅图像 300+ DPI
2. **文件格式** - PDF 用于 LaTeX，SVG 用于网页，PNG 作为后备
3. **颜色空间** - 数字使用 RGB，打印使用 CMYK（如有需要转换）
4. **线宽** - 最小 0.5 pt，典型 1-2 pt
5. **文本大小** - 最小 7-8 pt 在最终尺寸下

### 集成指南

1. **在 LaTeX 中包含** - 使用 `\includegraphics{}` 引入生成的图像
2. **详细说明标题** - 描述所有元素和缩写
3. **在文本中引用** - 在叙述中解释图表
4. **保持一致性** - 论文中所有图形使用相同样式
5. **版本控制** - 将提示和生成的图像保存在库中

## 常见问题排查

### AI 生成问题

**问题**：文本或元素重叠
- **解决方案**：AI 生成自动处理间距
- **解决方案**：增加迭代次数：`--iterations 2` 以获得更好的优化

**问题**：元素连接不正确
- **解决方案**：使您的提示更具体，说明连接和布局
- **解决方案**：增加迭代次数以获得更好的优化

### 图像质量问题

**问题**：导出质量差
- **解决方案**：AI 生成自动产生高质量图像
- **解决方案**：增加迭代次数以获得更好的结果：`--iterations 2`

**问题**：生成后元素重叠
- **解决方案**：AI 生成自动处理间距
- **解决方案**：增加迭代次数：`--iterations 2` 以获得更好的优化
- **解决方案**：使您的提示更具体，说明布局和间距要求

### 质量检查问题

**问题**：错误的重叠检测
- **解决方案**：调整阈值：`detect_overlaps(image_path, threshold=0.98)`
- **解决方案**：在视觉报告中手动审核标记区域

**问题**：生成的图像质量低
- **解决方案**：AI 生成默认产生高质量图像
- **解决方案**：增加迭代次数以获得更好的结果：`--iterations 2`

**问题**：色盲模拟显示对比度差
- **解决方案**：在代码中明确切换到 Okabe-Ito 调色板
- **解决方案**：添加冗余编码（形状、图案、线条样式）
- **解决方案**：增加颜色饱和度和亮度差异

**问题**：检测到高严重性重叠
- **解决方案**：查看 overlap_report.json 以获取确切位置
- **解决方案**：在这些特定区域增加间距
- **解决方案**：重新运行并调整参数，再次验证

**问题**：视觉报告生成失败
- **解决方案**：检查 Pillow 和 matplotlib 安装
- **解决方案**：确保图像文件可读：`Image.open(path).verify()`
- **解决方案**：检查报告生成的磁盘空间是否足够

### 可访问性问题

**问题**：灰度中颜色无法区分
- **解决方案**：运行可访问性检查器：`verify_accessibility(image_path)`
- **解决方案**：为冗余添加图案、形状或线条样式
- **解决方案**：增加相邻元素之间的对比度

**问题**：打印时文本过小
- **解决方案**：运行分辨率验证器：`validate_resolution(image_path)`
- **解决方案**：在最终尺寸下设计，使用最小 7-8 pt 字体
- **解决方案**：检查分辨率报告中的物理尺寸

**问题**：可访问性检查持续失败
- **解决方案**：查看 accessibility_report.json 以获取具体失败信息
- **解决方案**：将颜色对比度提高至少 20%
- **解决方案**：在最终确定之前进行实际的灰度转换测试

## 资源和参考

### 详细参考

加载这些文件以获取特定主题的全面信息：

- **`references/diagram_types.md`** - 科学图表类型目录及示例
- **`references/best_practices.md`** - 出版标准和可访问性指南

### 外部资源

**Python 库**
- Schemdraw 文档：https://schemdraw.readthedocs.io/
- NetworkX 文档：https://networkx.org/documentation/
- Matplotlib 文档：https://matplotlib.org/

**出版标准**
- Nature 图形指南：https://www.nature.com/nature/for-authors/final-submission
- Science 图形指南：https://www.science.org/content/page/instructions-preparing-initial-manuscript
- CONSORT 图表：http://www.consort-statement.org/consort-statement/flow-diagram

## 与其他技能的集成

此技能与以下内容协同工作：

- **科学写作** - 图表遵循图形最佳实践
- **科学可视化** - 共享调色板和样式
- **LaTeX 海报** - 为海报演示生成图表
- **研究资助** - 提案的方法图表
- **同行评审** - 评估图表的清晰度和可访问性

## 快速参考检查清单

在提交图表之前，请验证：

### 视觉质量
- [ ] 高质量图像格式（来自 AI 生成的 PNG）
- [ ] 无重叠元素（AI 自动处理）
- [ ] 所有组件之间有足够的间距（AI 优化）
- [ ] 干净、专业的对齐
- [ ] 所有箭头正确连接到目标

### 可访问性
- [ ] 使用色盲安全调色板（Okabe-Ito）
- [ ] 在灰度中有效（通过可访问性检查器测试）
- [ ] 元素之间有足够的对比度（已验证）
- [ ] 在适当的地方进行冗余编码（形状 + 颜色）
- [ ] 色盲模拟通过所有检查

### 排版和可读性
- [ ] 文本在最终尺寸下最小 7-8 pt
- [ ] 所有元素清晰、完整地标记
- [ ] 字体系列和大小一致
- [ ] 无文本重叠或截断
- [ ] 在适用情况下包含单位

### 出版标准
- [ ] 与手稿中其他图形样式一致
- [ ] 撰写全面的标题，定义所有缩写
- [ ] 在手稿文本中适当引用
- [ ] 满足期刊特定的尺寸要求
- [ ] 以期刊要求的格式导出（PDF/EPS/TIFF）

### 质量验证（必需）
- [ ] 运行 `run_quality_checks()` 并获得通过状态
- [ ] 审核重叠检测报告（零高严重性重叠）
- [ ] 通过可访问性验证（灰度和色盲）
- [ ] 在目标 DPI 下验证分辨率（打印需 300+）
- [ ] 生成并审核视觉质量报告
- [ ] 将所有质量报告与图形文件一起保存

### 文档和版本控制
- [ ] 源文件（.tex, .py）保存以供将来修订
- [ ] 质量报告归档在 `quality_reports/` 目录中
- [ ] 配置参数文档化（颜色、间距、尺寸）
- [ ] Git 提交包括源、输出和质量报告
- [ ] README 或注释解释如何重新生成图形

### 最终集成检查
- [ ] 图形在编译的手稿中正确显示
- [ ] 交叉引用工作（`\ref{}` 指向正确的图形）
- [ ] 图形编号与文本引用匹配
- [ ] 标题在图形相对的正确页面上出现
- [ ] 没有与图形相关的编译警告或错误

## 环境设置

```bash
# 必需
export OPENROUTER_API_KEY='your_api_key_here'

# 在： https://openrouter.ai/keys 获取密钥
```

## 开始使用

**最简单的用法：**
```bash
python scripts/generate_schematic.py "您的图表描述" -o output.png
```

---

使用此技能创建清晰、可访问的出版质量图表，有效传达复杂的科学概念。AI 驱动的工作流程与迭代优化确保图表符合专业标准。