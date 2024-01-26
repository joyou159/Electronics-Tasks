module led7_decoder(
    i_en,
    i_binary,
    o_7seg
);

    input i_en;              // Input signal for enable
    input [3:0] i_binary;    // 4-bit input signal

    output [6:0] o_7seg;     // 7-segment display output

    reg [6:0] value_7seg;    // Register to hold the 7-segment values

    always @ (i_binary) begin
        case (i_binary)
            // Cases for each possible value of i_binary
            4'h0: value_7seg = 7'b1000000;  // Assign value for binary 0
            4'h1: value_7seg = 7'b1111001;  // Assign value for binary 1
            4'h2: value_7seg = 7'b0100100;  // Assign value for binary 2
            4'h3: value_7seg = 7'b0110000;  // Assign value for binary 3
            4'h4: value_7seg = 7'b0011001;  // Assign value for binary 4
            4'h5: value_7seg = 7'b0010010;  // Assign value for binary 5
            4'h6: value_7seg = 7'b0000010;  // Assign value for binary 6
            4'h7: value_7seg = 7'b1111000;  // Assign value for binary 7
            4'h8: value_7seg = 7'b0000000;  // Assign value for binary 8
            4'h9: value_7seg = 7'b0010000;  // Assign value for binary 9
            4'hA: value_7seg = 7'b0001000;  // Assign value for binary A
            4'hB: value_7seg = 7'b0000011;  // Assign value for binary B
            4'hC: value_7seg = 7'b1000110;  // Assign value for binary C
            4'hD: value_7seg = 7'b0100001;  // Assign value for binary D
            4'hE: value_7seg = 7'b0000110;  // Assign value for binary E
            4'hF: value_7seg = 7'b0001110;  // Assign value for binary F
            default: value_7seg = 7'b1111111;  // Assign default value for other cases
        endcase
    end

    assign o_7seg = i_en ? value_7seg : 7'b1111111;  // Assign the output based on enable signal

endmodule
