module TopModule (
    input logic clk,    // Clock signal
    input logic j,      // J input
    input logic k,      // K input
    input logic rst_n,  // Active-low asynchronous reset
    output logic Q      // Output Q
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            Q <= 1'b0; // Asynchronous reset to 0
        end else begin
            case ({j, k})
                2'b00: Q <= Q;       // Retain state
                2'b01: Q <= 1'b0;    // Reset to 0
                2'b10: Q <= 1'b1;    // Set to 1
                2'b11: Q <= ~Q;      // Toggle state
                default: Q <= Q;     // Default case
            endcase
        end
    end

endmodule