module TopModule (
    input  logic clk,
    input  logic load,
    input  logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    // Function to count alive neighbors
    function automatic [3:0] count_neighbors(input logic [255:0] grid, input integer row, input integer col);
        integer i, j;
        integer neighbor_count;
        neighbor_count = 0;

        // Neighbors relative positions
        for (i = -1; i <= 1; i++) begin
            for (j = -1; j <= 1; j++) begin
                if (i == 0 && j == 0) continue; // Skip the cell itself
                // Calculate neighbor's row and column with wrap-around
                integer n_row = (row + i + 16) % 16;
                integer n_col = (col + j + 16) % 16;
                neighbor_count += grid[n_row * 16 + n_col]; // Access the grid
            end
        end
        return neighbor_count;
    endfunction

    // Sequential logic for state update
    always_ff @(posedge clk) begin
        if (load) begin
            q <= data; // Load new state
        end else begin
            for (int r = 0; r < 16; r++) begin
                for (int c = 0; c < 16; c++) begin
                    integer neighbors = count_neighbors(q, r, c);
                    // Update the next_q based on the rules
                    if (neighbors < 2 || neighbors >= 4) begin
                        next_q[r * 16 + c] = 1'b0;
                    end else if (neighbors == 3) begin
                        next_q[r * 16 + c] = 1'b1;
                    end else begin
                        next_q[r * 16 + c] = q[r * 16 + c]; // Retain current state
                    end
                end
            end
            q <= next_q; // Update the state
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly