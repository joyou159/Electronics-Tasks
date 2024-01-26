
module DL (
SW,
KEY,
CLOCK_50,
HEX4,
HEX2,
HEX1,
HEX0,
HEX6,
HEX7,
LEDG,
LEDR
);
input [17:0]SW;
input [3:0]KEY;
input CLOCK_50;
output [6:0]HEX4;
output [6:0]HEX2;
output [6:0]HEX1;
output [6:0]HEX0;
output [6:0]HEX6;
output [6:0]HEX7;
output [7:0]LEDG;
output [17:0]LEDR;

DL_TOP TOP(
.i_digit(SW[3:0]),
.i_confirm_getter(KEY[1]),
.i_reset(KEY[3]),
.i_clk(CLOCK_50),
.i_confirm_FSM(KEY[0]),
.i_switch(KEY[2]),
.i_en(SW[4]),
.o_input_7seg(HEX4),
.o_pass_7seg_2(HEX2),
.o_pass_7seg_1(HEX1),
.o_pass_7seg_0(HEX0),
.o_trials_7seg(HEX6),
.o_state_7seg(HEX7),
.o_LED_correct(LEDG[7]),
.o_LED_incorrect(LEDR[0])

);
endmodule 