```verilog
module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic load,         // Active high, synchronous load signal
    input logic [255:0] data, // 256-bit input data for initial grid state
    output logic [255:0] q    // 256-bit output representing the current grid state
);

    logic [255:0] next_q;

    // Function to count neighbors for a given cell
    function automatic int count_neighbors(input int row, input int col);
        int r, c, count;
        begin
            count = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (!(r == 0 && c == 0)) begin
                        if (q[((row + r + 16) % 16) * 16 + ((col + c + 16) % 16)]) begin
                            count = count + 1;
                        end
                    end
                end
            end
            return count;
        end
    endfunction

    // Combinational logic to determine the next state
    always @(*) begin
        int i, j, neighbors;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbors = count_neighbors(i, j);
                if (neighbors == 3 || (neighbors == 2 && q[i * 16 + j])) begin
                    next_q[i * 16 + j] = 1;
                end else begin
                    next_q[i * 16 + j] = 0;
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
```