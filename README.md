# HAM vs VER · 十年宿敌全记录

汉密尔顿与维斯塔潘 2016–2026 交手全记录的静态网页。**单页、零依赖、完全离线可用**——双击 `index.html` 即可浏览，不需要服务器或网络。

> ## ⚠️ 图片版权声明
>
> 本仓库 `assets/` 目录内的 **55 张图片全部来自 Formula 1 官方媒体库**（`media.formula1.com`），
> 摄影版权属 **Formula One Licensing B.V. 与 Getty Images**，**并非本项目作者所有**。
>
> 这些图片仅用于个人学习与非商业的数据可视化演示。若你 fork、转载或再分发本仓库，
> 请自行承担相应的版权责任 —— 建议先替换为你自有或已获授权的图片。
>
> 页面中的**代码、样式与全部数据整理**为本项目原创内容。

![sections](https://img.shields.io/badge/sections-6-ff4a5c) ![offline](https://img.shields.io/badge/network-none%20required-2f7dff) ![size](https://img.shields.io/badge/page-65%20KB-f0c419)

## 内容

| 区块 | 内容 |
|---|---|
| **首屏** | 2026 加拿大站实拍背景 · 核心数字速览 |
| **01 车手与赛车** | 官方肖像 + 2026 赛季赛车渲染图 · 生涯累计对比条 · 车手档案 |
| **02 逐赛季胜负** | 两个时代（2016–2020 / 2021–2026）分水岭对比 · 11 个赛季手风琴，含积分差发散条与共享发车位逐年拆分 |
| **03 2026 逐站分页** | 23 站赛道缩略图条 + 大图舞台，含分站冠军、本轮对决判定、**两人完赛精确差距** |
| **04 最接近的几次** | 2026 加拿大 0.508 秒 · 2023 匈牙利排位 0.003 秒 · 2021 阿布扎比最后一圈 · 2024 银石排位 0.1 秒 |
| **05 关键时刻** | 11 个标志性瞬间时间轴 |

## 交互

- 顶部固定导航 + 红→金→蓝阅读进度条，当前章节自动高亮
- 逐赛季年份可展开，高度自适应动画
- 分站分页支持点击、**← → 方向键**、Home/End、上一站/下一站按钮
- 滚动渐显、数字滚动、进度条生长
- 回到顶部按钮
- 完整响应式（880px / 760px 两档断点）

## 无障碍与健壮性

- 语义化 `<button>` + `aria-expanded` / `aria-controls` / `aria-pressed` / `aria-label`
- 可见焦点环（`:focus-visible`）
- **渐进增强**：内容默认可见，仅在 JS 可用时启用入场动画——脚本失效不会白屏
- 尊重 `prefers-reduced-motion`
- 打印样式（白底黑字、隐藏交互控件）
- 全部图片 `loading="lazy"`，首屏图 `fetchpriority="high"`

## 数据说明

数据截至 **2026 年 10 月 11 日**（第 17 轮新加坡站 · 冲刺赛已结束，正赛待跑）。

- 生涯累计与逐赛季积分/胜场：Formula 1 官方统计
- 2026 赛季 16 站正赛对决：逐场核对官方成绩，完赛差距精确至千分位 → **8 : 8**
- 2026 赛季 6 场冲刺赛对决：冲刺赛周末为 R2 / R4 / R5 / R9 / R12 / R17 → **3 : 3**
- 共享发车位 15 次（维斯塔潘 8 – 汉密尔顿 7）
- 部分数据库在领奖台 / 杆位总数上存在 1–2 场统计差异
- 2023、2024 两项排位差距为当年公开报道中的约数

## 重新生成图片

```powershell
powershell -ExecutionPolicy Bypass -File .\fetch-assets.ps1   # 从 F1 官方媒体库抓图
python .\crop-portraits.py                                    # 裁切车手肖像为 3:4 头肩构图
```

## 图片版权

`assets/` 内的 55 张图片来自 **Formula 1 官方媒体库**（`media.formula1.com`），摄影版权属 **Formula One Licensing B.V. 及 Getty Images** 所有，仅用于个人学习与数据可视化演示。完整声明见本文档顶部。

若要移除图片：把 `.gitignore` 里加一行 `assets/` 重新提交即可，页面代码本身不依赖任何图片即可运行。

## 发布到 GitHub Pages

```bash
# 1. 在 github.com/new 创建空仓库（不要勾选 README / .gitignore）
# 2. 关联并推送
git remote add origin git@github.com:Lottle7/f1-hamilton-vs-verstappen.git
git push -u origin main

# 3. 开启 Pages
#    仓库 Settings → Pages → Source 选 main 分支 / root
```

访问地址将是 `https://lottle7.github.io/f1-hamilton-vs-verstappen/`。

## 技术栈

原生 HTML / CSS / JavaScript，无构建步骤、无框架、无外部 CDN 依赖。可直接用 GitHub Pages、Netlify、Vercel 或任意静态托管发布。

## 数据修正记录

- **2026 阿塞拜疆站**：早期版本误将维斯塔潘对本站冠军的时间差（+0.196 秒）当作与汉密尔顿的差距。核对官方成绩后更正为**实际相差 22.186 秒**。2026 全季最接近的一战实为**加拿大站 0.508 秒**。
- **积分榜区块曾一度丢失**：某次整页重写时「2026 积分榜」与「8:8 对决统计」两个区块被误删，已恢复并补入冲刺赛 3:3 统计。

## 更新记录

| 日期 | 更新内容 |
|---|---|
| 2026-10-04 | 新增逐站精确完赛差距、时代对比、积分差发散条 |
| 2026-10-11 | 新加坡冲刺赛结果（VER 夺冠 / HAM P2）；补齐 6 场冲刺赛对决统计（3:3）；积分榜更新（Antonelli 325 / Hamilton 221 / Verstappen 196） |