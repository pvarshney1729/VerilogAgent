module TopModule (
    input logic clk,
    input logic j,
    input logic k,
    input logic reset,
    output logic Q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            Q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00: Q <= Q;      // Retain state
                2'b01: Q <= 1'b0;   // Reset
                2'b10: Q <= 1'b1;   // Set
                2'b11: Q <= ~Q;     // Toggle
                default: Q <= Q;    // Default case for safety
            endcase
        end
    end

endmodule