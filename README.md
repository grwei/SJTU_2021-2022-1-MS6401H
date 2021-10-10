# SJTU_2021-2022-1-MS6401H

研-MS6401H-440-M01-物理海洋学

* [项目主页](https://grwei.github.io/SJTU_2021-2022-1-MS6401H/)
* [个人主页](https://grwei.github.io/)

[toc]

## 摘要

1. 编写了从 [WOA18 数据集](https://www.ncei.noaa.gov/access/world-ocean-atlas-2018/)批量下载数据的脚本，可批量下载指定变量（例如，仅变量 `V_an`）的 `Netcdf` 子集。提供 `Command shell` 批处理版本 [`download_data.bat`](utilities/download_data.bat) 和 `Powershell` script 版本 [`download_data.ps1`](utilities/download_data.ps1)。
2. 使用`MATLAB`语言编写了自动化的绘图程序，可一键绘制、保存所有图片。使用了第三方工具箱[`m_map`](https://www.eoas.ubc.ca/~rich/map.html)。自顶向下、模块化的程序设计思想的实践，提高了代码复用率。
3. 对绘图结果做了定性的初步分析。

### 程序细节

1. 基于变量生成字段名称
2. 用`tiledlayout`代替`subplot`
3. 用`exportgraphics`输出图片，配合`figure`的`Position`名称-值对组参数调节图片大小，以交互方式调节图窗大小
4. 用`prctile`帮助确定颜色图范围，用`caxis`统一各子图的颜色图范围

## 题目 1-1

### 描述

运用作图软件绘制以下各变量每个月的全球分布图，观察其分布随时间变化。分布图需类似第三章中全球蒸发，感热，潜热的图，包含颜色，等值线（线上标明该线代表的值），陆地与海洋的分界线（大陆边界线）等

1. 短波辐射，数据文件：[`shortrad.cdf`](data/shortrad.cdf)
2. 长波辐射，数据文件：[`longrad.cdf`](data/longrad.cdf)
3. 净热通量，数据文件：[`netheat.cdf`](data/netheat.cdf)
4. 降水量，数据文件：[`precip.cdf`](data/precip.cdf)
5. 蒸发量减降水量，数据文件：[`emp.cdf`](data/emp.cdf)

### 已知的问题

1. 统一颜色图范围后，受全局最值影响，颜色区分度下降，应如何改善？数据-颜色的映射默认是线性的，是否考虑改变？
2. 要求经纬度坐标一致。否则，考虑先插值到参考坐标？

### 提交

#### 读图结论

1. 海平面短波月平均入射辐射通量密度（积分辐照度）
   1. 位变特性：固定时间，自太阳直射点所在纬度向两极递减；
   2. 时变特性：固定地点，对正午太阳天顶距单调递减。
2. 海平面长波月平均出射辐射通量密度
   1. 位变特性：固定时间，自太阳直射点所在纬度向两极递增；
   2. 时变特性：固定地点，对正午太阳天顶距单调递增，也就是夏半年出射通量密度小于冬半年。这是为什么？
3. 海平面月平均净热通量（向上为正）
   1. 夏至次月代数值最大且为正，冬至次月代数值最小且为负。
4. 海平面月平均降水率
   1. 位变特性：ITCZ附近极大，副热带附近极小
   2. 时变特性：随大气大尺度环流带南北移动
5. 海平面月平均蒸发率减降水率
   1. 位变特性：ITCZ附近极小，且为负；副热带附近极大，且为正
   2. 时变特性：随大气大尺度环流带南北移动

#### 图集

1. 短波辐射
   ![短波辐射](doc/fig/net%20short%20wave%20radiation.png)
2. 长波辐射
   ![长波辐射](doc/fig/outgoing%20longwave%20radiation.png)
3. 净热通量
   ![净热通量](doc/fig/constrained%20new%20outgoing%20heat%20flux.png)
4. 降水量
   ![降水量](doc/fig/precipitation%20rate.png)
5. 蒸发量减降水量
   ![蒸发量减降水量](doc/fig/constrained%20evaporation%20minus%20precipitation.png)

## 题目 1-2

### 描述

下载[WOA数据集](https://www.ncei.noaa.gov/access/world-ocean-atlas-2018/)中的温度，盐度数据（选择Objectively analyzed mean数据下载，如果选择`netcdf`格式，则变量都在一个文件里，直接下载找到Objectively analyzed mean变量即可），数据精度1°或1/4°，时间选择所有不同年代段（decade periods)的年平均(annual)与季节平均(seasonal)

1. 绘制各年代海表面温度与盐度的年平均与各季节平均图像，注意数值范围要统一（例如冬季温度颜色标尺如果使用-1度到30度范围，那么所有冬季温度都使用同样范围），比较表面温度与盐度空间上与时间上随各年代的变化
2. 绘制各年代的年平均与各季节的大西洋西经25°子午向断面图，太平洋西经170°子午向断面图。断面图需类似第二章温盐断面图，包含颜色，等值线等。注意数值范围统一，并比较断面温度与盐度空间上与时间上随各年代的变化

### 已知的问题

1. 如何批量下载 WOA18 数据？可能的解决方案：
   1. 查阅 WOA18 文档；
   2. 【**当前方案**】在 Windows 中，使用 `invoke-webrequest -uri <URL> -outfile <FILE>`(powershell ) 或 `curl <URL> -o <FILE>` (cmd)，可写成 cmd 批处理或 shell 脚本。参考[视频](https://www.bilibili.com/video/av972621898/)；
   3. 使用 `Python` 的有关库。
2. （已解决）增量图是按逐时间平均区间（年、冬、春、夏、秋）作出的，便于观察年代际变率的空间分布，但难以观察年代际变率对时间平均区间的变化。应增加绘制由冬、春、夏、秋四个增量图并列而成的图。
3. 要求经纬网格一致。否则，考虑先插值到参考坐标？（WOA18数据的经纬网格是一致的）
4. 颜色图中，缺省值颜色为白色。考虑改为其他颜色？

### 提交

#### 读图结论

1. 海表面
   1. 温度
      1. 年代际变率的空间分布：部分地区温度下降；北半球增温较快，北极地区最快；
      2. 年代际变率的时间分布：夏秋增温略大于冬春。
   2. 盐度
      1. 年代际变率的空间分布：变化较小。大西洋西岸、太平洋西岸，变率极大且为正；南海、澳大利亚北岸部分海区，变率极小且为负。
      2. 年代际变率的时间分布：秋冬变化略大于春夏。
2. 大西洋西经25°子午向断面（vertical section）
   1. 温度
      1. 年代际变率的空间分布：混合层以下，温度变率的绝对值较小。混合层中，赤道附近有温度变率极大且为正的区域；40N和40S附近有两个温度变率极小且为负的区域，且40N附近的极小负变率区域范围较40S附近的大；两极有两个变率极大且为正的区域。
      2. 年代际变率的时间分布：秋季变化较快？
   2. 盐度
      1. 年代际变率的空间分布：盐度变率的绝对值较小，混合层以下盐度变率的绝对值甚小。混合层中，赤道附近有盐度变率极大且为正的区域；37N和37S附近有两个盐度变率极小且为负的区域，且37N附近的极小负变率区域范围较37S附近的大；两极有两个变率极大且为正的区域。
      2. 年代际变率的时间分布：冬春变化略大于夏秋；夏季变化相对较大的垂直范围变小，与混合层厚度变化一致（夏季变薄），提示变化主要发生在混合层。
3. 太平洋西经170°子午向断面（vertical section）
   1. 温度
      1. 年代际变率的空间分布：有变冷趋势。混合层以下，温度变率的绝对值较小。混合层中，赤道附近，有温度变率极大的区域，但仅为小的正值；中纬度有变率极小且为负的区域；太平洋北缘有变率极大且为正的区域，北冰洋南缘有变率极小且为负的区域。
      2. 年代际变率的时间分布：秋冬变冷较显著的范围大于春夏的。
   2. 盐度
      1. 年代际变率的空间分布：混合层以下，盐度变率的绝对值较小。混合层中，低纬有变率极小且为负的区域；40N和40S附近有变率极小且为负的区域；50S-80S变率梯度较大，中间极小且为负、两侧极大且为正；白令海峡附近有变率极大且为正的区域。
      2. 年代际变率的时间分布：未见显著区别。

#### 图集

1. 海表面
   1. 温度
      1. 年平均
         ![海表面年平均温度](doc/fig/Surface_Temperature_Annual.png)
         ![增量：海表面温度年平均](doc/fig/Surface_Temperature_Annual_diff_8594_A5B7.png)
         ![增量：海表面温度季节平均](doc/fig/Surface_Temperature_diff2_8594_A5B7.png)
      2. 冬季平均
         ![海表面温度冬季平均](doc/fig/Surface_Temperature_Winter.png)
         ![增量：海表面温度冬季平均](doc/fig/Surface_Temperature_Winter_diff_8594_A5B7.png)
      3. 春季平均
         ![海表面温度春季平均](doc/fig/Surface_Temperature_Spring.png)
         ![增量：海表面温度春季平均](doc/fig/Surface_Temperature_Spring_diff_8594_A5B7.png)
      4. 夏季平均
         ![海表面温度夏季平均](doc/fig/Surface_Temperature_Summer.png)
         ![增量：海表面温度夏季平均](doc/fig/Surface_Temperature_Summer_diff_8594_A5B7.png)
      5. 秋季平均
         ![海表面温度秋季平均](doc/fig/Surface_Temperature_Autumn.png)
         ![增量：海表面温度秋季平均](doc/fig/Surface_Temperature_Autumn_diff_8594_A5B7.png)
   2. 盐度
      1. 年平均
         ![海表面盐度年平均](doc/fig/Surface_Salinity_Annual.png)
         ![增量：海表面盐度年平均](doc/fig/Surface_Salinity_Annual_diff_8594_A5B7.png)
         ![增量：海表面盐度季节平均](doc/fig/Surface_Salinity_diff2_8594_A5B7.png)
      2. 冬季平均
         ![海表面盐度冬季平均](doc/fig/Surface_Salinity_Winter.png)
         ![增量：海表面盐度冬季平均](doc/fig/Surface_Salinity_Winter_diff_8594_A5B7.png)
      3. 春季平均
         ![海表面盐度春季平均](doc/fig/Surface_Salinity_Spring.png)
         ![增量：海表面盐度春季平均](doc/fig/Surface_Salinity_Spring_diff_8594_A5B7.png)
      4. 夏季平均
         ![海表面盐度夏季平均](doc/fig/Surface_Salinity_Summer.png)
         ![增量：海表面盐度夏季平均](doc/fig/Surface_Salinity_Summer_diff_8594_A5B7.png)
      5. 秋季平均
         ![海表面盐度秋季平均](doc/fig/Surface_Salinity_Autumn.png)
         ![增量：海表面盐度秋季平均](doc/fig/Surface_Salinity_Autumn_diff_8594_A5B7.png)
2. 大西洋西经25°子午向断面（vertical section）
   1. 温度
      1. 年平均
         ![25W年平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Annual.png)
         ![增量：25W年平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Annual_diff_8594_A5B7.png)
         ![增量：25W季节平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_diff2_8594_A5B7.png)
      2. 冬季平均
         ![25W冬季平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Winter.png)
         ![增量：25W冬季平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Winter_diff_8594_A5B7.png)
      3. 春季平均
         ![25W春季平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Spring.png)
         ![增量：25W春季平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Spring_diff_8594_A5B7.png)
      4. 夏季平均
         ![25W夏季平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Summer.png)
         ![增量：25W夏季平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Summer_diff_8594_A5B7.png)
      5. 秋季平均
         ![25W秋季平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Autumn.png)
         ![增量：25W秋季平均温度断面](doc/fig/Vertical_Section_-25.5E_Temperature_Autumn_diff_8594_A5B7.png)
   2. 盐度
      1. 年平均
         ![25W年平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Annual.png)
         ![增量：25W年平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Annual_diff_8594_A5B7.png)
         ![增量：25W季节平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_diff2_8594_A5B7.png)
      2. 冬季平均
         ![25W冬季平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Winter.png)
         ![增量：25W冬季平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Winter_diff_8594_A5B7.png)
      3. 春季平均
         ![25W春季平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Spring.png)
         ![增量：25W春季平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Spring_diff_8594_A5B7.png)
      4. 夏季平均
         ![25W夏季平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Summer.png)
         ![增量：25W夏季平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Summer_diff_8594_A5B7.png)
      5. 秋季平均
         ![25W秋季平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Autumn.png)
         ![增量：25W秋季平均盐度断面](doc/fig/Vertical_Section_-25.5E_Salinity_Autumn_diff_8594_A5B7.png)
3. 太平洋西经170°子午向断面（vertical section）
   1. 温度
      1. 年平均
         ![170W年平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Annual.png)
         ![增量：170W年平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Annual_diff_8594_A5B7.png)
         ![增量：170W季节平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_diff2_8594_A5B7.png)
      2. 冬季平均
         ![170W冬季平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Winter.png)
         ![增量：170W冬季平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Winter_diff_8594_A5B7.png)
      3. 春季平均
         ![170W春季平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Spring.png)
         ![增量：170W春季平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Spring_diff_8594_A5B7.png)
      4. 夏季平均
         ![170W夏季平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Summer.png)
         ![增量：170W夏季平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Summer_diff_8594_A5B7.png)
      5. 秋季平均
         ![170W秋季平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Autumn.png)
         ![增量：170W秋季平均温度断面](doc/fig/Vertical_Section_-170.5E_Temperature_Autumn_diff_8594_A5B7.png)
   2. 盐度
      1. 年平均
         ![170W年平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Annual.png)
         ![增量：170W年平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Annual_diff_8594_A5B7.png)
         ![增量：170W季节平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_diff2_8594_A5B7.png)
      2. 冬季平均
         ![170W冬季平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Winter.png)
         ![增量：170W冬季平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Winter_diff_8594_A5B7.png)
      3. 春季平均
         ![170W春季平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Spring.png)
         ![增量：170W春季平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Spring_diff_8594_A5B7.png)
      4. 夏季平均
         ![170W夏季平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Summer.png)
         ![增量：170W夏季平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Summer_diff_8594_A5B7.png)
      5. 秋季平均
         ![170W秋季平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Autumn.png)
         ![增量：170W秋季平均盐度断面](doc/fig/Vertical_Section_-170.5E_Salinity_Autumn_diff_8594_A5B7.png)

## 联系我

* Name: 危国锐（Wei Guorui）
* ID: 120034910021
* E-mail: weiguorui@sjtu.edu.cn;313017602@qq.com
