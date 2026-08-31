# OpenROAD Sky130HD Result Summary

Design: `riscv_fir_accelerator_top`

| Metric | Result |
| --- | --- |
| Flow status | Completed through final GDS |
| Technology | SkyWater Sky130HD |
| Minimum clock period | 9.60 ns |
| Estimated Fmax | 104.14 MHz |
| Final design area | 7610 um^2 |
| Final utilization | 44% |
| WNS | 0.00 ns |
| TNS | 0.00 ns |
| Setup violations | 0 |
| Hold violations | 0 |
| Detailed-route DRC violations | 0 |
| Antenna violations | 0 |
| Estimated total power | 1.30 mW |
| Worst VDD IR drop | 0.102 mV |

## Included Evidence

| File | Purpose |
| --- | --- |
| `riscv_fir_accelerator_top_gds.png` | Rendered screenshot of the final GDS layout. |
| `reports/synth_stat.txt` | Yosys synthesis area/cell summary. |
| `reports/synth_check.txt` | Yosys structural check output. |
| `reports/2_floorplan_final.rpt` | Floorplan-stage timing/report snapshot. |
| `reports/3_global_place.rpt` | Global-placement timing/report snapshot. |
| `reports/4_cts_final.rpt` | Clock-tree synthesis timing/report snapshot. |
| `reports/5_route_drc.rpt` | Detailed-route DRC report; empty means no reported DRC violations. |
| `reports/grt_antennas.log` | Global-route antenna log; empty means no reported violations. |
| `reports/drt_antennas.log` | Detailed-route antenna log; empty means no reported violations. |
| `reports/6_finish.rpt` | Final timing report with WNS/TNS/Fmax. |
