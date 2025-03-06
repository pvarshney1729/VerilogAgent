```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [15:0][15:0] grid, next_grid;

    // Initialize grid on reset or load new data
    always_ff @(posedge clk) begin
        if (reset) begin
            grid <= '0;
        end else if (load) begin
            grid <= data;
        end else begin
            grid <= next_grid;
        end
    end

    // Calculate next state for each cell
    always_comb begin
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                int count = 0;
                count += grid[(i-1) & 4'hF][(j-1) & 4'hF];
                count += grid[(i-1) & 4'hF][j];
                count += grid[(i-1) & 4'hF][(j+1) & 4'hF];
                count += grid[i][(j-1) & 4'hF];
                count += grid[i][(j+1) & 4'hF];
                count += grid[(i+1) & 4'hF][(j-1) & 4'hF];
                count += grid[(i+1) & 4'hF][j];
                count += grid[(i+1) & 4'hF][(j+1) & 4'hF];

                case (count)
                    3: next_grid[i][j] = 1'b1;
                    2: next_grid[i][j] = grid[i][j];
                    default: next_grid[i][j] = 1'b0;
                endcase
            end
        end
    end

    // Flatten the grid for output
    always_comb begin
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                q[i*16 + j] = grid[i][j];
            end
        end
    end

endmodule
[DONE]
```