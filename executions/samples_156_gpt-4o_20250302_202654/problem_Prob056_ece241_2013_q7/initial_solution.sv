module TopModule (
    input  logic clk,  // Clock signal, active on the rising edge
    input  logic j,    // Input signal J
    input  logic k,    // Input signal K
    input  logic rst,  // Synchronous reset signal
    output logic Q     // Output signal Q, one bit
);

    always @(posedge clk) begin
        if (rst) begin
            Q <= 1'b0;  // Reset Q to 0
        end else begin
            case ({j, k})
                2'b00: Q <= Q;        // No change
                2'b01: Q <= 1'b0;     // Reset
                2'b10: Q <= 1'b1;     // Set
                2'b11: Q <= ~Q;       // Toggle
            endcase
        end
    end

endmodule