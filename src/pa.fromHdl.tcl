
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Taxi -dir "E:/fpga/homework2/Taxi/planAhead_run_1" -part xc3s100ecp132-5
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "taxi_top.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {seg7ment_sub.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {light_sub.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {findfnum_sub.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {taxi_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top taxi_top $srcset
add_files [list {taxi_top.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s100ecp132-5
