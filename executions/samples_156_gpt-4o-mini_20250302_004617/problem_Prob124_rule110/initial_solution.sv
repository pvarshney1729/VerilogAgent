module rule110 (
    input logic clk,
    input logic rst_n,
    input logic [511:0] current_state,
    output logic [511:0] next_state
);

    logic [511:0] state;

    // Synchronous reset
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 512'b0; // Initialize all flip-flops to zero
        end else begin
            state <= next_state; // Update state on clock edge
        end
    end

    // Combinational logic to determine next state
    always @(*) begin
        next_state[0] = state[0] | (state[1] & ~state[0]); // Left boundary condition
        for (int i = 1; i < 511; i++) begin
            next_state[i] = (state[i-1] & ~state[i]) | (state[i] & ~state[i-1]) | (state[i+1] & state[i]);
        end
        next_state[511] = state[510] | (state[511] & ~state[510]); // Right boundary condition
    end

endmodule