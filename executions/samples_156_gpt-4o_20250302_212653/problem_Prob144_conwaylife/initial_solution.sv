module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] grid;
    logic [3:0] neighbor_count [15:0][15:0];

    always_ff @(posedge clk) begin
        if (load) begin
            grid <= data;
        end else begin
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    int sum = 0;
                    for (int di = -1; di <= 1; di++) begin
                        for (int dj = -1; dj <= 1; dj++) begin
                            if (di != 0 || dj != 0) begin
                                int ni = (i + di + 16) % 16;
                                int nj = (j + dj + 16) % 16;
                                sum += grid[ni * 16 + nj];
                            end
                        end
                    end
                    neighbor_count[i][j] = sum;
                end
            end

            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    case (neighbor_count[i][j])
                        4'b0010: grid[i * 16 + j] <= grid[i * 16 + j]; // 2 neighbors, remain unchanged
                        4'b0011: grid[i * 16 + j] <= 1'b1; // 3 neighbors, become alive
                        default: grid[i * 16 + j] <= 1'b0; // 0-1 or 4+ neighbors, become dead
                    endcase
                end
            end
        end
    end

    assign q = grid;

endmodule