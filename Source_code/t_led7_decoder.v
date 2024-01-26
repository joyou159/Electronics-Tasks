module t_led7_decoder();

    // Declare the input signals
    reg en;                    // Enable signal
    reg [3:0] binary;          // 4-bit binary input

    // Declare the output signal
    wire [6:0] out_7seg;       // 7-segment display output

    // Instantiate the led7_decoder module
    led7_decoder UUT(
        .i_en(en),
        .i_binary(binary),
        .o_7seg(out_7seg)
    );

    // Initial block to display the values of binary, en, and out_7seg
    initial begin
        $monitor("[%t]\tbinary = %d\ten = %b\tout_7seg = %b", $time, binary, en, out_7seg);
    end

    // Declare an integer variable for the loop
    integer i;

    // Initial block for initializing binary and en, and running the loop
    initial begin
        binary = 4'h7;          // Initialize binary to 7
        en = 0;                // Initialize en to 0
        #1 en = 1;              // Set en to 1 after a delay of 1 time unit
        for (i = 0; i < 16; i = i + 1) begin  // Loop from 0 to 15
            #1 binary = i;       // Set binary to the current loop index i
        end
        #1 $stop;                // Stop the simulation after a delay of 1 time unit
    end

endmodule
