onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /clock_arm_tb/dut/clk
add wave -noupdate /clock_arm_tb/dut/reset
add wave -noupdate /clock_arm_tb/dut/one_second
add wave -noupdate -radix unsigned /clock_arm_tb/dut/x
add wave -noupdate -radix unsigned /clock_arm_tb/dut/y
add wave -noupdate -radix unsigned /clock_arm_tb/dut/centrex
add wave -noupdate -radix unsigned /clock_arm_tb/dut/centrey
add wave -noupdate /clock_arm_tb/dut/done
add wave -noupdate /clock_arm_tb/dut/start
add wave -noupdate -radix unsigned /clock_arm_tb/dut/x_f
add wave -noupdate -radix unsigned /clock_arm_tb/dut/y_f
add wave -noupdate -radix unsigned /clock_arm_tb/dut/x_t
add wave -noupdate -radix unsigned /clock_arm_tb/dut/y_t
add wave -noupdate -radix unsigned /clock_arm_tb/dut/counter
add wave -noupdate /clock_arm_tb/dut/fifteen
add wave -noupdate /clock_arm_tb/dut/thirty
add wave -noupdate /clock_arm_tb/dut/fortyfive
add wave -noupdate /clock_arm_tb/dut/timer
add wave -noupdate /clock_arm_tb/dut/start_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11944 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {10514 ps} {12562 ps}
