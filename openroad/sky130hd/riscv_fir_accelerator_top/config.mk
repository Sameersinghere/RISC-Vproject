export DESIGN_NICKNAME = riscv_fir_accelerator_top
export DESIGN_NAME = riscv_fir_accelerator_top
export PLATFORM = sky130hd

export REPO_HOME := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../../..)

export VERILOG_FILES = \
  $(REPO_HOME)/msrv32_instruction_mux.v \
  $(REPO_HOME)/low_power_fir.v \
  $(REPO_HOME)/riscv_fir_accelerator_top.v

export SDC_FILE = $(REPO_HOME)/openroad/sky130hd/riscv_fir_accelerator_top/constraint.sdc

export CORE_UTILIZATION = 35
export CORE_ASPECT_RATIO = 1
export CORE_MARGIN = 2
export PLACE_DENSITY = 0.55

export SYNTH_HDL_FRONTEND = yosys
