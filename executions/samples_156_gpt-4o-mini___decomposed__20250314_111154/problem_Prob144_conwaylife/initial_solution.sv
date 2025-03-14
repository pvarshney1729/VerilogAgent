module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);
    logic [255:0] grid, next_grid;
    logic [3:0] neighbor_count;
    integer i, j;

    always @(posedge clk) begin
        if (load) begin
            grid <= data;
        end else begin
            grid <= next_grid;
        end
    end

    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbor_count = grid[((i-1+16)%16)*16 + ((j-1+16)%16)] +
                                  grid[((i-1+16)%16)*16 + j] +
                                  grid[((i-1+16)%16)*16 + ((j+1)%16)] +
                                  grid[(i*16 + ((j-1+16)%16))] +
                                  grid[(i*16 + ((j+1)%16))] +
                                  grid[((i+1)%16)*16 + ((j-1+16)%16)] +
                                  grid[((i+1)%16)*16 + j] +
                                  grid[((i+1)%16)*16 + ((j+1)%16)];
                                  
                case (neighbor_count)
                    4'd0, 4'd1, 4'd4: next_grid[i*16 + j] = 0;
                    4'd2: next_grid[i*16 + j] = grid[i*16 + j];
                    4'd3: next_grid[i*16 + j] = 1;
                    default: next_grid[i*16 + j] = 0;
                endcase
            end
        end
    end

    assign q = grid;

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly