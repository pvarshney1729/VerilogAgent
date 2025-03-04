module TopModule (
    input logic clk,        // Clock signal, positive edge-triggered
    input logic load,       // Load signal, active high, synchronous
    input logic [255:0] data, // 256-bit input data for initial state of grid
    output logic [255:0] q   // 256-bit output representing the current state of the grid
);

    logic [255:0] next_state;

    // Function to count the number of neighbors for a given cell
    function automatic int count_neighbors(input int row, input int col);
        int count;
        int r, c;
        count = 0;
        for (r = -1; r <= 1; r = r + 1) begin
            for (c = -1; c <= 1; c = c + 1) begin
                if (!(r == 0 && c == 0)) begin
                    int neighbor_row = (row + r + 16) % 16;
                    int neighbor_col = (col + c + 16) % 16;
                    count = count + q[neighbor_row * 16 + neighbor_col];
                end
            end
        end
        return count;
    endfunction

    // Combinational logic to calculate the next state of the grid
    always @(*) begin
        int row, col;
        for (row = 0; row < 16; row = row + 1) begin
            for (col = 0; col < 16; col = col + 1) begin
                int neighbors = count_neighbors(row, col);
                int index = row * 16 + col;
                if (neighbors == 3) begin
                    next_state[index] = 1;
                end else if (neighbors == 2) begin
                    next_state[index] = q[index];
                end else begin
                    next_state[index] = 0;
                end
            end
        end
    end

    // Sequential logic to update the grid state
    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end

endmodule