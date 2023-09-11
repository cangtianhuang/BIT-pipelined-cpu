# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.cache/wt [current_project]
set_property parent.project_path E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo e:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/definitions.vh
read_verilog -library xil_defaultlib {
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/alu.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/control_unit.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/data_memory.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/extend.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/forwarding_unit.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/instruction_memory.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/mux.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/npc.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/pc.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/reg_ex_mem.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/reg_id_ex.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/reg_if_id.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/reg_mem_wb.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/register_file.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/hazard_unit.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/branch.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/BIT_cpu.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/test_pressINC_control.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/light_control.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/key_rebounce.v
  E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/sources_1/new/direct_jump.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/constrs_1/new/test_press_cons.xdc
set_property used_in_implementation false [get_files E:/Xilinx/MyVivadoStudy/BIT_pipelined_cpu/BIT_pipelined_cpu.srcs/constrs_1/new/test_press_cons.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top test_pressINC_control -part xc7a35tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef test_pressINC_control.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file test_pressINC_control_utilization_synth.rpt -pb test_pressINC_control_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]