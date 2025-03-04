module TopModule (
    input        clk,      // Clock signal
    input        enable,   // Enable signal, synchronous active high
    input        S,        // Serial input for the shift register
    input        A,        // Address bit 0 for the multiplexer
    input        B,        // Address bit 1 for the multiplexer
    input        C,        // Address bit 2 for the multiplexer
    output logic Z         // Output logic signal
);

    logic [7:0] Q; // 8-bit shift register

    // Shift register logic
    always_ff @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]}; // Shift right and insert S at MSB
        end
    end

    // Multiplexer logic
    always_comb begin
        case ({C, B, A})
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case, though not needed
        endcase
    end

endmodule