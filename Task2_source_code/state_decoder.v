module state_decoder(
    i_state,
    o_7seg
);

    input [2:0] i_state;       // 3-bit input signal for state

    output reg [6:0] o_7seg;   // 7-segment display output register

    always @ (i_state) begin
        case (i_state)
            // Cases for each possible value of i_state
            3'b000: o_7seg = 7'b0010010;  // Assign value for state 000
            3'b001: o_7seg = 7'b1000001;  // Assign value for state 001
            3'b010: o_7seg = 7'b1000001;  // Assign value for state 010
            3'b011: o_7seg = 7'b1000001;  // Assign value for state 011
            3'b100: o_7seg = 7'b0010010;  // Assign value for state 100
            3'b101: o_7seg = 7'b0001110;  // Assign value for state 101
            default: o_7seg = 7'b1111111;  // Assign default value for other cases
        endcase
    end

endmodule

