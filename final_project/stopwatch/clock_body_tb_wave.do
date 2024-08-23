onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /clock_body_tb/dut/clk
add wave -noupdate /clock_body_tb/dut/reset
add wave -noupdate -radix unsigned /clock_body_tb/dut/x
add wave -noupdate -radix unsigned /clock_body_tb/dut/y
add wave -noupdate /clock_body_tb/dut/clk_done
add wave -noupdate -radix unsigned /clock_body_tb/dut/counter
add wave -noupdate /clock_body_tb/dut/done
add wave -noupdate /clock_body_tb/dut/done_l
add wave -noupdate /clock_body_tb/dut/start
add wave -noupdate -radix unsigned /clock_body_tb/dut/x0
add wave -noupdate -radix unsigned /clock_body_tb/dut/y0
add wave -noupdate -radix unsigned /clock_body_tb/dut/x1
add wave -noupdate -radix unsigned /clock_body_tb/dut/y1
add wave -noupdate -radix unsigned /clock_body_tb/dut/x_l
add wave -noupdate -radix unsigned /clock_body_tb/dut/y_l
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {61953 ps} 0}
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
WaveRestoreZoom {60650 ps} {62650 ps}
