IVERILOG ?= iverilog
VVP ?= vvp

VERILOG_SOURCES = imm_gen.v immediate_generation.v msrv32_instruction_mux.v \
	msrv32_integer_file.v msrv32_wr_en_generator.v low_power_fir.v \
	riscv_fir_accelerator_top.v msrv32_pc.v

.PHONY: test waveforms clean

test: build/tb_imm_gen.vvp build/tb_low_power_fir.vvp build/tb_integer_file.vvp
	$(VVP) build/tb_imm_gen.vvp
	$(VVP) build/tb_low_power_fir.vvp
	$(VVP) build/tb_integer_file.vvp

waveforms: test
	@echo "Waveforms:"
	@echo "  build/tb_imm_gen.vcd"
	@echo "  build/tb_low_power_fir.vcd"
	@echo "  build/tb_integer_file.vcd"

build:
	mkdir -p build

build/tb_imm_gen.vvp: build imm_gen.v immediate_generation.v tb_imm_gen.v
	$(IVERILOG) -g2012 -o $@ imm_gen.v immediate_generation.v tb_imm_gen.v

build/tb_low_power_fir.vvp: build low_power_fir.v tb_low_power_fir.v
	$(IVERILOG) -g2012 -o $@ low_power_fir.v tb_low_power_fir.v

build/tb_integer_file.vvp: build msrv32_integer_file.v tb_integer_file.v
	$(IVERILOG) -g2012 -o $@ msrv32_integer_file.v tb_integer_file.v

clean:
	rm -rf build
