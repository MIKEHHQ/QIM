# QIM

Quantization-in-Memory (QIM) characterization data, circuit benchmarks and a
Q-cell transistor-level connectivity netlist.

| Directory | Files and contents |
| --- | --- |
| [0_quantization](0_quantization) | `measured_boundaries.csv`: 31 switching boundaries; `code_intervals.csv`: 32 quantization intervals; `input_code_decoder.csv`: 251 input-voltage/code pairs; `metadata.json`: range, encoding and source checksums. |
| [1_ssr](1_ssr) | `ssr_decisions.csv`: 1,000 paired decisions and quantization values for Staggered-State Resolution (SSR). |
| [2_boundary_programming](2_boundary_programming) | `convergence.csv`: boundary-placement controller example; `operation_counts.csv`: conductance-read and voltage-probe counts. |
| [3_system_benchmark](3_system_benchmark) | `adc_costs.csv`: ADC costs and reductions; `system_costs.csv`: system component costs and shares; `cost_assumptions.json`: technology-normalization and core-cost inputs. |
| [4_netlist](4_netlist) | `qcell_connectivity.sp`: SPICE-format Q-cell connectivity, including input branches, bias pull-up and output stage. |

## Quantization characterization

Switching boundaries were extracted from individual Q-cell input-voltage
sweeps. The static code table evaluates those measured boundaries over
0.70–1.20 V in 2 mV steps. `conversion_code` is an integer from 0 to 31;
`decoder_output_5b` is the corresponding unsigned natural-binary code, D4 to D0.
Read the binary column as text to preserve leading zeros.

Boundary and input voltages are in V. Intervals include their lower endpoint
and exclude their upper endpoint, except that 1.20 V belongs to code 31.
The nominal LSB is 15.625 mV. The 31 boundaries yield maximum absolute
INL/DNL of 0.303/0.503 LSB.

## SSR decision data

The table contains 10 repeats of 100 input points near a 0.98125 V boundary.
`C1_bit` and `C2_bit` are logical decisions; `disagreement` is their XOR.
The `*_value_v` columns contain mapped quantization values in V.
Agreement selects a neighboring value and disagreement selects the target value.

The paired data use a common input grid. C2 underwent a +7.035875 mV input-axis
alignment and linear interpolation with constant endpoint extension before
decision extraction. The file contains the resulting processed decisions.

## Boundary-programming benchmark

The controller example uses a 0.856 V target and 5 mV acceptance tolerance.
Conductance is in uS, boundary voltage in V and boundary error in mV.
The sequence is a numerical illustration of feedback decisions.

Verification-operation counts use 32 boundaries and 10 rounds:
1600 conductance reads (5 × 32 × 10), 10000 scan probes (1000 × 10),
and 640 Dual-V probes (2 × 32 × 10). These count verification operations.

## System-level benchmark

VGG8 and ResNet18 costs are model estimates using existing network mappings.
`cost_unit` identifies area in um2 and energy in pJ per image; divide by 1e6
for mm2 or microjoules per image. Shares and reductions are percentages.

The core inputs are 54 um2 at 28 nm and 20.736 fJ/conversion. Area is
normalized to 14 nm as 54 × (14/28)^2 = 13.5 um2; energy is unchanged.
ADC costs are rescaled from prior unit costs of 24.2944 um2 and 12.58 fJ.
Non-ADC costs follow the respective SAR and QIM model configurations.

## Q-cell netlist

The netlist contains six NMOS, three PMOS and two memristor instances.
MOS terminals are ordered drain, gate, source, bulk; memristors have two terminals.
`V_PU` controls the pull-up gate, `VIN_A/VIN_B` drive the two input branches,
`ML` is the decision node and `VOUT` is the restored logic output.
The remaining ports are supply and source-reference connections.

Generic device identifiers preserve connectivity. Circuit simulation requires
device models, sizing and bias definitions supplied separately. The distributed
file contains no foundry-library references or process/layout parameters.

## License

All repository materials are licensed under
[Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)](https://creativecommons.org/licenses/by-nc/4.0/).
Sharing and adaptation are permitted with attribution for noncommercial use.
See [LICENSE](LICENSE) for the full terms.
