module DL_top(
i_digit,
i_confirm_getter,
i_confirm_FSM,
i_hard_reset,
i_en_display,
i_switch,
i_clk,
o_7seg_input,
o_7seg0,
o_7seg1,
o_7seg2,
o_state_7seg,
o_trials_7seg,
o_correct_led,
o_incorrect_led
);

input [3:0] i_digit;
input i_confirm_getter;
input i_confirm_FSM;
input i_hard_reset;
input i_en_display;
input i_switch;
input i_clk;

output o_correct_led;
output o_incorrect_led;
output [6:0] o_state_7seg;
output [6:0] o_trials_7seg;
output [6:0] o_7seg0;
output [6:0] o_7seg1;
output [6:0] o_7seg2;
output [6:0] o_7seg_input;

wire [11:0] password;
wire correct;
wire incorrect;
wire i_confirm_getter_pe;
wire i_confirm_FSM_pe;
wire i_switch_pe;
wire i_reset_pe;
wire [1:0] trials;
wire [2:0] state;


parameter CLK_IN = 50_000_000;

password_getter_sync PG(
        .i_digit(i_digit),
        .i_confirm(i_confirm_getter_pe),
        .i_clk(i_clk),
        .i_reset(i_hard_reset),
        .o_password(password)
    );

    FSM_DL FSM(
        .i_password(password),
        .i_confirm(i_confirm_FSM_pe),
        .i_switch(i_switch_pe),
        .i_reset(i_hard_reset_pe),
        .i_clk(i_clk),
        .o_correct(correct),
        .o_incorrect(incorrect),
        .o_trials(trials),
        .o_state(state)
    );

    pass_decoder PD(
        .i_password(password),
        .i_en(i_en_display),
        .o_7seg_0(o_7seg0),
        .o_7seg_1(o_7seg1),
        .o_7seg_2(o_7seg2)
    );

    led7_decoder LD_inp(
        .i_en(1'b1),
        .i_binary(i_digit),
        .o_7seg(o_7seg_input)
    );

    led7_decoder LD_trials(
        .i_en(1'b1),
        .i_binary(4'b11 - trials),
        .o_7seg(o_trials_7seg)
    );

    state_decoder SD(
        .i_state(state),
        .o_7seg(o_state_7seg)
    );

    LED_blinker #(.CLK_IN(CLK_IN), .FREQ_OUT(1)) LED_R(
        .i_clk(i_clk),
        .i_en(incorrect),
        .i_reset(i_hard_reset),
        .o_blink(o_incorrect_led)
    );

    LED_blinker #(.CLK_IN(CLK_IN), .FREQ_OUT(5)) LED_G(
        .i_clk(i_clk),
        .i_en(correct),
        .i_reset(i_hard_reset),
        .o_blink(o_correct_led)
    );

    posedge_detector PD0(
        .i_sig(i_confirm_getter),
        .i_clk(i_clk),
        .o_pe(i_confirm_getter_pe)
    );

    posedge_detector PD1(
        .i_sig(i_confirm_FSM),
        .i_clk(i_clk),
        .o_pe(i_confirm_FSM_pe)
    );

    posedge_detector PD2(
        .i_sig(i_switch),
        .i_clk(i_clk),
        .o_pe(i_switch_pe)
    );

    posedge_detector PD3(
        .i_sig(i_hard_reset),
        .i_clk(i_clk),
        .o_pe(i_hard_reset_pe)
    );



endmodule 
