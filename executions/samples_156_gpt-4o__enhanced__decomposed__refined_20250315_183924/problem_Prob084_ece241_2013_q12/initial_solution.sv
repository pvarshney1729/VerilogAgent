[BEGIN]
module TopModule (
    input logic clk,
    input logic enable,
    input logic S,
    input logic A,
    input logic B,
    input logic C,
    output logic Z
);

    logic [7:0] Q; // 8-bit shift register

    // Shift Register Logic
    always_ff @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]}; // Shift right and load S into Q[0]
        end
    end

    // Multiplexer Logic
    always_comb begin
        case ({A, B, C})
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case for safety
        endcase
    end

endmodule
[DONE]