---
name: matplotlib
description: "基础绘图库。创建线图、散点图、条形图、直方图、热图、3D图、子图，导出 PNG/PDF/SVG，用于科学可视化和出版图形。"
---

# Matplotlib

## 概述

Matplotlib 是 Python 的基础可视化库，用于创建静态、动画和交互式图表。该技能提供了有效使用 matplotlib 的指导，涵盖了 pyplot 接口（类似 MATLAB 风格）和面向对象的 API（Figure/Axes），以及创建出版质量可视化的最佳实践。

## 何时使用此技能

当您需要：
- 创建任何类型的图表或图形（线图、散点图、条形图、直方图、热图、等高线图等）
- 生成科学或统计可视化
- 自定义图表外观（颜色、样式、标签、图例）
- 创建带有子图的多面板图形
- 将可视化导出为各种格式（PNG、PDF、SVG 等）
- 构建交互式图表或动画
- 处理 3D 可视化
- 将图表集成到 Jupyter 笔记本或 GUI 应用程序中

## 核心概念

### Matplotlib 层次结构

Matplotlib 使用对象的层次结构：

1. **Figure** - 所有图表元素的顶级容器
2. **Axes** - 实际显示数据的绘图区域（一个 Figure 可以包含多个 Axes）
3. **Artist** - Figure 上可见的所有内容（线条、文本、刻度等）
4. **Axis** - 处理刻度和标签的数字线对象（x 轴、y 轴）

### 两种接口

**1. pyplot 接口（隐式，MATLAB 风格）**
```python
import matplotlib.pyplot as plt

plt.plot([1, 2, 3, 4])
plt.ylabel('some numbers')
plt.show()
```
- 适合快速、简单的绘图
- 自动维护状态
- 适合交互式工作和简单脚本

**2. 面向对象接口（显式）**
```python
import matplotlib.pyplot as plt

fig, ax = plt.subplots()
ax.plot([1, 2, 3, 4])
ax.set_ylabel('some numbers')
plt.show()
```
- **推荐用于大多数用例**
- 对 Figure 和 Axes 有更显式的控制
- 更适合具有多个子图的复杂图形
- 更易于维护和调试

## 常见工作流程

### 1. 基本绘图创建

**单图工作流程：**
```python
import matplotlib.pyplot as plt
import numpy as np

# 创建图形和坐标轴（OO 接口 - 推荐）
fig, ax = plt.subplots(figsize=(10, 6))

# 生成并绘制数据
x = np.linspace(0, 2*np.pi, 100)
ax.plot(x, np.sin(x), label='sin(x)')
ax.plot(x, np.cos(x), label='cos(x)')

# 自定义
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_title('三角函数')
ax.legend()
ax.grid(True, alpha=0.3)

# 保存和/或显示
plt.savefig('plot.png', dpi=300, bbox_inches='tight')
plt.show()
```

### 2. 多个子图

**创建子图布局：**
```python
# 方法 1：常规网格
fig, axes = plt.subplots(2, 2, figsize=(12, 10))
axes[0, 0].plot(x, y1)
axes[0, 1].scatter(x, y2)
axes[1, 0].bar(categories, values)
axes[1, 1].hist(data, bins=30)

# 方法 2：马赛克布局（更灵活）
fig, axes = plt.subplot_mosaic([['left', 'right_top'],
                                 ['left', 'right_bottom']],
                                figsize=(10, 8))
axes['left'].plot(x, y)
axes['right_top'].scatter(x, y)
axes['right_bottom'].hist(data)

# 方法 3：GridSpec（最大控制）
from matplotlib.gridspec import GridSpec
fig = plt.figure(figsize=(12, 8))
gs = GridSpec(3, 3, figure=fig)
ax1 = fig.add_subplot(gs[0, :])  # 顶行，所有列
ax2 = fig.add_subplot(gs[1:, 0])  # 底部两行，第一列
ax3 = fig.add_subplot(gs[1:, 1:])  # 底部两行，最后两列
```

### 3. 图表类型和用例

**线图** - 时间序列、连续数据、趋势
```python
ax.plot(x, y, linewidth=2, linestyle='--', marker='o', color='blue')
```

**散点图** - 变量之间的关系、相关性
```python
ax.scatter(x, y, s=sizes, c=colors, alpha=0.6, cmap='viridis')
```

**条形图** - 类别比较
```python
ax.bar(categories, values, color='steelblue', edgecolor='black')
# 对于水平条形图：
ax.barh(categories, values)
```

**直方图** - 分布
```python
ax.hist(data, bins=30, edgecolor='black', alpha=0.7)
```

**热图** - 矩阵数据、相关性
```python
im = ax.imshow(matrix, cmap='coolwarm', aspect='auto')
plt.colorbar(im, ax=ax)
```

**等高线图** - 2D 平面上的 3D 数据
```python
contour = ax.contour(X, Y, Z, levels=10)
ax.clabel(contour, inline=True, fontsize=8)
```

**箱线图** - 统计分布
```python
ax.boxplot([data1, data2, data3], labels=['A', 'B', 'C'])
```

**小提琴图** - 分布密度
```python
ax.violinplot([data1, data2, data3], positions=[1, 2, 3])
```

有关全面的图表类型示例和变体，请参阅 `references/plot_types.md`。

### 4. 样式和自定义

**颜色指定方法：**
- 命名颜色：`'red'`、`'blue'`、`'steelblue'`
- 十六进制代码：`'#FF5733'`
- RGB 元组：`(0.1, 0.2, 0.3)`
- 颜色映射：`cmap='viridis'`、`cmap='plasma'`、`cmap='coolwarm'`

**使用样式表：**
```python
plt.style.use('seaborn-v0_8-darkgrid')  # 应用预定义样式
# 可用样式：'ggplot'、'bmh'、'fivethirtyeight' 等
print(plt.style.available)  # 列出所有可用样式
```

**使用 rcParams 自定义：**
```python
plt.rcParams['font.size'] = 12
plt.rcParams['axes.labelsize'] = 14
plt.rcParams['axes.titlesize'] = 16
plt.rcParams['xtick.labelsize'] = 10
plt.rcParams['ytick.labelsize'] = 10
plt.rcParams['legend.fontsize'] = 12
plt.rcParams['figure.titlesize'] = 18
```

**文本和注释：**
```python
ax.text(x, y, 'annotation', fontsize=12, ha='center')
ax.annotate('重要点', xy=(x, y), xytext=(x+1, y+1),
            arrowprops=dict(arrowstyle='->', color='red'))
```

有关详细的样式选项和颜色映射指南，请参阅 `references/styling_guide.md`。

### 5. 保存图形

**导出为各种格式：**
```python
# 高分辨率 PNG 用于演示/论文
plt.savefig('figure.png', dpi=300, bbox_inches='tight', facecolor='white')

# 出版物的矢量格式（可缩放）
plt.savefig('figure.pdf', bbox_inches='tight')
plt.savefig('figure.svg', bbox_inches='tight')

# 透明背景
plt.savefig('figure.png', dpi=300, bbox_inches='tight', transparent=True)
```

**重要参数：**
- `dpi`：分辨率（出版物为 300，网页为 150，屏幕为 72）
- `bbox_inches='tight'`：去除多余的空白
- `facecolor='white'`：确保白色背景（对透明主题有用）
- `transparent=True`：透明背景

### 6. 处理 3D 图形

```python
from mpl_toolkits.mplot3d import Axes3D

fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

# 表面图
ax.plot_surface(X, Y, Z, cmap='viridis')

# 3D 散点图
ax.scatter(x, y, z, c=colors, marker='o')

# 3D 线图
ax.plot(x, y, z, linewidth=2)

# 标签
ax.set_xlabel('X 标签')
ax.set_ylabel('Y 标签')
ax.set_zlabel('Z 标签')
```

## 最佳实践

### 1. 接口选择
- **使用面向对象接口**（fig, ax = plt.subplots()）用于生产代码
- 将 pyplot 接口保留用于快速交互式探索
- 始终显式创建图形，而不是依赖隐式状态

### 2. 图形大小和 DPI
- 在创建时设置 figsize：`fig, ax = plt.subplots(figsize=(10, 6))`
- 根据输出介质使用适当的 DPI：
  - 屏幕/笔记本：72-100 dpi
  - 网页：150 dpi
  - 打印/出版物：300 dpi

### 3. 布局管理
- 使用 `constrained_layout=True` 或 `tight_layout()` 防止元素重叠
- `fig, ax = plt.subplots(constrained_layout=True)` 推荐用于自动间距

### 4. 颜色映射选择
- **顺序**（viridis、plasma、inferno）：有序数据，具有一致的进展
- **发散**（coolwarm、RdBu）：具有重要中心点的数据（例如，零）
- **定性**（tab10、Set3）：类别/名义数据
- 避免彩虹颜色映射（jet） - 它们不是感知均匀的

### 5. 可访问性
- 使用对色盲友好的颜色映射（viridis、cividis）
- 在条形图中添加图案/斜线以补充颜色
- 确保元素之间有足够的对比度
- 包括描述性标签和图例

### 6. 性能
- 对于大数据集，在绘图调用中使用 `rasterized=True` 以减小文件大小
- 在绘图之前使用适当的数据减少（例如，降采样密集的时间序列）
- 对于动画，使用 blitting 提高性能

### 7. 代码组织
```python
# 好的实践：清晰结构
def create_analysis_plot(data, title):
    """创建标准化分析图。"""
    fig, ax = plt.subplots(figsize=(10, 6), constrained_layout=True)

    # 绘制数据
    ax.plot(data['x'], data['y'], linewidth=2)

    # 自定义
    ax.set_xlabel('X 轴标签', fontsize=12)
    ax.set_ylabel('Y 轴标签', fontsize=12)
    ax.set_title(title, fontsize=14, fontweight='bold')
    ax.grid(True, alpha=0.3)

    return fig, ax

# 使用该函数
fig, ax = create_analysis_plot(my_data, '我的分析')
plt.savefig('analysis.png', dpi=300, bbox_inches='tight')
```

## 快速参考脚本

该技能包括 `scripts/` 目录中的辅助脚本：

### `plot_template.py`
模板脚本，演示各种图表类型及最佳实践。将其作为创建新可视化的起点。

**用法：**
```bash
python scripts/plot_template.py
```

### `style_configurator.py`
交互式工具，用于配置 matplotlib 样式偏好并生成自定义样式表。

**用法：**
```bash
python scripts/style_configurator.py
```

## 详细参考

有关全面的信息，请查阅参考文档：

- **`references/plot_types.md`** - 完整的图表类型目录，包含代码示例和用例
- **`references/styling_guide.md`** - 详细的样式选项、颜色映射和自定义
- **`references/api_reference.md`** - 核心类和方法参考
- **`references/common_issues.md`** - 常见问题的故障排除指南

## 与其他工具的集成

Matplotlib 与以下工具良好集成：
- **NumPy/Pandas** - 直接从数组和 DataFrame 绘图
- **Seaborn** - 基于 matplotlib 的高级统计可视化
- **Jupyter** - 使用 `%matplotlib inline` 或 `%matplotlib widget` 进行交互式绘图
- **GUI 框架** - 嵌入 Tkinter、Qt、wxPython 应用程序

## 常见问题

1. **元素重叠**：使用 `constrained_layout=True` 或 `tight_layout()`
2. **状态混淆**：使用 OO 接口以避免 pyplot 状态机问题
3. **许多图形的内存问题**：使用 `plt.close(fig)` 显式关闭图形
4. **字体警告**：安装字体或使用 `plt.rcParams['font.sans-serif']` 抑制警告
5. **DPI 混淆**：记住 figsize 是以英寸为单位，而不是像素：`pixels = dpi * inches`

## 其他资源

- 官方文档：https://matplotlib.org/
- 画廊：https://matplotlib.org/stable/gallery/index.html
- 备忘单：https://matplotlib.org/cheatsheets/
- 教程：https://matplotlib.org/stable/tutorials/index.html