onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -unsigned /LCM_tb/A /LCM_tb/B /LCM_tb/result /LCM_tb/req_AB /LCM_tb/ack_AB /LCM_tb/req_result /LCM_tb/ack_result

add wave -hex     -group DATAPATH /lcm_tb/lcm_calc/m1_dataA \
                                   /lcm_tb/lcm_calc/m1_dataB \
                                   /lcm_tb/lcm_calc/m1_dataC \
                                   /lcm_tb/lcm_calc/fr1_dataB \
         -label "cmp1 sumA > sumB" /lcm_tb/lcm_calc/cmp1_out_data

add wave -hex      -group DATAPATH /lcm_tb/lcm_calc/mrg1_dataC \
         -label "cmp2 sumA = sumB" /lcm_tb/lcm_calc/cmp2_out_data  \

add wave -hex -group LCM_CALC /lcm_tb/lcm_calc/*
add wave -ports -hex -group f1_fork_select_in_output /lcm_tb/lcm_calc/f1_fork_select_in_output/*
add wave -ports -hex -group r2_buffer_datapath       /lcm_tb/lcm_calc/r2_buffer_datapath/*
add wave -ports -hex -group r1_buffer_input_sel      /lcm_tb/lcm_calc/r1_buffer_input_sel/*
add wave -ports -hex -group de2_choose_result        /lcm_tb/lcm_calc/de2_choose_result/*
add wave -ports -hex -group cmp2_sA_ne_sB            /lcm_tb/lcm_calc/cmp2_sA_ne_sB/*
add wave -ports -hex -group fr2_fork_reg             /lcm_tb/lcm_calc/fr2_fork_reg/*
add wave -ports -hex -group add2_B_sumB              /lcm_tb/lcm_calc/add2_B_sumB/*
add wave -ports -hex -group mrg1_merge_sums          /lcm_tb/lcm_calc/mrg1_merge_sums/*
add wave -ports -hex -group add1_A_sumA              /lcm_tb/lcm_calc/add1_A_sumA/*
add wave -ports -hex -group de1_choose_sum           /lcm_tb/lcm_calc/de1_choose_sum/*
add wave -ports -hex -group cmp1_sA_g_sB             /lcm_tb/lcm_calc/cmp1_sA_g_sB/*
add wave -ports -hex -group fr1_fork_reg             /lcm_tb/lcm_calc/fr1_fork_reg/*
add wave -ports -hex -group m1_select_input          /lcm_tb/lcm_calc/m1_select_input/*

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
configure wave -timelineunits ns
update
