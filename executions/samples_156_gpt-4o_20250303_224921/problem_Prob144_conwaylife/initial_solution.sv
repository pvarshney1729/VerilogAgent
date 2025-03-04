module TopModule (
    input logic clk,            // Clock signal
    input logic load,           // Active high, synchronous load signal
    input logic [255:0] data,   // 256-bit input for initial grid state
    output logic [255:0] q      // 256-bit output for current grid state
);

    logic [255:0] next_q;

    // Function to calculate the number of alive neighbors
    function automatic logic [3:0] count_neighbors(input logic [255:0] grid, input int row, input int col);
        logic [3:0] count;
        int r, c;
        count = 0;
        for (r = -1; r <= 1; r = r + 1) begin
            for (c = -1; c <= 1; c = c + 1) begin
                if (r != 0 || c != 0) begin
                    int wrapped_row = (row + r + 16) % 16;
                    int wrapped_col = (col + c + 16) % 16;
                    count = count + grid[wrapped_row * 16 + wrapped_col];
                end
            end
        end
        return count;
    endfunction

    // Combinational logic to compute the next state
    always @(*) begin
        for (int i = 0; i < 16; i = i + 1) begin
            for (int j = 0; j < 16; j = j + 1) begin
                logic [3:0] neighbors = count_neighbors(q, i, j);
                logic current_state = q[i * 16 + j];
                case (neighbors)
                    4'd2: next_q[i * 16 + j] = current_state;
                    4'd3: next_q[i * 16 + j] = 1'b1;
                    default: next_q[i * 16 + j] = 1'b0;
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