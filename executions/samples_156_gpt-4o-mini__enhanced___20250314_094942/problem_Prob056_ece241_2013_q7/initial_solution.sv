module TopModule (
    input logic clk,      // Clock input, positive edge-triggered
    input logic j,       // JK input J, one bit
    input logic k,       // JK input K, one bit
    output logic Q       // Output Q, one bit, initialized to 0
);

always @(posedge clk) begin
    case ({j, k})  // Concatenating j and k to create a 2-bit vector
        2'b00: Q <= Q;           // If J=0, K=0, maintain previous state (Qold)
        2'b01: Q <= 1'b0;        // If J=0, K=1, reset Q to 0
        2'b10: Q <= 1'b1;        // If J=1, K=0, set Q to 1
        2'b11: Q <= ~Q;          // If J=1, K=1, toggle Q (complement Qold)
        default: Q <= Q;         // Default case, maintain state
    endcase
end

endmodule