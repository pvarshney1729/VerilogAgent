module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

    always_comb begin
        next_q = q; // Default to current state
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                int alive_neighbors = 0;

                // Count alive neighbors with wrap-around
                for (int di = -1; di <= 1; di++) begin
                    for (int dj = -1; dj <= 1; dj++) begin
                        if (di == 0 && dj == 0) continue; // Skip self
                        int ni = (i + di + 16) % 16; // Wrap around row
                        int nj = (j + dj + 16) % 16; // Wrap around column
                        alive_neighbors += q[ni * 16 + nj];
                    end
                end

                // Apply transition rules
                int idx = i * 16 + j;
                if (alive_neighbors == 3) begin
                    next_q[idx] = 1'b1; // Become alive
                end else if (alive_neighbors == 2) begin
                    next_q[idx] = q[idx]; // Remain unchanged
                end else begin
                    next_q[idx] = 1'b0; // Become dead
                end
            end
        end
    end

endmodule