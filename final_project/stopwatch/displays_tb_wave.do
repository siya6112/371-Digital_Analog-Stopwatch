onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /displays_tb/dut/clk
add wave -noupdate /displays_tb/dut/reset
add wave -noupdate /displays_tb/dut/one_second
add wave -noupdate /displays_tb/dut/start_clk
add wave -noupdate /displays_tb/dut/fifteen
add wave -noupdate /displays_tb/dut/thirty
add wave -noupdate /displays_tb/dut/fortyfive
add wave -noupdate /displays_tb/dut/timer
add wave -noupdate -radix binary /displays_tb/dut/H0
add wave -noupdate -radix binary /displays_tb/dut/H1
add wave -noupdate -radix binary /displays_tb/dut/H3
add wave -noupdate /displays_tb/dut/done_time
add wave -noupdate -radix unsigned /displays_tb/dut/minutes
add wave -noupdate -radix unsigned /displays_tb/dut/tens
add wave -noupdate /displays_tb/dut/ps
add wave -noupdate /displays_tb/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {1 ns}
