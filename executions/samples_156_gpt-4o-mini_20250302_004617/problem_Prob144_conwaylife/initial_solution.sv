module TopModule (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [255:0] data_in,
    output logic [255:0] q
);

    logic [255:0] state, next_state;

    // Synchronous reset and loading
    always @(posedge clk) begin
        if (reset) begin
            state <= 256'b0;
        end else if (load) begin
            state <= data_in;
        end else begin
            state <= next_state;
        end
    end

    // Game logic for state transitions
    always @(*) begin
        next_state = state; // Default to current state
        for (int i = 0; i < 256; i++) begin
            int count = 0;
            // Count neighbors with toroidal wrap-around
            for (int j = -1; j <= 1; j++) begin
                for (int k = -1; k <= 1; k++) begin
                    if (j == 0 && k == 0) continue; // Skip self
                    int neighbor_index = (i + j * 16 + k) % 256; // 16 columns for toroidal wrap
                    if (neighbor_index < 0) neighbor_index += 256; // Handle negative index
                    count += state[neighbor_index];
                end
            end
            
            // Apply Game of Life rules
            if (state[i] == 1'b1) begin
                if (count < 2 || count > 3) begin
                    next_state[i] = 1'b0; // Cell dies
                end
            end else begin
                if (count == 3) begin
                    next_state[i] = 1'b1; // Cell becomes alive
                end
            end
        end
    end

    assign q = state; // Output current state

endmodule