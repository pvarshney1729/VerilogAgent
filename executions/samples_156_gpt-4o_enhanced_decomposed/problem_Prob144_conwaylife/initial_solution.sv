module TopModule(
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [15:0][15:0] grid, next_grid;
    integer i, j, ni, nj, neighbors;

    always_ff @(posedge clk) begin
        if (load) begin
            // Load initial state into grid
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= data[i*16 +: 16];
            end
        end else begin
            // Update grid state
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    // Count alive neighbors
                    neighbors = 0;
                    for (ni = -1; ni <= 1; ni = ni + 1) begin
                        for (nj = -1; nj <= 1; nj = nj + 1) begin
                            if (!(ni == 0 && nj == 0)) begin
                                neighbors = neighbors + grid[(i + ni + 16) % 16][(j + nj + 16) % 16];
                            end
                        end
                    end

                    // Apply rules
                    if (neighbors == 3 || (neighbors == 2 && grid[i][j] == 1)) begin
                        next_grid[i][j] = 1;
                    end else begin
                        next_grid[i][j] = 0;
                    end
                end
            end

            // Update grid with next state
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= next_grid[i];
            end
        end
    end

    // Assign output
    always_comb begin
        for (i = 0; i < 16; i = i + 1) begin
            q[i*16 +: 16] = grid[i];
        end
    end

endmodule