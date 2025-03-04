module TopModule (
    input logic clk,    // Clock signal, positive-edge triggered
    input logic rst_n,  // Active-low asynchronous reset
    input logic j,      // J input, 1 bit
    input logic k,      // K input, 1 bit
    output logic Q      // Q output, 1 bit
);

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        Q <= 1'b0; // Reset state
    else begin
        case ({j, k})
            2'b00: Q <= Q;      // No change
            2'b01: Q <= 1'b0;   // Reset
            2'b10: Q <= 1'b1;   // Set
            2'b11: Q <= ~Q;     // Toggle
        endcase
    end
end

endmodule