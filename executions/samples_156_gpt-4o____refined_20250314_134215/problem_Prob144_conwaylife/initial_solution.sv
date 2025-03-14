[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    // Function to calculate the number of alive neighbors for a given cell
    function logic [3:0] count_neighbors(
        input logic [255:0] grid,
        input int row,
        input int col
    );
        int r, c;
        logic [3:0] count;
        begin
            count = 4'b0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (!(r == 0 && c == 0)) begin
                        int neighbor_row = (row + r + 16) % 16;
                        int neighbor_col = (col + c + 16) % 16;
                        count = count + grid[neighbor_row * 16 + neighbor_col];
                    end
                end
            end
            return count;
        end
    endfunction

    // Combinational logic to determine the next state of the grid
    always @(*) begin
        for (int row = 0; row < 16; row = row + 1) begin
            for (int col = 0; col < 16; col = col + 1) begin
                logic [3:0] neighbors = count_neighbors(q, row, col);
                logic current_state = q[row * 16 + col];
                if (neighbors < 2 || neighbors > 3) begin
                    next_q[row * 16 + col] = 1'b0;
                end else if (neighbors == 3) begin
                    next_q[row * 16 + col] = 1'b1;
                end else begin
                    next_q[row * 16 + col] = current_state;
                end
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
[DONE]