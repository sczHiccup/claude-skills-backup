---
name: perplexity-search
description: 使用 Perplexity 模型通过 LiteLLM 和 OpenRouter 执行 AI 驱动的网页搜索，获取实时信息。该技能应在进行当前信息的网页搜索、查找最新科学文献、获取带有来源引用的可靠答案或访问超出模型知识截止日期的信息时使用。通过单个 OpenRouter API 密钥提供对多个 Perplexity 模型的访问，包括 Sonar Pro、Sonar Pro Search（高级代理搜索）和 Sonar Reasoning Pro。
---

# Perplexity Search

## 概述

通过 LiteLLM 和 OpenRouter 使用 Perplexity 模型执行 AI 驱动的网页搜索。Perplexity 提供实时的、基于网络的答案和来源引用，非常适合查找当前信息、最新的科学文献以及超出模型训练数据截止日期的事实。

该技能通过 OpenRouter 提供对所有 Perplexity 模型的访问，只需一个 API 密钥（无需单独的 Perplexity 账户）。

## 何时使用此技能

在以下情况下使用此技能：
- 搜索当前信息或最新动态（2024 年及以后）
- 查找最新的科学出版物和研究
- 获取基于网络来源的实时答案
- 使用来源引用验证事实
- 在多个领域进行文献搜索
- 访问超出模型知识截止日期的信息
- 执行特定领域的研究（生物医学、技术、临床）
- 比较当前的方法或技术

**请勿用于**：
- 简单计算或逻辑问题（直接使用）
- 需要代码执行的任务（使用标准工具）
- 在模型训练数据范围内的问题（除非需要验证）

## 快速开始

### 设置（一次性）

1. **获取 OpenRouter API 密钥**：
   - 访问 https://openrouter.ai/keys
   - 创建账户并生成 API 密钥
   - 向账户添加积分（建议最低 $5）

2. **配置环境**：
   ```bash
   # 设置 API 密钥
   export OPENROUTER_API_KEY='sk-or-v1-your-key-here'

   # 或使用设置脚本
   python scripts/setup_env.py --api-key sk-or-v1-your-key-here
   ```

3. **安装依赖**：
   ```bash
   uv pip install litellm
   ```

4. **验证设置**：
   ```bash
   python scripts/perplexity_search.py --check-setup
   ```

有关详细的设置说明、故障排除和安全最佳实践，请参见 `references/openrouter_setup.md`。

### 基本用法

**简单搜索：**
```bash
python scripts/perplexity_search.py "What are the latest developments in CRISPR gene editing?"
```

**保存结果：**
```bash
python scripts/perplexity_search.py "Recent CAR-T therapy clinical trials" --output results.json
```

**使用特定模型：**
```bash
python scripts/perplexity_search.py "Compare mRNA and viral vector vaccines" --model sonar-pro-search
```

**详细输出：**
```bash
python scripts/perplexity_search.py "Quantum computing for drug discovery" --verbose
```

## 可用模型

通过 `--model` 参数访问模型：

- **sonar-pro**（默认）：通用搜索，成本和质量的最佳平衡
- **sonar-pro-search**：最先进的代理搜索，具有多步骤推理
- **sonar**：基本模型，最具成本效益的简单查询
- **sonar-reasoning-pro**：高级推理，逐步分析
- **sonar-reasoning**：基本推理能力

**模型选择指南：**
- 默认查询 → `sonar-pro`
- 复杂的多步骤分析 → `sonar-pro-search`
- 需要明确推理 → `sonar-reasoning-pro`
- 简单事实查找 → `sonar`
- 成本敏感的大宗查询 → `sonar`

有关详细比较、用例、定价和性能特征，请参见 `references/model_comparison.md`。

## 制作有效查询

### 具体且详细

**好的例子：**
- "What are the latest clinical trial results for CAR-T cell therapy in treating B-cell lymphoma published in 2024?"
- "Compare the efficacy and safety profiles of mRNA vaccines versus viral vector vaccines for COVID-19"
- "Explain AlphaFold3 improvements over AlphaFold2 with specific accuracy metrics from 2023-2024 research"

**不好的例子：**
- "Tell me about cancer treatment"（过于宽泛）
- "CRISPR"（过于模糊）
- "vaccines"（缺乏具体性）

### 包含时间限制

Perplexity 搜索实时网络数据：
- "What papers were published in Nature Medicine in 2024 about long COVID?"
- "What are the latest developments (past 6 months) in large language model efficiency?"
- "What was announced at NeurIPS 2023 regarding AI safety?"

### 指定领域和来源

为了获得高质量结果，请提及来源偏好：
- "According to peer-reviewed publications in high-impact journals..."
- "Based on FDA-approved treatments..."
- "From clinical trial registries like clinicaltrials.gov..."

### 结构化复杂查询

将复杂问题分解为清晰的组成部分：
1. **主题**：主要主题
2. **范围**：感兴趣的具体方面
3. **背景**：时间框架、领域、限制
4. **输出**：所需格式或答案类型

**示例：**
"What improvements does AlphaFold3 offer over AlphaFold2 for protein structure prediction, according to research published between 2023 and 2024? Include specific accuracy metrics and benchmarks."

有关查询设计、领域特定模式和高级技术的全面指导，请参见 `references/search_strategies.md`。

## 常见用例

### 科学文献搜索

```bash
python scripts/perplexity_search.py \
  "What does recent research (2023-2024) say about the role of gut microbiome in Parkinson's disease? Focus on peer-reviewed studies and include specific bacterial species identified." \
  --model sonar-pro
```

### 技术文档

```bash
python scripts/perplexity_search.py \
  "How to implement real-time data streaming from Kafka to PostgreSQL using Python? Include considerations for handling backpressure and ensuring exactly-once semantics." \
  --model sonar-reasoning-pro
```

### 比较分析

```bash
python scripts/perplexity_search.py \
  "Compare PyTorch versus TensorFlow for implementing transformer models in terms of ease of use, performance, and ecosystem support. Include benchmarks from recent studies." \
  --model sonar-pro-search
```

### 临床研究

```bash
python scripts/perplexity_search.py \
  "What is the evidence for intermittent fasting in managing type 2 diabetes in adults? Focus on randomized controlled trials and report HbA1c changes and weight loss outcomes." \
  --model sonar-pro
```

### 趋势分析

```bash
python scripts/perplexity_search.py \
  "What are the key trends in single-cell RNA sequencing technology over the past 5 years? Highlight improvements in throughput, cost, and resolution, with specific examples." \
  --model sonar-pro
```

## 处理结果

### 程序化访问

将 `perplexity_search.py` 作为模块使用：

```python
from scripts.perplexity_search import search_with_perplexity

result = search_with_perplexity(
    query="What are the latest CRISPR developments?",
    model="openrouter/perplexity/sonar-pro",
    max_tokens=4000,
    temperature=0.2,
    verbose=False
)

if result["success"]:
    print(result["answer"])
    print(f"Tokens used: {result['usage']['total_tokens']}")
else:
    print(f"Error: {result['error']}")
```

### 保存和处理结果

```bash
# 保存为 JSON
python scripts/perplexity_search.py "query" --output results.json

# 使用 jq 处理
cat results.json | jq '.answer'
cat results.json | jq '.usage'
```

### 批量处理

创建一个脚本以处理多个查询：

```bash
#!/bin/bash
queries=(
  "CRISPR developments 2024"
  "mRNA vaccine technology advances"
  "AlphaFold3 accuracy improvements"
)

for query in "${queries[@]}"; do
  echo "Searching: $query"
  python scripts/perplexity_search.py "$query" --output "results_$(echo $query | tr ' ' '_').json"
  sleep 2  # 限制速率
done
```

## 成本管理

Perplexity 模型有不同的定价等级：

**每个查询的估计成本：**
- Sonar: $0.001-0.002（最具成本效益）
- Sonar Pro: $0.002-0.005（推荐的默认值）
- Sonar Reasoning Pro: $0.005-0.010
- Sonar Pro Search: $0.020-0.050+（最全面）

**成本优化策略：**
1. 对于简单事实查找使用 `sonar`
2. 对于大多数查询默认使用 `sonar-pro`
3. 将 `sonar-pro-search` 保留用于复杂分析
4. 设置 `--max-tokens` 限制响应长度
5. 在 https://openrouter.ai/activity 监控使用情况
6. 在 OpenRouter 仪表板中设置支出限制

## 故障排除

### API 密钥未设置

**错误**：“OpenRouter API key not configured”

**解决方案**：
```bash
export OPENROUTER_API_KEY='sk-or-v1-your-key-here'
# 或运行设置脚本
python scripts/setup_env.py --api-key sk-or-v1-your-key-here
```

### LiteLLM 未安装

**错误**：“LiteLLM not installed”

**解决方案**：
```bash
uv pip install litellm
```

### 速率限制

**错误**：“Rate limit exceeded”

**解决方案**：
- 等待几秒钟再重试
- 在 https://openrouter.ai/keys 增加速率限制
- 在批处理请求中添加延迟

### 积分不足

**错误**：“Insufficient credits”

**解决方案**：
- 在 https://openrouter.ai/account 添加积分
- 启用自动充值以防止中断

有关全面的故障排除指南，请参见 `references/openrouter_setup.md`。

## 与其他技能的集成

该技能补充其他科学技能：

### 文献综述

与 `literature-review` 技能一起使用：
1. 使用 Perplexity 查找最新论文和预印本
2. 用实时网络结果补充 PubMed 搜索
3. 验证引用并查找相关工作
4. 发现数据库索引后最新的发展

### 科学写作

与 `scientific-writing` 技能一起使用：
1. 查找引言/讨论部分的最新参考文献
2. 验证当前的最新技术
3. 检查最新的术语和规范
4. 确定最新的竞争方法

### 假设生成

与 `hypothesis-generation` 技能一起使用：
1. 搜索最新的研究发现
2. 确定当前知识的空白
3. 查找最近的方法进展
4. 发现新兴的研究方向

### 批判性思维

与 `scientific-critical-thinking` 技能一起使用：
1. 查找支持和反对假设的证据
2. 找到方法论批评
3. 确定该领域的争议
4. 用当前证据验证主张

## 最佳实践

### 查询设计

1. **具体**：包括领域、时间框架和限制
2. **使用术语**：领域相关的关键词和短语
3. **指定来源**：提及首选的出版类型或期刊
4. **结构化问题**：清晰的组成部分和明确的背景
5. **迭代**：根据初始结果进行细化

### 模型选择

1. **从 sonar-pro 开始**：大多数查询的良好默认值
2. **复杂时升级**：对多步骤分析使用 sonar-pro-search
3. **简单时降级**：对基本事实使用 sonar
4. **使用推理模型**：当需要逐步分析时

### 成本优化

1. **选择合适的模型**：将模型与查询复杂性匹配
2. **设置令牌限制**：使用 `--max-tokens` 控制成本
3. **监控使用情况**：定期检查 OpenRouter 仪表板
4. **高效批处理**：尽可能组合相关的简单查询
5. **缓存结果**：保存并重用结果以应对重复查询

### 安全

1. **保护 API 密钥**：切勿提交到版本控制
2. **使用环境变量**：将密钥与代码分开
3. **设置支出限制**：在 OpenRouter 仪表板中配置
4. **监控使用情况**：注意异常活动
5. **轮换密钥**：定期更换密钥

## 资源

### 打包资源

**脚本：**
- `scripts/perplexity_search.py`：带有 CLI 接口的主要搜索脚本
- `scripts/setup_env.py`：环境设置和验证助手

**参考文献：**
- `references/search_strategies.md`：全面的查询设计指南
- `references/model_comparison.md`：详细的模型比较和选择指南
- `references/openrouter_setup.md`：完整的设置、故障排除和安全指南

**资产：**
- `assets/.env.example`：环境文件模板示例

### 外部资源

**OpenRouter：**
- 仪表板： https://openrouter.ai/account
- API 密钥： https://openrouter.ai/keys
- Perplexity 模型： https://openrouter.ai/perplexity
- 使用监控： https://openrouter.ai/activity
- 文档： https://openrouter.ai/docs

**LiteLLM：**
- 文档： https://docs.litellm.ai/
- OpenRouter 提供者： https://docs.litellm.ai/docs/providers/openrouter
- GitHub： https://github.com/BerriAI/litellm

**Perplexity：**
- 官方文档： https://docs.perplexity.ai/

## 依赖

### 必需的

```bash
# LiteLLM 用于 API 访问
uv pip install litellm
```

### 可选的

```bash
# 支持 .env 文件
uv pip install python-dotenv

# 用于 JSON 处理（通常预安装）
uv pip install jq
```

### 环境变量

必需：
- `OPENROUTER_API_KEY`：您的 OpenRouter API 密钥

可选：
- `DEFAULT_MODEL`：默认使用的模型（默认：sonar-pro）
- `DEFAULT_MAX_TOKENS`：默认最大令牌（默认：4000）
- `DEFAULT_TEMPERATURE`：默认温度（默认：0.2）

## 总结

该技能提供：

1. **实时网页搜索**：访问超出训练数据截止日期的当前信息
2. **多个模型**：从经济实惠的 Sonar 到先进的 Sonar Pro Search
3. **简单设置**：单个 OpenRouter API 密钥，无需单独的 Perplexity 账户
4. **全面指导**：详细的查询设计和模型选择参考
5. **成本效益**：按需付费定价和使用监控
6. **科学重点**：优化用于研究、文献搜索和技术查询
7. **轻松集成**：与其他科学技能无缝协作

进行 AI 驱动的网页搜索，以查找当前信息、最新研究和带有来源引用的可靠答案。