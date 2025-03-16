module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] current_state, next_state;

    // Function to count the number of alive neighbors
    function automatic logic [3:0] count_neighbors(
        input logic [255:0] state,
        input int row,
        input int col
    );
        int r, c;
        logic [3:0] count;
        count = 0;
        for (r = -1; r <= 1; r = r + 1) begin
            for (c = -1; c <= 1; c = c + 1) begin
                if (!(r == 0 && c == 0)) begin
                    int neighbor_row = (row + r + 16) % 16;
                    int neighbor_col = (col + c + 16) % 16;
                    count = count + state[neighbor_row * 16 + neighbor_col];
                end
            end
        end
        return count;
    endfunction

    // Combinational logic to compute the next state
    always @(*) begin
        for (int row = 0; row < 16; row = row + 1) begin
            for (int col = 0; col < 16; col = col + 1) begin
                logic [3:0] neighbors = count_neighbors(current_state, row, col);
                logic cell = current_state[row * 16 + col];
                if (neighbors < 2 || neighbors > 3) begin
                    next_state[row * 16 + col] = 1'b0;
                end else if (neighbors == 3) begin
                    next_state[row * 16 + col] = 1'b1;
                end else begin
                    next_state[row * 16 + col] = cell;
                end
            end
        end
    end

    // Sequential logic to update the state
    always_ff @(posedge clk) begin
        if (load) begin
            current_state <= data;
        end else begin
            current_state <= next_state;
        end
    end

    // Output the current state
    assign q = current_state;

endmodule