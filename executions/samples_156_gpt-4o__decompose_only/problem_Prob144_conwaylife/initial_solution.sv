module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] q_reg, q_next;

    // Function to count the number of alive neighbors for a given cell
    function integer count_neighbors;
        input logic [255:0] grid;
        input integer row, col;
        integer r, c, count;
    begin
        count = 0;
        for (r = -1; r <= 1; r = r + 1) begin
            for (c = -1; c <= 1; c = c + 1) begin
                if (!(r == 0 && c == 0)) begin
                    // Calculate wrapped row and column indices
                    integer wrapped_row = (row + r + 16) % 16;
                    integer wrapped_col = (col + c + 16) % 16;
                    if (grid[wrapped_row * 16 + wrapped_col]) begin
                        count = count + 1;
                    end
                end
            end
        end
        count_neighbors = count;
    end
    endfunction

    // Logic to advance the game state by one timestep
    always @(*) begin
        integer i, j, neighbors;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbors = count_neighbors(q_reg, i, j);
                if (neighbors == 3 || (neighbors == 2 && q_reg[i * 16 + j])) begin
                    q_next[i * 16 + j] = 1;
                end else begin
                    q_next[i * 16 + j] = 0;
                end
            end
        end
    end

    // Sequential logic to update the game state
    always @(posedge clk) begin
        if (load) begin
            q_reg <= data;
        end else begin
            q_reg <= q_next;
        end
    end

    // Assign the current state to the output
    assign q = q_reg;

endmodule