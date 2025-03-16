module TopModule (
    input logic clk,
    input logic j,
    input logic k,
    input logic reset,
    output logic Q
);

always @(posedge clk) begin
    if (reset) begin
        Q <= 1'b0;
    end else begin
        case ({j, k})
            2'b00: Q <= Q;      // No change
            2'b01: Q <= 1'b0;   // Reset Q
            2'b10: Q <= 1'b1;   // Set Q
            2'b11: Q <= ~Q;     // Toggle Q
        endcase
    end
end

endmodule