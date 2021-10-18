# 作业2

研-MS6401H-440-M01-物理海洋学

* [课程主页](https://grwei.github.io/SJTU_2021-2022-1-MS6401H/)
* [个人主页](https://grwei.github.io/)

[toc]

## Question 1

A parcel of water, starting at the sea surface, is adiabatically transported to a depth of 4 m. For each of the following, CIRCLE whether the property is conserved or not conserved (circle correct answer). Write a very brief explanation for each answer (why a property is either conserved or not conserved).

1. Temperature: CONSERVED or NOT CONSERVED
2. Potential Temperature: CONSERVED or NOT CONSERVED
3. Salinity: CONSERVED or NOT CONSERVED
4. Density: CONSERVED or NOT CONSERVED
5. Speed of sound: CONSERVED or NOT CONSERVED
6. Mass: CONSERVED or NOT CONSERVED

### Answer 1

#### 模型

1. 绝热的**封闭**系。水团与外界无物质交换（封闭），无热传导（绝热）；
2. 水团内温度、压强、盐度等物理量都呈均匀分布；
3. 准静力条件。水团表面压强 $p$ 与环境压强 $p_{\mathrm{e}}$ 相等，且 $\dfrac{\mathop{\mathrm{d} p}}{\mathop{\mathrm{d}z}} \equiv \dfrac{\partial p_{\mathrm{e}}}{\partial z}$，但水团内的温度、密度、盐度未必与外界相等；
4. 准静态过程。水团的状态变化无限缓慢，在路径上总是处于热力学平衡态；
5. 水团对外界做功的唯一途径是做体积变化功（膨胀功）。

#### 结论

1. 温度 $T$ 上升。热力学第一定律 $\delta Q = \mathop{\mathrm{d} U} + \delta W$；下沉的水团被压缩，故对外做负的体积功即 $\delta W < 0 \xRightarrow{\delta Q = 0} \mathop{\mathrm{d} U} > 0 \Rightarrow T \uparrow.$
2. 位温 $\theta$ 守恒。因已假定水团进行绝热准静态过程，这是可逆过程，即若将水团以准静态过程移回海表面，其温度（这便是位温）将是初始温度。
3. 盐度 $S$ 不变。已假定水团为封闭系，则其质量 $m$ 和组分均不变，虽然体积 $V$ 减小使得盐的浓度上升，但盐度是按质量分数定义，故盐度不变。
4. 密度 $\rho$ 上升。$\rho \uparrow = \dfrac{m}{V \downarrow}.$
5. 声速一般不守恒。因声速是温度、盐度、压强的函数，而上面已指出水团的温度上升、压强增大。
6. 质量 $m$ 守恒。因已假定水团是封闭系。

## Question 2

Southern Ocean sea ice cycles between an areal extent of $2 \times 10^6 \mathop{\mathrm{km}}^2$ in summer to $16 \times 10^6 \mathop{\mathrm{km}^2}$ in winter. For the following calculation, make some very strong simplifying assumptions. Assume that sea ice is 50 cm thick once it forms. Assume that the salinity of sea ice is 3 psu.

1. Calculate the amount of salt (in kg and/or g) that is released into the ocean when this sea ice freezes seasonally.
2. Assuming that the underlying water has a salinity of 30 psu, and that all of the salt released from the sea ice is absorbed evenly in the top 100 m of the ocean and over the full region of the sea ice winter extent, calculate the total change in salinity of the top 100m of the ocean from summer to winter.

### Answer 2

1. 从夏季到冬季，由于新增海冰而释放的盐的质量
   $$\begin{aligned}
       \tag{2.1}
       \Delta M_{\text{salt}} & = - \rho_{\text{ice}} (A_{\text{winter}} - A_{\text{summer}}) h (S_{\text{ice}} - S_{\text{water}}) \\
       & = - (0.917 \times 10^{3}) \times ((16 - 2) \times 10^{12}) \times (0.5) \times ((3 - 30) \times 10^{-3}) \\
       & = 1.733 \times 10^{14} \mathop{\text{kg}}.
   \end{aligned}$$

2. 假定上题因海水凝固而释放的盐均匀分布到冰下厚度 $H = 100 \mathop{\text{m}}$ 的海水中，导致这层海水的盐度变为 $S'.$

    **解法一**（直接计算）

    新盐度
    $$\begin{aligned}
        \tag{2.2}
        S' & = \dfrac{M'_{\text{salt}}}{M'_{\text{water}}} \\
        & = \dfrac{\rho_{\text{water}} A_{\text{winter}} H S_{\text{water}}+ \Delta M_{\text{salt}}}{\rho_{\text{water}} A_{\text{winter}} H + \Delta M_{\text{salt}}} \\
        & = \dfrac{(1.025 \times 10^{3}) \times (16 \times 10^{12}) \times (100) \times (30 \times 10^{-3}) + (1.733 \times 10^{14})}{(1.025 \times 10^{3}) \times (16 \times 10^{12}) \times (100) + (1.733 \times 10^{14})} \\
        & = 30.102 \times 10^{-3},
    \end{aligned}$$
    从而 $S' - S_{\text{water}} = (30.102 - 30) \times 10^{-3} = 0.102 \times 10^{-3}.$

    **解法二**（用微分近似增量）

    海水盐度
    $$\begin{aligned}
        \tag{2.3}
        S & = S(M_{\text{salt}}; M_{\text{H}_2\text{O} (\text{l})}) = \dfrac{M_{\text{salt}}}{M_{\text{salt}} + M_{\text{H}_2\text{O} (\text{l})}} \\
        \Rightarrow \mathop{\mathrm{d} S} & = \dfrac{(1 - S) \mathop{\mathrm{d} M_{\text{salt}}}}{M_{\text{salt}} + M_{\text{H}_2\text{O} (\text{l})}} = \dfrac{(1 - S) \mathop{\mathrm{d} M_{\text{salt}}}}{M_{\text{water}}} \\
        \Rightarrow \Delta S & \approx \mathop{\mathrm{d} S} = \dfrac{(1 - S) \mathop{\Delta M_{\text{salt}}}}{\rho_{\text{water}} A_{\text{winter}} H} \\
        & = \dfrac{(1 - 30 \times 10^{-3}) \times (1.733 \times 10^{14})}{(1.025 \times 10^{3}) \times (16 \times 10^{12}) \times (100)} \\
        & = 0.103 \times 10^{-3}.
    \end{aligned}$$

## Question 3

In the eastern equatorial Pacific, there is annual mean heat gain of $150 \mathop{\mathrm{W} \cdot \mathrm{m}^2}.$

a) If this heat is applied to the top 50 m of the ocean, calculate how much it will warm in one year. If the initial temperature is 25°C, what is the final temperature?

b) The annual mean ocean temperature structure is approximately in steady state. The warming that you calculated in (a) is an annual mean value. Why doesn’t the equatorial ocean (or any part of the ocean) just keep warming until reaching the boiling point?

### Answer 3

1. 对于单位截面的厚 $H = 50 \mathop{\text{m}}$ 的水柱，年平均温度增加 $\Delta \overline{\theta} = \dfrac{\Delta \overline{Q}}{c_{\text{p}} M} = \dfrac{\overline{I} T_{\text{1 year}}}{c_{\text{p}} \rho H} = \dfrac{(150) \times (365.24 \times 24 \times 3600)}{4000 \times 1025 \times 50} = 23.09 \mathop{\text{K}} \xRightarrow{\overline{\theta}_0 = 25 \mathop{{^\circ \text{C}}}} \overline{\theta} = \overline{\theta}_0 + \Delta \overline{\theta} = 25 + 23.09 = 48.09 \mathop{{^\circ \text{C}}}.$
2. 热带地区海洋富余的热量，将通过大洋环流以及海气相互作用-大气环流等物理过程输送到热带外地区。The atmosphere transports most of the heat needed to warm latitudes higher than $35^{\circ}$. The oceanic meridional transport is comparable to the atmospheric meridional transport only in the tropics (Robert H Stewart, *Introduction to Physical Oceanography*, 2009).

## Question 4

The sea level rise due to the global warming is threatening many coastal areas in the world. The sea level rise by 1 meter would make many islands uninhabitable. To do the following problems, you would need these parameters: Specific heat capacity of sea water $c_{\mathrm{p}} = 4000 \mathop{\mathrm{J/(kg \cdot {^{\circ}\mathrm{C}})}}$, average ocean surface area $3.6 \times 10^{14} \mathop{\mathrm{m}^2}$, average sea water density $1025 \mathop{\mathrm{kg/m^3}}$, coefficient of thermal expansion $\alpha = - \dfrac{\Delta \rho}{\rho \mathop{\Delta T}} = 2.5 \times 10^{-4} \mathop{{^{\circ}\mathrm{C}}^{-1}}$, (here $\rho$ can be average sea water density).

a) Assume the heat received by the sea surface is homogeneously distributed over the upper 1000 meters of the ocean. If the sea level rises by 1 meter from now to year 2100, calculate how much heat flux would be needed (Unit: $\mathrm{W/m^2}$)

b) In the past 10 years, the heat flux received at the sea surface is about $2 \mathop{\mathrm{W/m^2}}$. How many meters would the sea level rise based on this value?

c) Assume the ratio between the density of sea ice and fresh water is 0.92, how much ice melting would be needed to reach the sea level rise calculated from (b)?

d) The Greenland ice shelf is about $3 \times 10^6 \mathop{\mathrm{km^3}}.$ In the worst scenario, all of the ice shelves are melted away, how many meters would the sea level rise?

### Answer 4

#### 模型

1. **平面平行海洋**。记海水温度 $T = T(z,t),$ 密度 $\rho = \rho(z,t),$ $p, \rho$ 有界，且除在 $z = -z_0$ 处外具有连续的二阶偏导数。又假定海水定压比热 $c_{\text{p}} \equiv 4000 \mathop{\text{J} \cdot \text{kg}^{-1} \cdot \text{K}^{-1}}.$
2. **上层均匀加热**。称原海平面高度 $z \in [-h_0, h']$ 的部分为**上层**，$h_0 = 1000 \mathop{\text{m}},$ $h' = h'(t)$ 为海平面上升量，$h'(0) = 0.$ 记上层厚度 $h = h(t):= h_0 + h'.$ 假定
   $$\begin{aligned}
       \tag{4.1}
       \left. \dfrac{\partial T}{\partial t} \right|_{z < -h_0} = 0; \quad \dfrac{\partial}{\partial z} \left( \dfrac{\partial T}{\partial t} \right) = 0, \quad \forall z \in (-h_0, h'].
   \end{aligned}$$

3. **上层质量守恒**。记 $\displaystyle \overline{\rho} = \overline{\rho}(t) := \dfrac{1}{h} \int_{-h_0}^{h'} \rho \mathop{\mathrm{d} z}, \quad \overline{\rho}_0 := \overline{\rho}(0).$ 假定
   $$\begin{aligned}
       \tag{4.2}
       \overline{\rho} h \equiv \overline{\rho}_0 h_0.
   \end{aligned}$$

#### 解

对于单位截面水柱，在单位时间内吸热
$$\begin{aligned}
    \tag{4.3}
    I = \int_{-\infty}^{h'} c_{\text{p}} \rho \dfrac{\partial T}{\partial t} \mathop{\mathrm{d} z} \xlongequal{(4.1)} c_{\text{p}} \overline{\rho} h \dfrac{\partial T}{\partial t},
\end{aligned}
$$
密度增加
$$\begin{aligned}
    \dfrac{\partial \rho}{\partial t} = - \alpha \rho \dfrac{\partial T}{\partial t}.
\end{aligned}
$$
对上式取 $z \in (-h_0, h']$ 上的算术平均，得
$$\begin{aligned}
    \tag{4.4}
    \dfrac{\mathop{\mathrm{d} \overline{\rho}}}{\mathop{\mathrm{d} t}} = -\alpha \overline{\rho} \dfrac{\partial T}{\partial t}.
\end{aligned}
$$
式 $(4.3)(4.4)$ 联立消去 $\dfrac{\partial T}{\partial t},$ 得
$$\begin{aligned}
    \tag{4.5}
    c_{\text{p}} h \mathop{\mathrm{d} \overline{\rho}} = -I \alpha \mathop{\mathrm{d} t},
\end{aligned}
$$
再由式 $(4.2)$ 消去 $\overline{\rho},$ 得
$$\begin{aligned}
    \tag{4.6}
    c_{\text{p}} \overline{\rho}_0 h_0 h^{-1} \mathop{\mathrm{d} h} = \alpha I \mathop{\mathrm{d} t}.
\end{aligned}
$$
上式从 $(t = 0, h = h_0)$ 到 $(t = t, h = h)$ 积分，得
$$\begin{aligned}
    \tag{4.7a}
    h = h_0 \exp \left( \dfrac{\alpha \overline{I} t}{c_{\text{p}} \overline{\rho}_0 h_0} \right)
\end{aligned}
$$
或
$$\begin{aligned}
    \tag{4.7b}
    \overline{I} = \dfrac{c_{\text{p}} \overline{\rho}_0 h_0}{\alpha t} \ln \dfrac{h}{h_0},
\end{aligned}
$$
式中 $\displaystyle \overline{I} := \dfrac 1t \int_0^t I \mathop{\mathrm{d} t}$ 是海平面净辐射通量密度的时间平均值。由上式得
$$\begin{aligned}
    \tag{4.8}
    \lim_{h' \to 0} \alpha \overline{I} t = c_{\text{p}} \overline{\rho}_0 h'.
\end{aligned}
$$

（a） 由式 $(\text{4.7b}),$ 需要的海平面净辐射通量密度
$$\begin{aligned}
    \overline{I} & = \dfrac{c_{\text{p}} \overline{\rho}_0 h_0}{\alpha t} \ln \dfrac{h}{h_0} \\
    & = \dfrac{4000 \times 1025 \times 1000}{(2.5 \times 10^{-4}) \times (100 \times 365.24 \times 24 \times 3600)} \ln \dfrac{1001}{1000}\\
    & = 5.19 \mathop{\text{W} / \mathrm{m}^2}.
\end{aligned}
$$

（b）由式 $(\text{4.7a}),$ 海平面将上升
$$\begin{aligned}
    h' & = h - h_0 = h_0 \left[ \exp \left( \dfrac{\alpha \overline{I} t}{c_{\text{p}} \overline{\rho}_0 h_0} \right) - 1 \right]\\
    & = 1000 \left[ \exp \left( \dfrac{(2.5 \times 10^{-4}) \times 2 \times (10 \times 365.24 \times 24 \times 3600)}{4000 \times 1025 \times 1000} \right) - 1 \right]\\
    & = 0.0385 \mathop{\text{m}} = 3.85 \mathop{\text{cm}}.
\end{aligned}
$$

（c）需要融化
$$
\rho_{\text{ice}} A h' = 920 \times (3.6 \times 10^{14}) \times 0.0385 = 1.28 \times 10^{16} \mathop{\text{kg}}
$$
的海冰。

（d）海平面将上升
$$
h' = \dfrac{\rho_{\text{ice}} V_{\text{shelf}}}{\overline{\rho} A} = \dfrac{920 \times (3 \times 10^{6 + 9})}{1025 \times (3.6 \times 10^{14})} = 7.48 \mathop{\text{m}}.
$$
