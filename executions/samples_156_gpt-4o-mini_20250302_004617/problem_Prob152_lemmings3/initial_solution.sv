```verilog
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [3:0] data_in,
    output logic [3:0] data_out
);

    logic [3:0] state;

    // Synchronous reset and state initialization
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 4'b0000; // Initialize state to zero
        end else begin
            // State transition logic (example)
            state <= state + 1'b1; // Example state transition
        end
    end

    // Combinational logic for output
    always @(*) begin
        data_out = state; // Example output logic
    end

endmodule
```