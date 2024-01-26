`timescale 1ns/1ps
module FSM_DL_tb();
//inputs
reg [11:0]password;
reg confirm;
reg switch;
reg reset;
reg clk;
//outputs
wire correct;
wire incorrect;
wire [1:0] trials;
wire [2:0]state;
// instantiate the unit under test(UUT)
FSM_DL UUT(
.i_password(password),
.i_confirm(confirm),
.i_switch(switch),
.i_reset(reset),
.i_clk(clk),
.o_trials(trials),
.o_state(state),
.o_correct(correct),
.o_incorrect(incorrect)
);
initial 
begin
$monitor ("[%b]\tpassword = %h\tconfirm = %d\tswitch = %b\treset = %h\ttrials = %d\tstate = %b",$time,password,confirm,switch,reset,trials,state);
end
//initialization of input
initial 
clk = 0;
always 
#1 clk = ~clk;
integer i;
initial begin
confirm =0;
reset =0;
switch =0;
password = 12'h000;
// reset to start adding pass
#50 reset =1;
#50 reset =0;
// start to put an initial pass
#50 password = 12'hABC;
confirm =1;
#50 confirm =0;
// confirming the pass
#50 password = 12'hABC;
confirm =1;
#50 confirm =0;
// variation loops 
// start to putting a wrong pass and check funcitionality of VARIFY_FAILED
for (i=0 ; i<3 ; i =i+1)begin
#50 password = 12'hDEF;
confirm =1;
#50 confirm =0;
end 
// now the system must be in FREEZE state
#50 password =12'hABC;
confirm =1;
#50 confirm =0;
// system here will be in freeze so after 100 we put switch to 1 to and then reset the app to put the pass again to complete FSM again 
#100 switch =1;
#50 switch =0;
// now device switched then reset to put password again 
#50 reset =1;
#50 reset=0;
#50 password = 12'hABC;
confirm =1;
#50 confirm =0;
// for testing SET state
#50 switch =1;
#50 switch =0;
#50 password = 12'hADF;
confirm =1;
#50 confirm =0;
#50 password = 12'hADF;
confirm =1;
#50 confirm =0;
#5 $stop ;
end


endmodule