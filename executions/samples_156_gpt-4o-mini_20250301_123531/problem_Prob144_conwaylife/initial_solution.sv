module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic load,         // Load signal, active high, synchronous
    input logic [255:0] data, // 256-bit data input for grid initialization
    output logic [255:0] q     // 256-bit output representing the current state of the grid
);

    logic [255:0] next_q; // Next state of the grid

    always @(*) begin
        next_q = q; // Default to current state
        if (load) begin
            next_q = data; // Load new data if load is high
        end else begin
            // Compute next state based on current state
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    int alive_neighbors = 0;
                    // Count alive neighbors with wrap-around logic
                    for (int di = -1; di <= 1; di++) begin
                        for (int dj = -1; dj <= 1; dj++) begin
                            if (di == 0 && dj == 0) continue; // Skip the cell itself
                            int ni = (i + di + 16) % 16; // Wrapped row index
                            int nj = (j + dj + 16) % 16; // Wrapped column index
                            alive_neighbors += q[ni * 16 + nj]; // Count alive neighbors
                        end
                    end
                    // Apply the rules to determine the next state of the cell
                    if (alive_neighbors < 2) begin
                        next_q[i * 16 + j] = 0;
                    end else if (alive_neighbors == 2) begin
                        next_q[i * 16 + j] = q[i * 16 + j];
                    end else if (alive_neighbors == 3) begin
                        next_q[i * 16 + j] = 1;
                    end else begin
                        next_q[i * 16 + j] = 0;
                    end
                end
            end
        end
    end

    always @(posedge clk) begin
        q <= next_q; // Update the state on the clock edge
    end

endmodule