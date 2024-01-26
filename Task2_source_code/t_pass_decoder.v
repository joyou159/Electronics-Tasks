module t_pass_decoder();

    reg en;                    // Register for enable signal
    reg [11:0] password;       // 12-bit register for password

    wire [6:0] out_7seg_0;     // 7-segment display output for the first digit
    wire [6:0] out_7seg_1;     // 7-segment display output for the second digit
    wire [6:0] out_7seg_2;     // 7-segment display output for the third digit

    pass_decoder UUT(
        .i_en(en),
        .i_password(password),
        .o_7seg_0(out_7seg_0),
        .o_7seg_1(out_7seg_1),
        .o_7seg_2(out_7seg_2)
    );

    initial begin
        $monitor("[%t]\tpassword = %d\ten = %b\tout_7seg_0 = %b\tout_7seg_1 = %b\tout_7seg_2 = %b", $time, password, en, out_7seg_0, out_7seg_1, out_7seg_2);
    end

    integer i;

    initial begin
        password = 12'h666;       // Initialize password to hexadecimal value 666
        en = 0;                  // Initialize enable to 0
        #1 en = 1;                // Set enable to 1 after a delay of 1 time unit
        for (i = 0; i < 16; i = i + 1) begin  // Loop from 0 to 15
            #1 password = $random;    // Assign a random value to the password
        end
        #1 $stop;                 // Stop the simulation after a delay of 1 time unit
    end

endmodule
