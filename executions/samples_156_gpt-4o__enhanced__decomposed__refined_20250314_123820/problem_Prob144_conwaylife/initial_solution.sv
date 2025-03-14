[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    // Function to count the number of neighbors for a given cell
    function automatic [3:0] count_neighbors;
        input logic [3:0] x;
        input logic [3:0] y;
        input logic [255:0] grid;
        integer i, j;
        begin
            count_neighbors = 4'd0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (!(i == 0 && j == 0)) begin
                        if (grid[((x + i + 16) % 16) * 16 + ((y + j + 16) % 16)]) begin
                            count_neighbors = count_neighbors + 1;
                        end
                    end
                end
            end
        end
    endfunction

    // Combinational logic to compute the next state of the grid
    always @(*) begin
        integer i, j;
        logic [3:0] neighbors;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbors = count_neighbors(i, j, q);
                if (neighbors == 4'd3 || (neighbors == 4'd2 && q[i * 16 + j])) begin
                    next_q[i * 16 + j] = 1'b1;
                end else begin
                    next_q[i * 16 + j] = 1'b0;
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