module TopModule(
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    // Function to count neighbors considering toroidal wrapping
    function logic [3:0] count_neighbors(input logic [255:0] grid, input int row, input int col);
        logic [3:0] count;
        int r, c;
        count = 0;
        for (int i = -1; i <= 1; i++) begin
            for (int j = -1; j <= 1; j++) begin
                if (i != 0 || j != 0) begin
                    r = (row + i + 16) % 16;
                    c = (col + j + 16) % 16;
                    count += grid[r * 16 + c];
                end
            end
        end
        return count;
    endfunction

    // Combinational logic to determine the next state
    always @(*) begin
        for (int row = 0; row < 16; row++) begin
            for (int col = 0; col < 16; col++) begin
                logic [3:0] neighbors;
                neighbors = count_neighbors(q, row, col);
                case (neighbors)
                    4'd2: next_q[row * 16 + col] = q[row * 16 + col]; // Remains unchanged
                    4'd3: next_q[row * 16 + col] = 1'b1; // Becomes alive
                    default: next_q[row * 16 + col] = 1'b0; // Becomes dead
                endcase
            end
        end
    end

    // Sequential logic for state update
    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule