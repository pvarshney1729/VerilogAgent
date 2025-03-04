module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    always @(*) begin
        if (load) begin
            next_q = data;
        end else begin
            next_q = q; // Default to current state
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    int alive_neighbors = 0;
                    for (int di = -1; di <= 1; di++) begin
                        for (int dj = -1; dj <= 1; dj++) begin
                            if (di == 0 && dj == 0) continue; // Skip the cell itself
                            int ni = (i + di + 16) % 16; // Toroidal wrapping
                            int nj = (j + dj + 16) % 16; // Toroidal wrapping
                            alive_neighbors += q[ni * 16 + nj];
                        end
                    end
                    // Apply the rules
                    if (q[i * 16 + j] == 1) begin
                        if (alive_neighbors < 2 || alive_neighbors > 3) begin
                            next_q[i * 16 + j] = 0; // Cell dies
                        end else begin
                            next_q[i * 16 + j] = 1; // Cell lives
                        end
                    end else begin
                        if (alive_neighbors == 3) begin
                            next_q[i * 16 + j] = 1; // Cell becomes alive
                        end else begin
                            next_q[i * 16 + j] = 0; // Cell remains dead
                        end
                    end
                end
            end
        end
    end

    always @(posedge clk) begin
        q <= next_q; // Update state on clock edge
    end

endmodule