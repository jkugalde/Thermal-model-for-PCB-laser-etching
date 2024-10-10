# Thermal model for PCB laser etching

## Context

A PCBs is a printed circuit board, which usually is the part of an electronic/mechatronic system that serves as a chasis for electronics and its connections. The PCB is usually a copper plated non conductive and rigid material, where the copper is removed to generate the connection paths. The copper can be removed trough milling (cutting) or through chemical etching.

Laser etching is a process that removes paint previously applied on the copper surface of a PCB. The PCB is then exposed to a chemical that removes the exposed copper, generating the paths.

This is part of the laboratory project in the course Advanced Manufacturing Processes B at POLIMI, the idea is to procude custom PCBs on demand. We will use Matlab to generate a point heat source model, the results will be compared and adjusted based on experiments done in a Snapmaker 2.0, in order to obtain optimal process parameters.

### 3D Heat point source model 

Heat propagation in $x,y,z$ directions from a point in the material, quasi-stationary considering relative coordinates moving with the laser in direction $\xi$ with speed $v$. Supposes:

- No convection or radiation
- Constant ambient temperature $T_{0}$
- Steady state conditions
- Homogeneous and isotropic material
- Constant thermal properties


 $ T(\xi , y , z) = T_{0}+ \eta \cdot \frac{P}{2 \pi k r} e^{\frac{-v}{2 \alpha}(\xi +r)} $

Where:

- $\eta$ is the process efficiency
- $k$ conductivity of the material ($W/mK$)
- $\alpha=k/\rho c_{p}$ is the thermal diffusivity ($m^{2}/s$)

The radius $r$ is defined as:

$r=\sqrt( \xi^{2} + y^{2} + (c_{z}z)^{2} ) $

$c_{z}$ is an empirical coefficient in the workpiece.

The ablation of the material will be considered in every section where the material is greather or equal than its vaporization temperature $T_{vap}$.

### Material and process parameters

We will be using a resin with the following properties:

- $k = 0.3$ $W/mK$
- $\rho=1450$ $kg/m^3$ 
- $T_{vap}=300$ $°C$ 
- $c_{p}=1450$ $J/kgK$ 

The process parameters are:

- $v=800$ $mm/min$
- $P=1600$ $mW$
- $c_{z}=10$
- $\eta=0.27$

The efficiency $\eta$ was calibrated to obtain a simulated width similar to the experimental width. The average experimental width for black paint was $170.8 um$, using 5 data points.

### Results

The current simulated path width is around $171 um$, and the max depth is $8.4 um$. Only the xy graphs below have the right proprortions.

<img src="/img/xy.png" width="600">
<img src="/img/xywidth.png" width="600">
<img src="/img/xz.png" width="600">
<img src="/img/xzdepth.png" width="600">
<img src="/img/yz.png" width="600">
<img src="/img/yzdepth.png" width="600">