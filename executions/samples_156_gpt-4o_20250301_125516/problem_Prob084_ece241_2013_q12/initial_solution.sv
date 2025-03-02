```verilog
module TopModule (
    input logic clk,
    input logic enable,
    input logic reset,
    input logic S,
    input logic A, B, C,
    output logic Z
);

    logic [7:0] Q; // 8-bit shift register

    // Shift register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            Q <= 8'b00000000;
        end else if (enable) begin
            Q <= {S, Q[7:1]};
        end
    end

    // Multiplexer for selecting output Z based on ABC
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
            default: Z = 1'b0; // Default case to avoid latches
        endcase
    end

endmodule
```