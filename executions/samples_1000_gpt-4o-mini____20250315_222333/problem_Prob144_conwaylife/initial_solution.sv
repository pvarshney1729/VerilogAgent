module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] current_state, next_state;

    always @(posedge clk) begin
        if (load) begin
            current_state <= data;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state; // Default to current state
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                int alive_neighbors = 0;

                // Count alive neighbors with wrapping
                for (int di = -1; di <= 1; di++) begin
                    for (int dj = -1; dj <= 1; dj++) begin
                        if (di == 0 && dj == 0) continue; // Skip the cell itself
                        int ni = (i + di + 16) % 16; // Wrap around
                        int nj = (j + dj + 16) % 16; // Wrap around
                        alive_neighbors += current_state[ni * 16 + nj];
                    end
                end

                // Update next state based on the rules
                int idx = i * 16 + j;
                if (current_state[idx] == 1) begin
                    if (alive_neighbors < 2 || alive_neighbors > 3) begin
                        next_state[idx] = 0;
                    end
                end else begin
                    if (alive_neighbors == 3) begin
                        next_state[idx] = 1;
                    end
                end
            end
        end
    end

    assign q = current_state;

endmodule