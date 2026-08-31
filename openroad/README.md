# OpenROAD Physical Design Flow

This directory contains an out-of-tree OpenROAD-flow-scripts setup for the FIR accelerator top.

## Prerequisites

Install OpenROAD-flow-scripts with the Sky130 platform enabled. The easiest route is the official Docker image:

```sh
docker pull openroad/orfs:latest
```

You can also use a local OpenROAD-flow-scripts checkout.

## Run With A Local OpenROAD-flow-scripts Checkout

From the `flow` directory of OpenROAD-flow-scripts:

```sh
make DESIGN_CONFIG=/absolute/path/to/RISC-Vproject/openroad/sky130hd/riscv_fir_accelerator_top/config.mk \
  OPENROAD_EXE=/path/to/openroad \
  YOSYS_EXE=/path/to/yosys \
  PYTHON_EXE=/path/to/python3 final
```

The design uses:

- Platform: `sky130hd`
- Top module: `riscv_fir_accelerator_top`
- Clock: `clk_in`
- Target period: 20 ns

## Local Sky130 Run Summary

The design was run through OpenROAD-flow-scripts on Sky130HD through detailed routing and final OpenROAD reporting.

The committed result summary, report snapshots, and final GDS screenshot are under `openroad/results/`.

| Metric | Result |
| --- | ---: |
| Synthesized area | 6090 um^2 |
| Final design area | 7610 um^2 |
| Final utilization | 44% |
| Minimum clock period | 9.60 ns |
| Estimated Fmax | 104.14 MHz |
| Worst negative slack | 0.00 ns |
| Total negative slack | 0.00 ns |
| Setup violations | 0 |
| Hold violations | 0 |
| Detailed-route violations | 0 |
| Antenna violations | 0 |
| Estimated total power | 1.30 mW |
| Worst VDD IR drop | 0.102 mV |

Generated artifacts included final ODB, DEF, SPEF, SDC, gate-level Verilog, and merged GDS. GDS merge was verified with KLayout 0.30.12 with matching LEF/GDS cells and no orphan cells.

## Run With Docker

Mount this repository inside the OpenROAD-flow-scripts container, then run the same `make DESIGN_CONFIG=...` command from `/OpenROAD-flow-scripts/flow`.

The normal RTL functional tests remain separate:

```sh
make test
```
