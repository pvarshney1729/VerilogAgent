```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic j,
    input logic k,
    input logic rst_n,
    output logic Q
);

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            Q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00: Q <= Q;        // Retain state
                2'b01: Q <= 1'b0;     // Reset state
                2'b10: Q <= 1'b1;     // Set state
                2'b11: Q <= ~Q;       // Toggle state
                default: Q <= Q;      // Default case (should not occur)
            endcase
        end
    end

endmodule
[DONE]
```