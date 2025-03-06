module TopModule (
    input logic clk,            // Clock input, 1-bit
    input logic enable,         // Enable input, 1-bit, synchronous active-high
    input logic S,              // Shift register serial input, 1-bit
    input logic [2:0] ABC,      // Address input for multiplexer, 3-bit
    output logic Z              // Selected output from the shift register, 1-bit
);

    // 8-bit shift register
    logic [7:0] Q;

    // Shift register logic
    always_ff @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S}; // Shift left
        end
    end

    // Multiplexer logic
    always_comb begin
        case (ABC)
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case to handle undefined states
        endcase
    end

endmodule