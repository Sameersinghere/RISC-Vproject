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
make DESIGN_CONFIG=/absolute/path/to/RISC-Vproject/openroad/sky130hd/riscv_fir_accelerator_top/config.mk
```

The design uses:

- Platform: `sky130hd`
- Top module: `riscv_fir_accelerator_top`
- Clock: `clk_in`
- Target period: 20 ns

## Run With Docker

Mount this repository inside the OpenROAD-flow-scripts container, then run the same `make DESIGN_CONFIG=...` command from `/OpenROAD-flow-scripts/flow`.

The normal RTL functional tests remain separate:

```sh
make test
```
