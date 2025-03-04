module TopModule (
    input wire clk,
    input wire reset_n,
    input wire j,
    input wire k,
    output reg Q
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        Q <= 1'b0; // Reset state
    end else begin
        case ({j, k})
            2'b00: Q <= Q;       // No change
            2'b01: Q <= 1'b0;    // Reset
            2'b10: Q <= 1'b1;    // Set
            2'b11: Q <= ~Q;      // Toggle
        endcase
    end
end

endmodule