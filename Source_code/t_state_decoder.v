module t_state_decoder();

    reg [2:0] state;          // 3-bit register for state

    wire [6:0] out_7seg;      // 7-segment display output

    state_decoder UUT(
        .i_state(state),
        .o_7seg(out_7seg)
    );

    integer i;

    initial begin
        for (i = 0; i < 6; i = i + 1) begin  // Loop from 0 to 5
            #1 state = i;                   // Assign the current loop index to state
        end
        #1 $stop;                           // Stop the simulation after a delay of 1 time unit
    end

endmodule
