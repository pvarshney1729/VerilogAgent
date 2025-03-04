module TopModule (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] grid, next_grid;

    // Calculate the next state of the grid
    always @(*) begin
        integer row, col, idx;
        integer neighbors;
        next_grid = grid;
        
        for (row = 0; row < 16; row = row + 1) begin
            for (col = 0; col < 16; col = col + 1) begin
                idx = row * 16 + col;
                neighbors = 0;

                // Count neighbors with toroidal wrapping
                neighbors = grid[((row-1)%16)*16 + ((col-1)%16)] +
                            grid[((row-1)%16)*16 + col] +
                            grid[((row-1)%16)*16 + ((col+1)%16)] +
                            grid[row*16 + ((col-1)%16)] +
                            grid[row*16 + ((col+1)%16)] +
                            grid[((row+1)%16)*16 + ((col-1)%16)] +
                            grid[((row+1)%16)*16 + col] +
                            grid[((row+1)%16)*16 + ((col+1)%16)];

                // Apply rules
                if (neighbors < 2 || neighbors > 3)
                    next_grid[idx] = 0;
                else if (neighbors == 3)
                    next_grid[idx] = 1;
                else
                    next_grid[idx] = grid[idx];
            end
        end
    end

    // Sequential logic for updating the grid
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            grid <= 256'b0;
        end else if (load) begin
            grid <= data;
        end else begin
            grid <= next_grid;
        end
    end

    // Output the current state of the grid
    assign q = grid;

endmodule