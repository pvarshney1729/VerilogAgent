module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] current_state;
    logic [255:0] next_state;

    always_ff @(posedge clk) begin
        if (load) begin
            current_state <= data;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = 256'b0; // Initialize next state to zero
        for (int i = 0; i < 256; i++) begin
            int row = i / 16;
            int col = i % 16;
            int alive_neighbors = 0;

            // Count alive neighbors with wrap-around
            for (int dr = -1; dr <= 1; dr++) begin
                for (int dc = -1; dc <= 1; dc++) begin
                    if (dr == 0 && dc == 0) continue; // Skip the cell itself
                    int neighbor_row = (row + dr + 16) % 16;
                    int neighbor_col = (col + dc + 16) % 16;
                    alive_neighbors += current_state[neighbor_row * 16 + neighbor_col];
                end
            end

            // Determine next state based on the number of alive neighbors
            if (alive_neighbors == 3) begin
                next_state[i] = 1'b1; // Cell becomes alive
            end else if (alive_neighbors == 2) begin
                next_state[i] = current_state[i]; // Cell state remains the same
            end else begin
                next_state[i] = 1'b0; // Cell becomes dead
            end
        end
    end

    assign q = current_state; // Output the current state

endmodule