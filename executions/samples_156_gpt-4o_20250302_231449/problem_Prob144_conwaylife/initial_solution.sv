```verilog
module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    // Function to count the number of living neighbors for a given cell
    function automatic [3:0] count_neighbors(
        input logic [255:0] grid,
        input int row,
        input int col
    );
        int r, c;
        count_neighbors = 0;
        for (r = -1; r <= 1; r = r + 1) begin
            for (c = -1; c <= 1; c = c + 1) begin
                if (r != 0 || c != 0) begin
                    int neighbor_row = (row + r + 16) % 16;
                    int neighbor_col = (col + c + 16) % 16;
                    count_neighbors = count_neighbors + grid[neighbor_row * 16 + neighbor_col];
                end
            end
        end
    endfunction

    // Combinational logic to determine the next state of the grid
    always @(*) begin
        for (int row = 0; row < 16; row = row + 1) begin
            for (int col = 0; col < 16; col = col + 1) begin
                int index = row * 16 + col;
                logic [3:0] neighbors = count_neighbors(q, row, col);
                case (neighbors)
                    4'd2: next_q[index] = q[index]; // Remain unchanged
                    4'd3: next_q[index] = 1'b1;     // Become alive
                    default: next_q[index] = 1'b0;  // Become dead
                endcase
            end
        end
    end

    // Sequential logic to update the grid state
    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule
```