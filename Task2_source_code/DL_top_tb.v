`timescale 1ps/1ps
module DL_top_tb ();
// input declaration 
reg [3:0] i_digit;
reg i_confirm_getter;
reg i_confirm_FSM;
reg i_hard_reset;
reg i_en_display;
reg i_switch;
reg clk;
// output declaration 
wire o_correct_led;
wire  o_incorrect_led;
wire [6:0] o_state_7seg;
wire [6:0] o_trials_7seg;
wire [6:0] o_7seg0;
wire [6:0] o_7seg1;
wire [6:0] o_7seg2;
wire [6:0] o_7seg_input;

integer i;
initial begin
$monitor (
"[%t]\ti_digit = %h\ti_confirm_FSM = %b\ti_hard_reset = %d\ti_switch =%d\ti_en_display = %b\to_correct_led = %b\to_incorrect_led = %b\to_trials_7seg = %b\to_7seg0 = %b\to_7seg1 = %b\to_7seg2 = %b\to_7seg_input = %b\to_state_7seg = %b",
$time,i_digit,i_confirm_FSM,i_hard_reset,i_switch,i_en_display,o_correct_led,o_incorrect_led,o_trials_7seg,o_7seg0, o_7seg1,o_7seg2,o_7seg_input,o_state_7seg);
end



// instantiation of the unit under test 
DL_top #(500) UUT (
.i_digit(i_digit),
.i_confirm_getter(i_confirm_getter),
.i_confirm_FSM(i_confirm_FSM),
.i_hard_reset(i_hard_reset),
.i_en_display(i_en_display),
.i_switch(i_switch),
.i_clk(clk),
.o_7seg_input(o_7seg_input),
.o_7seg0(o_7seg0),
.o_7seg1(o_7seg1),
.o_7seg2(o_7seg2),
.o_state_7seg(o_state_7seg),
.o_trials_7seg(o_trials_7seg),
.o_correct_led(o_correct_led),
.o_incorrect_led(o_incorrect_led)
);
// generation of the clock 
initial clk = 0;
always #1 clk = ~clk;
// initialization 
initial 
begin 
i_digit = 4'd0;
i_confirm_getter = 0;
i_confirm_FSM = 0; 
i_hard_reset= 0;
i_en_display = 1;
i_switch= 0;
end 
// testing different states and inputs 
initial 
begin
//reset testing 
#50 i_hard_reset = 1;
#50 i_hard_reset = 0;
// initial state testing and displaying functionality
#50 i_digit = 4'hB;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'hA;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'hD;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_confirm_FSM = 1;
#50 i_confirm_FSM = 0;
#50 i_en_display = 0;
// verify state testing with correct password
#50 i_digit = 4'hB;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'hA;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'hD;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_confirm_FSM = 1;
#50 i_confirm_FSM = 0;
// verify state testing with incorrect password leading to freeze state 
for (i=0;i<3;i = i + 1)
begin
#50 i_digit = 4'hf;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'ha;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'hd;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_confirm_FSM = 1;
#50 i_confirm_FSM = 0;
end
// freeze state testing 
#50 i_digit = 4'hf;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'ha;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'hd;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_confirm_FSM = 1;
#50 i_confirm_FSM = 0;
#50 i_switch = 1;
#50 i_switch = 0;
// hard reset testing 
#50 i_hard_reset = 1;
#50 i_hard_reset = 0;
#50 i_digit = 4'hf;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'ha;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'hd;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_confirm_FSM = 1;
#50 i_confirm_FSM = 0;
// set state testing 
#50 i_switch = 1;
#50 i_switch = 0;
#50 i_digit = 4'h9;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'h1;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'ha;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_confirm_FSM = 1;
#50 i_confirm_FSM = 0;
#50 i_digit = 4'h9;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'h1;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_digit = 4'ha;
#50 i_confirm_getter = 1;
#50 i_confirm_getter = 0;
#50 i_confirm_FSM = 1;
#50 i_confirm_FSM = 0;
#50 $stop;
end 

endmodule 
