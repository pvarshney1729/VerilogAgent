
module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    input logic reset,
    output logic [255:0] q
);

    logic [255:0] next_state;

    // Function to calculate the toroidal neighbor index
    function integer wrap_index;
        input integer index;
        begin
            if (index < 0)
                wrap_index = index + 16;
            else if (index >= 16)
                wrap_index = index - 16;
            else
                wrap_index = index;
        end
    endfunction

    // Function to calculate the number of neighbors for a given cell at (row, col)
    function [3:0] count_neighbors;
        input [255:0] grid;
        input integer row, col;
        integer x, y;
        begin
            count_neighbors = 0;
            for (x = -1; x <= 1; x = x + 1) begin
                for (y = -1; y <= 1; y = y + 1) begin
                    if (x != 0 || y != 0) begin // Skip the cell itself
                        if (grid[(wrap_index(row + x) * 16) + wrap_index(col + y)])
                            count_neighbors = count_neighbors + 1;
                    end
                end
            end
        end
    endfunction

    // Combinational logic to determine the next state of each cell
    always @(*) begin
        integer i, j;
        reg [3:0] neighbor_count;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbor_count = count_neighbors(q, i, j);
                case (neighbor_count)
                    4'd2: next_state[i*16 + j] = q[i*16 + j]; // 2 neighbors: no change
                    4'd3: next_state[i*16 + j] = 1;          // 3 neighbors: becomes 1
                    default: next_state[i*16 + j] = 0;        // 0-1 or 4+ neighbors: becomes 0
                endcase
            end
        end
    end

    // Sequential logic for state update and load
    always @(posedge clk) begin
        if (reset) begin
            q <= 256'b0; // Clear all cells on reset
        end else if (load) begin
            q <= data; // Load initial state on load
        end else begin
            q <= next_state; // Update game state
        end
    end

endmodule
