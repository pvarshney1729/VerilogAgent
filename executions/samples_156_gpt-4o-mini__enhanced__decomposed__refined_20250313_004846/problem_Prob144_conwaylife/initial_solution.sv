[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_state;

    // Function to count live neighbors with toroidal wrapping
    function automatic logic [3:0] count_neighbors(input logic [255:0] grid, input integer row, input integer col);
        integer r, c;
        integer neighbor_row, neighbor_col;
        logic [3:0] count;
        begin
            count = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (!(r == 0 && c == 0)) begin
                        neighbor_row = (row + r + 16) % 16;
                        neighbor_col = (col + c + 16) % 16;
                        count = count + grid[neighbor_row * 16 + neighbor_col];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction

    // Combinational logic to calculate the next state
    always @(*) begin
        next_state = q; // Default to current state
        for (integer i = 0; i < 16; i = i + 1) begin
            for (integer j = 0; j < 16; j = j + 1) begin
                case (count_neighbors(q, i, j))
                    4'd0, 4'd1: next_state[i * 16 + j] = 1'b0;
                    4'd2: next_state[i * 16 + j] = q[i * 16 + j];
                    4'd3: next_state[i * 16 + j] = 1'b1;
                    default: next_state[i * 16 + j] = 1'b0;
                endcase
            end
        end
    end

    // Synchronous logic to load data or update state
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end

endmodule
[DONE]