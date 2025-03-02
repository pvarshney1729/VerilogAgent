module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [3:0] in_data,
    output logic [3:0] out_data
);

    logic [3:0] state;

    // Synchronous reset and state initialization
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 4'b0000; // Initialize state to zero
        end else begin
            // State transition logic (example)
            state <= in_data; // Replace with actual state logic
        end
    end

    // Output logic
    always @(*) begin
        out_data = state; // Output the current state
    end

endmodule