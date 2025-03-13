module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] current_state;
    logic [255:0] next_state;

    always @(posedge clk) begin
        if (load) begin
            current_state <= data;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state; // Default to current state

        for (int i = 0; i < 256; i++) begin
            int alive_neighbors = 0;

            // Calculate the number of alive neighbors
            for (int dx = -1; dx <= 1; dx++) begin
                for (int dy = -1; dy <= 1; dy++) begin
                    if (dx == 0 && dy == 0) continue; // Skip the cell itself
                    int neighbor_x = (i % 16 + dx + 16) % 16;
                    int neighbor_y = (i / 16 + dy + 16) % 16;
                    int neighbor_index = neighbor_y * 16 + neighbor_x;
                    alive_neighbors += current_state[neighbor_index];
                end
            end

            // Determine the next state based on the number of alive neighbors
            if (current_state[i] == 1'b1) begin
                if (alive_neighbors < 2 || alive_neighbors > 3) begin
                    next_state[i] = 1'b0; // Cell dies
                end
            end else begin
                if (alive_neighbors == 3) begin
                    next_state[i] = 1'b1; // Cell becomes alive
                end
            end
        end
    end

    assign q = current_state;

endmodule