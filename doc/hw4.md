# 作业 4

研-MS6401H-440-M01-物理海洋学

* [课程主页](https://grwei.github.io/SJTU_2021-2022-1-MS6401H/)
* [个人主页](https://grwei.github.io/)

[toc]

## Question 1

(a) A steady westward wind blows across an ocean basin which is $3000 \mathop{\text{km}}$ wide. The surface wind stress measured at $5^{\circ}$ north and $5^{\circ}$ south is $0.08 \mathop{\text{N} / \text{m}^2}$. Calculate the net Ekman mass transport at these two latitude. What is the average rate of upwelling in m/s between $5^{\circ}$ north and $5^{\circ}$ south?

**Answer:**

$$\begin{aligned}
    \tag{1}
    M_x & = \dfrac{T_y(0)}{f} = 0,\\
    M_y^{(5^{\circ} \text{N/S})} & = - \dfrac{T_x(0)}{f}\\
    & = - \dfrac{- 0.08}{2 \times (7.27 \times 10^{-5}) \times \sin{(\pm 5^{\circ}})}\\
    & = \pm 6.311 \times 10^3 \mathop{\text{kg} / (\text{m} \cdot \text{s})}.
\end{aligned}
$$

风区 Ekman 层底平均上升流速
$$\begin{aligned}
    \tag{2}
    \overline{w} = \dfrac{M_y^{(5^{\circ} \text{N})} - M_y^{(5^{\circ} \text{S})}}{\rho Y} = \dfrac{6.311 \times 10^3 - (-6.311 \times 10^3)}{1027 \times (6371 \times 10^3 \times (10 / 180) \pi)}= 1.11 \times 10^{-5} \mathop{\text{m} / \text{s}}.
\end{aligned}
$$

(b) Suppose the water upwelling between $5^{\circ}$ north and $5^{\circ}$ south has a temperature of $24 \mathop{^{\circ}\text{C}}$. Furthermore, the mean temperature of the water flowing across $5^{\circ}$ latitude in the Ekman layer is $28 \mathop{^{\circ}\text{C}}$. Calculate the mean ocean heating over this region (in $\mathop{\text{W} / \text{m}^2}$)

**Answer:**

由 $\overline{I} Y = c_p (M_y^{(5^{\circ} \text{N})} - M_y^{(5^{\circ} \text{S})}) \Delta T,$
$$
\begin{aligned}
    \tag{3}
    \overline{I} & = Y^{-1} c_p (M_y^{(5^{\circ} \text{N})} - M_y^{(5^{\circ} \text{S})}) \Delta T\\
    & = (6371 \times 10^3 \times (10 / 180) \pi)^{-1} \times 4200 \times (2 \times (6.311 \times 10^3)) \times 4\\
    & = 191 \mathop{\text{W} / \mathrm{m}^2}.
\end{aligned}
$$

## Question 2

Along the equator in the Pacific Ocean, the prevailing winds are easterlies (trades).

(a) Is the sea surface in the western equatorial Pacific HIGH or LOW compared with the sea surface in the eastern Pacific? Explain. Why does this differ from the sea surface height beneath the trades/westerlies in the subtropical North Pacific?

**Answer:**

赤道太平洋海表面为西高东低，因向西的信风使海水向西堆积.
副热带北太平洋海面较高，是因为其北有西风带引起的向南的 Ekman 输运，其南有信风带引起的向北的 Ekman 输运，致副热带北太平洋表层有辐聚，抬高了海面.

(b) Is the sea surface in the western Pacific WARM or COLD compared with the sea surface in the eastern Pacific? Explain briefly why the SST in one region is warm and cold in the other.

**Answer:**

西太平洋 SST 比东太平洋高，因为信风使海表暖水向西堆积，形成西太平洋暖池；而东太平洋沿岸的上升流将较冷的海水带到海表，形成西太平洋冷舌。

(c) How does this distribution of sea surface temperature from west to east in the Pacific help to sustain the equatorial trade winds? [What is the name of the equatorial atmospheric circulation – winds - associated with this equatorial SST distribution?]

**Answer:**

赤道太平洋西暖冬冷的 SST 分布，使海表面气压西低东高，引起纬向的 Walker 环流：西太暖池有上升气流，东太冷舌有下沉气流，利于海表面向西的信风的维持，并在上空形成西风.

(e) During an El Nino event, the atmospheric circulation of part (c) weakens. What does this do to the ocean circulation at the sea surface along the equator?

**Answer:**

Walker 环流减弱，使得 North and South Equatorial Currents（向西）减弱.

(f) What would (e) do to the SST distribution along the equator? What in turn does this do to the atmospheric circulation?

**Answer:**

North and South Equatorial Currents 减弱，使西太暖池减弱东移，引起西太 SST 负异常、中东太平洋 SST 正异常，造成西太海表面气压升高、西太海表面气压降低，而这又进一步削弱 Walker 环流.

(g) If an El Nino event lasted for a while, would you expect a response in the Equatorial Undercurrent? Why?

**Answer:**

Equatorial Undercurrent 是出现在赤道海区几十至几百米深度的一支向**东**的洋流，与海表面 North and South Equatorial Currents 的流向相反.
若 El Nino 持续发生，使得 Equatorial Currents 持续偏弱，可能使得 Equatorial Undercurrent 减弱.

(h) The equatorial thermocline in the eastern Pacific, as marked by the $20 \mathop{^{\circ}\text{C}}$ isotherm, is centered at $70$ meters depth. The vertical temperature gradient through the thermocline is $0.1 \mathop{^{\circ}\text{C} / \text{meter}}$. How far up or down must the $20 \mathop{^{\circ}\text{C}}$ isotherm move in order to produce a positive (warm) $5^{\circ} \text{C}$ temperature anomaly at $70$ meters depth?

**Answer:**

$20 \mathop{^{\circ}\text{C}}$ isotherm 要下移 $5 / 0.1 = 50$ 米.
