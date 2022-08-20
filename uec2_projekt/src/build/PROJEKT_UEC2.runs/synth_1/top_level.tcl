# 
# Synthesis run script generated by Vivado
# 

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
set_param synth.elaboration.rodinMoreOptions {rt::set_parameter var_size_limit 1572865}
set_param xicom.use_bs_reader 1
set_param synth.incrementalSynthesisCache C:/Users/bened/Desktop/Proj/uec2_projekt/src/.Xil/Vivado-22212-DESKTOP-E1S6T55/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.cache/wt [current_project]
set_property parent.project_path C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/ov7670_fr/RGB.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/ov7670_fr/address_Generator.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/basys3_ov7670/clocking.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/basys3_ov7670/clocking_clk_wiz.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/ov7670_fr/debounce.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/basys3_ov7670/i2c_sender.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/ov7670_fr/ov7670_capture.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/ov7670_fr/ov7670_controller.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/basys3_ov7670/ov7670_registers.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/ov7670_fr/vga.v
  C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/imports/ov7670_fr/top_level.v
}
read_ip -quiet C:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/ip/frame_buffer/frame_buffer.xci
set_property used_in_implementation false [get_files -all c:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/ip/frame_buffer/frame_buffer_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/bened/Desktop/Proj/uec2_projekt/src/constraints/project_constraints.xdc
set_property used_in_implementation false [get_files C:/Users/bened/Desktop/Proj/uec2_projekt/src/constraints/project_constraints.xdc]


synth_design -top top_level -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top_level.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_level_utilization_synth.rpt -pb top_level_utilization_synth.pb"
