# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./DE1_SoC.sv"
vlog "./*.sv"
vlog "./RAM_x0.v"
vlog "./RAM_y0.v"
vlog "./RAM_x1.v"
vlog "./RAM_y1.v"
vlog "./RAM_arm_y.v"
vlog "./RAM_arm_x.v"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work displays_tb -Lf altera_mf_ver -Lf altera_lnsim_ver

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do displays_tb_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
