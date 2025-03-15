module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] current_state, next_state;

    // Function to calculate the number of neighbors for a given cell
    function automatic logic [3:0] count_neighbors(
        input logic [255:0] grid,
        input int row,
        input int col
    );
        logic [3:0] count;
        int r, c;
        count = 0;
        for (r = -1; r <= 1; r = r + 1) begin
            for (c = -1; c <= 1; c = c + 1) begin
                if (!(r == 0 && c == 0)) begin
                    int wrapped_row = (row + r + 16) % 16;
                    int wrapped_col = (col + c + 16) % 16;
                    count = count + grid[wrapped_row * 16 + wrapped_col];
                end
            end
        end
        return count;
    endfunction

    // Combinational logic to determine the next state
    always @(*) begin
        for (int row = 0; row < 16; row = row + 1) begin
            for (int col = 0; col < 16; col = col + 1) begin
                logic [3:0] neighbors = count_neighbors(current_state, row, col);
                logic cell = current_state[row * 16 + col];
                if (neighbors == 3 || (neighbors == 2 && cell == 1)) begin
                    next_state[row * 16 + col] = 1;
                end else begin
                    next_state[row * 16 + col] = 0;
                end
            end
        end
    end

    // Sequential logic to update the current state
    always_ff @(posedge clk) begin
        if (load) begin
            current_state <= data;
        end else begin
            current_state <= next_state;
        end
    end

    // Assign the current state to the output
    assign q = current_state;

endmodule