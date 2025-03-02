```verilog
module TopModule (
    input logic clk,
    input logic rst,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    always_ff @(posedge clk) begin
        if (rst) begin
            q <= 256'b0;
        end else if (load) begin
            q <= data;
        end else begin
            logic [255:0] new_q;
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    int live_neighbors = count_neighbors(i, j);
                    if (live_neighbors < 2 || live_neighbors > 3) begin
                        new_q[i*16 + j] = 1'b0;
                    end else if (live_neighbors == 3) begin
                        new_q[i*16 + j] = 1'b1;
                    end else begin
                        new_q[i*16 + j] = q[i*16 + j];
                    end
                end
            end
            q <= new_q;
        end
    end

    function int count_neighbors(int i, int j);
        int count = 0;
        for (int x = -1; x <= 1; x++) begin
            for (int y = -1; y <= 1; y++) begin
                if (x != 0 || y != 0) begin
                    int ni = (i + x + 16) % 16;
                    int nj = (j + y + 16) % 16;
                    count += q[ni*16 + nj];
                end
            end
        end
        return count;
    endfunction

endmodule
```