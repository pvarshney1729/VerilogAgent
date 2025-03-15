```verilog
module JK_flip_flop (
    input logic J,
    input logic K,
    input logic clk,
    input logic rst,
    output logic Q
);
    logic Q_next;

    always @(*) begin
        if (J == 1'b0 && K == 1'b0) begin
            Q_next = Q; // No change
        end else if (J == 1'b1 && K == 1'b0) begin
            Q_next = 1'b1; // Set
        end else if (J == 1'b0 && K == 1'b1) begin
            Q_next = 1'b0; // Reset
        end else begin
            Q_next = ~Q; // Toggle
        end
    end

    always @(posedge clk) begin
        if (rst == 1'b1) begin
            Q <= 1'b0; // Synchronous reset
        end else begin
            Q <= Q_next; // Update Q on clock edge
        end
    end

    initial begin
        Q = 1'b0; // Initialize Q to zero
    end
endmodule
```