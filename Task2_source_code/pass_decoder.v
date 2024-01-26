module pass_decoder(
    i_password,
    i_en,
    o_7seg_0,
    o_7seg_1,
    o_7seg_2
);

    input [11:0] i_password;      // 12-bit input signal for the password
    input i_en;                   // Input signal for enable

    output [6:0] o_7seg_0;        // 7-segment display output for the first digit
    output [6:0] o_7seg_1;        // 7-segment display output for the second digit
    output [6:0] o_7seg_2;        // 7-segment display output for the third digit

    // Instantiate three instances of the led7_decoder module
    led7_decoder D1(
        .i_en(i_en),
        .i_binary(i_password[3:0]),
        .o_7seg(o_7seg_0)
    );
    led7_decoder D2(
        .i_en(i_en),
        .i_binary(i_password[7:4]),
        .o_7seg(o_7seg_1)
    );
    led7_decoder D3(
        .i_en(i_en),
        .i_binary(i_password[11:8]),
        .o_7seg(o_7seg_2)
    );

endmodule
