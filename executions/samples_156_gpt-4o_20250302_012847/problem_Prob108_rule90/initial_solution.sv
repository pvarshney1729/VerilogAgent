module TopModule (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [511:0] data_in,
    output logic [511:0] data_out
);

    logic [511:0] state;
    logic [511:0] next_state;

    // Synchronous reset and load mechanism
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= 512'b0;
        end else if (load) begin
            state <= data_in;
        end else begin
            state <= next_state;
        end
    end

    // Rule 90 computation
    always @(*) begin
        for (int i = 0; i < 512; i++) begin
            if (i == 0) begin
                // Handle left boundary condition
                next_state[i] = state[1] ^ 1'b0;
            end else if (i == 511) begin
                // Handle right boundary condition
                next_state[i] = 1'b0 ^ state[510];
            end else begin
                // General case for Rule 90
                next_state[i] = state[i-1] ^ state[i+1];
            end
        end
    end

    // Output assignment
    assign data_out = state;

endmodule