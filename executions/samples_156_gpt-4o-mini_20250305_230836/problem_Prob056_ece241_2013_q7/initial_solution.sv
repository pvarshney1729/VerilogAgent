```verilog
module TopModule (
    input  logic clk,  // Clock signal, positive edge triggered
    input  logic j,    // J input for the JK flip-flop
    input  logic k,    // K input for the JK flip-flop
    output logic Q     // Output of the JK flip-flop
);

    always @(posedge clk) begin
        if (j == 1'b0 && k == 1'b0) begin
            Q <= Q; // No change
        end else if (j == 1'b0 && k == 1'b1) begin
            Q <= 1'b0; // Reset
        end else if (j == 1'b1 && k == 1'b0) begin
            Q <= 1'b1; // Set
        end else if (j == 1'b1 && k == 1'b1) begin
            Q <= ~Q; // Toggle
        end
    end

    initial begin
        Q = 1'b0; // Initialize Q to 0
    end

endmodule
```