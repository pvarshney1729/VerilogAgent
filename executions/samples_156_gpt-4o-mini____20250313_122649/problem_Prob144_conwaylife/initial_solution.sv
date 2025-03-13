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
        next_state = 256'b0; // Initialize next_state to all dead cells
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                int alive_count = 0;
                // Count alive neighbors
                for (int di = -1; di <= 1; di++) begin
                    for (int dj = -1; dj <= 1; dj++) begin
                        if (di == 0 && dj == 0) continue; // Skip self
                        int ni = (i + di + 16) % 16; // Wrap around
                        int nj = (j + dj + 16) % 16; // Wrap around
                        alive_count += current_state[ni * 16 + nj];
                    end
                end
                // Determine next state based on alive_count
                if (current_state[i * 16 + j] == 1'b1) begin
                    if (alive_count < 2 || alive_count > 3) begin
                        next_state[i * 16 + j] = 1'b0; // Cell dies
                    end else begin
                        next_state[i * 16 + j] = 1'b1; // Cell stays alive
                    end
                end else begin
                    if (alive_count == 3) begin
                        next_state[i * 16 + j] = 1'b1; // Cell becomes alive
                    end else begin
                        next_state[i * 16 + j] = 1'b0; // Cell stays dead
                    end
                end
            end
        end
    end

    assign q = current_state;

endmodule