* QIM Q-cell connectivity
* MOS terminal order: drain gate source bulk.
* Memristor terminal order: terminal_1 terminal_2.
* NMOS_GENERIC, PMOS_GENERIC and MEMRISTOR are device-type placeholders.
* This file describes topology; device models and sizing are not supplied.

.SUBCKT QIM_QCELL V_PU VIN_A VIN_B VOUT VDD_INV VDD_ML VDD_R VSS VSS_R

* Bias pull-up and output restoration
MPM1 ML V_PU VDD_ML VDD_ML PMOS_GENERIC
MPM2 VOUT ML VDD_ML VDD_ML PMOS_GENERIC
MNM5 VOUT ML VSS VSS NMOS_GENERIC

* Input branch A
XMEM_A VDD_R NODE_A MEMRISTOR
MNM1 NODE_A VIN_A VSS_R VSS NMOS_GENERIC
MNM3 ML NODE_A VSS VSS NMOS_GENERIC

* Input branch B and logic inversion
XMEM_B VDD_R NODE_B MEMRISTOR
MNM2 NODE_B VIN_B VSS_R VSS NMOS_GENERIC
MPM0 INV_B NODE_B VDD_INV VDD_INV PMOS_GENERIC
MNM0 INV_B NODE_B VSS VSS NMOS_GENERIC
MNM4 ML INV_B VSS VSS NMOS_GENERIC

.ENDS QIM_QCELL
