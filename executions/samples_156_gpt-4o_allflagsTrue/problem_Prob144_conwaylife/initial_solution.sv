module TopModule(
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] q_next;
    integer i, j, ni, nj, count;

    // Function to count the number of alive neighbors for a given cell
    function logic [3:0] count_neighbors;
        input logic [255:0] grid;
        input integer row;
        input integer col;
        integer r, c;
        logic [3:0] count;
    begin
        count = 0;
        for (r = -1; r <= 1; r = r + 1) begin
            for (c = -1; c <= 1; c = c + 1) begin
                if (!(r == 0 && c == 0)) begin
                    count = count + grid[((row + r + 16) % 16) * 16 + ((col + c + 16) % 16)];
                end
            end
        end
        count_neighbors = count;
    end
    endfunction

    // Combinational logic to determine the next state of the grid
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                count = count_neighbors(q, i, j);
                if (count == 3) begin
                    q_next[i * 16 + j] = 1;
                end else if (count == 2) begin
                    q_next[i * 16 + j] = q[i * 16 + j];
                end else begin
                    q_next[i * 16 + j] = 0;
                end
            end
        end
    end

    // Sequential logic to update the grid state
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end

endmodule