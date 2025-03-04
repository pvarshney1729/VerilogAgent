module TopModule (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    // Function to calculate the number of alive neighbours
    function automatic logic [3:0] count_neighbours(input logic [255:0] grid, input int i, input int j);
        logic [3:0] count;
        count = grid[((i-1+16)%16)*16 + ((j-1+16)%16)] +
                grid[((i-1+16)%16)*16 + j] +
                grid[((i-1+16)%16)*16 + ((j+1)%16)] +
                grid[i*16 + ((j-1+16)%16)] +
                grid[i*16 + ((j+1)%16)] +
                grid[((i+1)%16)*16 + ((j-1+16)%16)] +
                grid[((i+1)%16)*16 + j] +
                grid[((i+1)%16)*16 + ((j+1)%16)];
        return count;
    endfunction

    // Combinational logic to determine the next state of the grid
    always @(*) begin
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                logic [3:0] neighbours;
                neighbours = count_neighbours(q, i, j);
                case (neighbours)
                    4'd2: next_q[i*16 + j] = q[i*16 + j]; // Remains unchanged
                    4'd3: next_q[i*16 + j] = 1'b1;        // Becomes alive
                    default: next_q[i*16 + j] = 1'b0;     // Becomes dead
                endcase
            end
        end
    end

    // Sequential logic for state update
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q <= 256'b0; // Reset to all zeros
        end else if (load) begin
            q <= data;   // Load new state
        end else begin
            q <= next_q; // Update to next state
        end
    end

endmodule