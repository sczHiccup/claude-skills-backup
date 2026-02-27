---
name: literature-review
description: 使用多个学术数据库（如 PubMed、arXiv、bioRxiv、Semantic Scholar 等）进行全面、系统的文献综述。该技能应在进行系统文献综述、荟萃分析、研究综合或跨生物医学、科学和技术领域的全面文献搜索时使用。创建格式专业的 Markdown 文档和 PDF 文件，并在多种引用格式（如 APA、Nature、Vancouver 等）中提供经过验证的引用。
allowed-tools: [Read, Write, Edit, Bash]
---

# 文献综述

## 概述

按照严格的学术方法进行系统、全面的文献综述。搜索多个文献数据库，按主题综合研究结果，验证所有引用的准确性，并生成专业的 Markdown 和 PDF 格式的输出文档。

该技能与多个科学技能集成，以便访问数据库（gget、bioservices、datacommons-client），并提供用于引用验证、结果聚合和文档生成的专业工具。

## 何时使用此技能

在以下情况下使用此技能：
- 为研究或出版进行系统文献综述
- 综合多个来源的特定主题的当前知识
- 执行荟萃分析或范围综述
- 撰写研究论文或论文的文献综述部分
- 调查研究领域的最新进展
- 确定研究空白和未来方向
- 需要经过验证的引用和专业格式

## 使用科学示意图增强视觉效果

**⚠️ 强制性：每个文献综述必须至少包含 1-2 个使用科学示意图技能生成的 AI 图形。**

这不是可选的。没有视觉元素的文献综述是不完整的。在最终确定任何文档之前：
1. 至少生成一个示意图或图表（例如，系统综述的 PRISMA 流程图）
2. 对于全面的综述，优先选择 2-3 个图形（搜索策略流程图、主题综合图、概念框架）

**如何生成图形：**
- 使用 **scientific-schematics** 技能生成 AI 驱动的出版质量图表
- 只需用自然语言描述您想要的图表
- Nano Banana Pro 将自动生成、审查和完善示意图

**如何生成示意图：**
```bash
python scripts/generate_schematic.py "your diagram description" -o figures/output.png
```

AI 将自动：
- 创建具有适当格式的出版质量图像
- 通过多次迭代进行审查和完善
- 确保可访问性（色盲友好，高对比度）
- 将输出保存在 figures/ 目录中

**何时添加示意图：**
- 系统综述的 PRISMA 流程图
- 文献搜索策略流程图
- 主题综合图
- 研究空白可视化图
- 引用网络图
- 概念框架插图
- 任何受益于可视化的复杂概念

有关创建示意图的详细指导，请参考 scientific-schematics 技能文档。

---

## 核心工作流程

文献综述遵循结构化的多阶段工作流程：

### 第一阶段：规划和范围

1. **定义研究问题**：使用 PICO 框架（人群、干预、比较、结果）进行临床/生物医学综述
   - 示例：“CRISPR-Cas9（I）治疗镰状细胞病（P）与标准护理（C）的疗效如何？”

2. **建立范围和目标**：
   - 定义明确、具体的研究问题
   - 确定综述类型（叙述性、系统性、范围性、荟萃分析）
   - 设置边界（时间段、地理范围、研究类型）

3. **制定搜索策略**：
   - 从研究问题中识别 2-4 个主要概念
   - 列出每个概念的同义词、缩写和相关术语
   - 计划布尔运算符（AND、OR、NOT）以组合术语
   - 选择至少 3 个互补数据库

4. **设定纳入/排除标准**：
   - 日期范围（例如，过去 10 年：2015-2024）
   - 语言（通常为英语，或指定多语言）
   - 出版类型（同行评审、预印本、综述）
   - 研究设计（RCT、观察性、体外等）
   - 清晰记录所有标准

### 第二阶段：系统文献搜索

1. **多数据库搜索**：

   选择适合该领域的数据库：

   **生物医学与生命科学：**
   - 使用 `gget` 技能：`gget search pubmed "search terms"` 搜索 PubMed/PMC
   - 使用 `gget` 技能：`gget search biorxiv "search terms"` 搜索预印本
   - 使用 `bioservices` 技能获取 ChEMBL、KEGG、UniProt 等。

   **一般科学文献：**
   - 通过直接 API 搜索 arXiv（物理、数学、计算机科学、q-bio 的预印本）
   - 通过 API 搜索 Semantic Scholar（200M+ 论文，跨学科）
   - 使用 Google Scholar 进行全面覆盖（手动或仔细抓取）

   **专业数据库：**
   - 使用 `gget alphafold` 获取蛋白质结构
   - 使用 `gget cosmic` 获取癌症基因组信息
   - 使用 `datacommons-client` 获取人口/统计数据
   - 根据领域适当使用专业数据库

2. **记录搜索参数**：
   ```markdown
   ## 搜索策略

   ### 数据库：PubMed
   - **搜索日期**：2024-10-25
   - **日期范围**：2015-01-01 至 2024-10-25
   - **搜索字符串**：
     ```
     ("CRISPR"[Title] OR "Cas9"[Title])
     AND ("sickle cell"[MeSH] OR "SCD"[Title/Abstract])
     AND 2015:2024[Publication Date]
     ```
   - **结果**：247 篇文章
   ```

   对每个搜索的数据库重复此过程。

3. **导出和聚合结果**：
   - 从每个数据库以 JSON 格式导出结果
   - 将所有结果合并到一个文件中
   - 使用 `scripts/search_databases.py` 进行后处理：
     ```bash
     python search_databases.py combined_results.json \
       --deduplicate \
       --format markdown \
       --output aggregated_results.md
     ```

### 第三阶段：筛选和选择

1. **去重**：
   ```bash
   python search_databases.py results.json --deduplicate --output unique_results.json
   ```
   - 通过 DOI（主要）或标题（备用）删除重复项
   - 记录删除的重复项数量

2. **标题筛选**：
   - 根据纳入/排除标准审查所有标题
   - 排除明显不相关的研究
   - 记录此阶段排除的数量

3. **摘要筛选**：
   - 阅读剩余研究的摘要
   - 严格应用纳入/排除标准
   - 记录排除的原因

4. **全文筛选**：
   - 获取剩余研究的全文
   - 针对所有标准进行详细审查
   - 记录排除的具体原因
   - 记录最终纳入的研究数量

5. **创建 PRISMA 流程图**：
   ```
   初始搜索：n = X
   ├─ 去重后：n = Y
   ├─ 标题筛选后：n = Z
   ├─ 摘要筛选后：n = A
   └─ 纳入综述：n = B
   ```

### 第四阶段：数据提取和质量评估

1. **从每个纳入的研究中提取关键数据**：
   - 研究元数据（作者、年份、期刊、DOI）
   - 研究设计和方法
   - 样本大小和人群特征
   - 关键发现和结果
   - 作者指出的局限性
   - 资金来源和利益冲突

2. **评估研究质量**：
   - **对于 RCT**：使用 Cochrane 偏倚风险工具
   - **对于观察性研究**：使用 Newcastle-Ottawa 量表
   - **对于系统综述**：使用 AMSTAR 2
   - 对每项研究进行评级：高、中、低或非常低质量
   - 考虑排除非常低质量的研究

3. **按主题组织**：
   - 确定 3-5 个主要主题
   - 按主题对研究进行分组（研究可能出现在多个主题中）
   - 注意模式、一致性和争议

### 第五阶段：综合与分析

1. **从模板创建综述文档**：
   ```bash
   cp assets/review_template.md my_literature_review.md
   ```

2. **撰写主题综合**（而不是逐项总结）：
   - 按主题或研究问题组织结果部分
   - 综合每个主题内多个研究的发现
   - 比较和对比不同的方法和结果
   - 确定共识区域和争议点
   - 突出最强的证据

   示例结构：
   ```markdown
   #### 3.3.1 主题：CRISPR 递送方法

   多种递送方法已被研究用于治疗性基因编辑。病毒载体（AAV）在 15 项研究中使用^1-15^，显示出高转导效率（65-85%），但引发了免疫原性问题^3,7,12^。相比之下，脂质纳米颗粒表现出较低的效率（40-60%），但改善了安全性^16-23^。
   ```

3. **批判性分析**：
   - 评估各研究的研究方法优缺点
   - 评估证据的质量和一致性
   - 确定知识空白和方法论空白
   - 注意需要未来研究的领域

4. **撰写讨论**：
   - 在更广泛的背景下解释发现
   - 讨论临床、实践或研究的影响
   - 承认综述本身的局限性
   - 如适用，与以往的综述进行比较
   - 提出具体的未来研究方向

### 第六阶段：引用验证

**关键**：所有引用必须在最终提交前验证其准确性。

1. **验证所有 DOI**：
   ```bash
   python scripts/verify_citations.py my_literature_review.md
   ```

   此脚本：
   - 从文档中提取所有 DOI
   - 验证每个 DOI 是否正确解析
   - 从 CrossRef 检索元数据
   - 生成验证报告
   - 输出格式正确的引用

2. **审查验证报告**：
   - 检查是否有失败的 DOI
   - 验证作者姓名、标题和出版详细信息是否匹配
   - 更正原始文档中的任何错误
   - 重新运行验证，直到所有引用通过

3. **一致性格式化引用**：
   - 选择一种引用风格并贯穿使用（见 `references/citation_styles.md`）
   - 常见风格：APA、Nature、Vancouver、Chicago、IEEE
   - 使用验证脚本输出正确格式化引用
   - 确保文内引用与参考文献列表格式匹配

### 第七阶段：文档生成

1. **生成 PDF**：
   ```bash
   python scripts/generate_pdf.py my_literature_review.md \
     --citation-style apa \
     --output my_review.pdf
   ```

   选项：
   - `--citation-style`：apa、nature、chicago、vancouver、ieee
   - `--no-toc`：禁用目录
   - `--no-numbers`：禁用章节编号
   - `--check-deps`：检查是否安装 pandoc/xelatex

2. **审查最终输出**：
   - 检查 PDF 格式和布局
   - 验证所有部分是否存在
   - 确保引用正确呈现
   - 检查图形/表格是否正确显示
   - 验证目录的准确性

3. **质量检查清单**：
   - [ ] 所有 DOI 通过 verify_citations.py 验证
   - [ ] 引用格式一致
   - [ ] 包含 PRISMA 流程图（针对系统综述）
   - [ ] 搜索方法完全记录
   - [ ] 纳入/排除标准清晰说明
   - [ ] 结果按主题组织（而非逐项）
   - [ ] 完成质量评估
   - [ ] 承认局限性
   - [ ] 参考文献完整且准确
   - [ ] PDF 无错误生成

## 数据库特定搜索指导

### PubMed / PubMed Central

通过 `gget` 技能访问：
```bash
# 搜索 PubMed
gget search pubmed "CRISPR gene editing" -l 100

# 使用过滤器搜索
# 使用 PubMed 高级搜索构建复杂查询
# 然后通过 gget 或直接 Entrez API 执行
```

**搜索提示**：
- 使用 MeSH 术语：`"sickle cell disease"[MeSH]`
- 字段标签：`[Title]`、`[Title/Abstract]`、`[Author]`
- 日期过滤器：`2020:2024[Publication Date]`
- 布尔运算符：AND、OR、NOT
- 查看 MeSH 浏览器：https://meshb.nlm.nih.gov/search

### bioRxiv / medRxiv

通过 `gget` 技能访问：
```bash
gget search biorxiv "CRISPR sickle cell" -l 50
```

**重要考虑**：
- 预印本未经同行评审
- 小心验证发现
- 检查预印本是否已出版（CrossRef）
- 注意预印本版本和日期

### arXiv

通过直接 API 或 WebFetch 访问：
```python
# 示例搜索类别：
# q-bio.QM（定量方法）
# q-bio.GN（基因组学）
# q-bio.MN（分子网络）
# cs.LG（机器学习）
# stat.ML（机器学习统计）

# 搜索格式：类别 AND 术语
search_query = "cat:q-bio.QM AND ti:\"single cell sequencing\""
```

### Semantic Scholar

通过直接 API 访问（需要 API 密钥，或使用免费层）：
- 200M+ 论文涵盖所有领域
- 跨学科搜索的绝佳选择
- 提供引用图和论文推荐
- 用于查找影响力较大的论文

### 专业生物医学数据库

使用适当的技能：
- **ChEMBL**：使用 `bioservices` 技能获取化学生物活性
- **UniProt**：使用 `gget` 或 `bioservices` 技能获取蛋白质信息
- **KEGG**：使用 `bioservices` 技能获取通路和基因
- **COSMIC**：使用 `gget` 技能获取癌症突变
- **AlphaFold**：使用 `gget alphafold` 获取蛋白质结构
- **PDB**：使用 `gget` 或直接 API 获取实验结构

### 引用链

通过引用网络扩展搜索：

1. **前向引用**（引用关键论文的论文）：
   - 使用 Google Scholar 的“被引用次数”
   - 使用 Semantic Scholar 或 OpenAlex API
   - 确定基于重要工作的新研究

2. **后向引用**（关键论文的参考文献）：
   - 从纳入的论文中提取参考文献
   - 确定高度引用的基础工作
   - 查找被多项纳入研究引用的论文

## 引用风格指南

详细格式化指南见 `references/citation_styles.md`。快速参考：

### APA（第 7 版）
- 文内引用：（Smith et al., 2023）
- 参考文献：Smith, J. D., Johnson, M. L., & Williams, K. R. (2023). Title. *Journal*, *22*(4), 301-318. https://doi.org/10.xxx/yyy

### Nature
- 文内引用：上标数字^1,2^
- 参考文献：Smith, J. D., Johnson, M. L. & Williams, K. R. Title. *Nat. Rev. Drug Discov.* **22**, 301-318 (2023).

### Vancouver
- 文内引用：上标数字^1,2^
- 参考文献：Smith JD, Johnson ML, Williams KR. Title. Nat Rev Drug Discov. 2023;22(4):301-18.

**在最终确定之前，始终通过 verify_citations.py 验证引用。**

## 最佳实践

### 搜索策略
1. **使用多个数据库**（至少 3 个）：确保全面覆盖
2. **包括预印本服务器**：捕捉最新未发表的发现
3. **记录所有内容**：搜索字符串、日期、结果计数以确保可重复性
4. **测试和优化**：运行试点搜索，审查结果，调整搜索词

### 筛选和选择
1. **使用明确的标准**：在筛选之前记录纳入/排除标准
2. **系统性筛选**：标题 → 摘要 → 全文
3. **记录排除情况**：记录排除研究的原因
4. **考虑双重筛选**：对于系统综述，让两位评审独立筛选

### 综合
1. **按主题组织**：按主题分组，而不是按单个研究
2. **跨研究综合**：比较、对比、识别模式
3. **保持批判性**：评估证据的质量和一致性
4. **识别空白**：注意缺失或研究不足的领域

### 质量和可重复性
1. **评估研究质量**：使用适当的质量评估工具
2. **验证所有引用**：运行 verify_citations.py 脚本
3. **记录方法**：提供足够的细节以便他人重复
4. **遵循指南**：使用 PRISMA 进行系统综述

### 写作
1. **保持客观**：公正呈现证据，承认局限性
2. **系统性**：遵循结构化模板
3. **具体**：在可用时包括数字、统计数据、效应大小
4. **清晰**：使用清晰的标题、逻辑流、主题组织

## 常见陷阱

1. **单一数据库搜索**：遗漏相关论文；始终搜索多个数据库
2. **没有搜索记录**：使综述无法重复；记录所有搜索
3. **逐项总结研究**：缺乏综合；按主题组织
4. **未验证引用**：导致错误；始终运行 verify_citations.py
5. **搜索过于宽泛**：产生数千个不相关结果；使用具体术语进行优化
6. **搜索过于狭窄**：遗漏相关论文；包括同义词和相关术语
7. **忽视预印本**：遗漏最新发现；包括 bioRxiv、medRxiv、arXiv
8. **没有质量评估**：将所有证据视为平等；评估并报告质量
9. **出版偏倚**：仅发布正面结果；注意潜在偏倚
10. **过时搜索**：领域快速发展；清楚说明搜索日期

## 示例工作流程

生物医学文献综述的完整工作流程：

```bash
# 1. 从模板创建综述文档
cp assets/review_template.md crispr_sickle_cell_review.md

# 2. 使用适当的技能搜索多个数据库
# - 使用 gget 技能搜索 PubMed、bioRxiv
# - 使用直接 API 访问 arXiv、Semantic Scholar
# - 以 JSON 格式导出结果

# 3. 聚合和处理结果
python scripts/search_databases.py combined_results.json \
  --deduplicate \
  --rank citations \
  --year-start 2015 \
  --year-end 2024 \
  --format markdown \
  --output search_results.md \
  --summary

# 4. 筛选结果并提取数据
# - 手动筛选标题、摘要、全文
# - 将关键数据提取到综述文档中
# - 按主题组织

# 5. 按照模板结构撰写综述
# - 介绍部分明确目标
# - 详细的方法部分
# - 按主题组织的结果
# - 批判性讨论
# - 清晰的结论

# 6. 验证所有引用
python scripts/verify_citations.py crispr_sickle_cell_review.md

# 审查引用报告
cat crispr_sickle_cell_review_citation_report.json

# 修复任何失败的引用并重新验证
python scripts/verify_citations.py crispr_sickle_cell_review.md

# 7. 生成专业 PDF
python scripts/generate_pdf.py crispr_sickle_cell_review.md \
  --citation-style nature \
  --output crispr_sickle_cell_review.pdf

# 8. 审查最终 PDF 和 Markdown 输出
```

## 与其他技能的集成

该技能与其他科学技能无缝协作：

### 数据库访问技能
- **gget**：PubMed、bioRxiv、COSMIC、AlphaFold、Ensembl、UniProt
- **bioservices**：ChEMBL、KEGG、Reactome、UniProt、PubChem
- **datacommons-client**：人口、经济、健康统计数据

### 分析技能
- **pydeseq2**：RNA-seq 差异表达（用于方法部分）
- **scanpy**：单细胞分析（用于方法部分）
- **anndata**：单细胞数据（用于方法部分）
- **biopython**：序列分析（用于背景部分）

### 可视化技能
- **matplotlib**：生成综述的图形和图表
- **seaborn**：统计可视化

### 写作技能
- **brand-guidelines**：将机构品牌应用于 PDF
- **internal-comms**：为不同受众调整综述

## 资源

### 打包资源

**脚本：**
- `scripts/verify_citations.py`：验证 DOI 并生成格式化引用
- `scripts/generate_pdf.py`：将 Markdown 转换为专业 PDF
- `scripts/search_databases.py`：处理、去重和格式化搜索结果

**参考文献：**
- `references/citation_styles.md`：详细的引用格式指南（APA、Nature、Vancouver、Chicago、IEEE）
- `references/database_strategies.md`：全面的数据库搜索策略

**资产：**
- `assets/review_template.md`：包含所有部分的完整文献综述模板

### 外部资源

**指南：**
- PRISMA（系统综述）：http://www.prisma-statement.org/
- Cochrane 手册：https://training.cochrane.org/handbook
- AMSTAR 2（综述质量）：https://amstar.ca/

**工具：**
- MeSH 浏览器：https://meshb.nlm.nih.gov/search
- PubMed 高级搜索：https://pubmed.ncbi.nlm.nih.gov/advanced/
- 布尔搜索指南：https://www.ncbi.nlm.nih.gov/books/NBK3827/

**引用风格：**
- APA 风格：https://apastyle.apa.org/
- Nature 组合：https://www.nature.com/nature-portfolio/editorial-policies/reporting-standards
- NLM/Vancouver：https://www.nlm.nih.gov/bsd/uniform_requirements.html

## 依赖关系

### 所需的 Python 包
```bash
pip install requests  # 用于引用验证
```

### 所需的系统工具
```bash
# 用于 PDF 生成
brew install pandoc  # macOS
apt-get install pandoc  # Linux

# 用于 LaTeX（PDF 生成）
brew install --cask mactex  # macOS
apt-get install texlive-xetex  # Linux
```

检查依赖关系：
```bash
python scripts/generate_pdf.py --check-deps
```

## 总结

此文献综述技能提供：

1. **遵循学术最佳实践的系统方法论**
2. **通过现有科学技能的多数据库集成**
3. **确保准确性和可信度的引用验证**
4. **以 Markdown 和 PDF 格式生成专业输出**
5. **涵盖整个综述过程的全面指导**
6. **通过验证和验证工具进行质量保证**
7. **通过详细的文档要求确保可重复性**

进行彻底、严格的文献综述，满足学术标准，并提供任何领域当前知识的全面综合。