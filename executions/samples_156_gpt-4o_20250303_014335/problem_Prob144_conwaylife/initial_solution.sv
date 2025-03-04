module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_state;

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end

    always_comb begin
        for (int row = 0; row < 16; row++) begin
            for (int col = 0; col < 16; col++) begin
                int count;
                count = 0;

                // Calculate neighbors with toroidal wrap-around
                for (int i = -1; i <= 1; i++) begin
                    for (int j = -1; j <= 1; j++) begin
                        if (!(i == 0 && j == 0)) begin
                            int neighbor_row = (row + i + 16) % 16;
                            int neighbor_col = (col + j + 16) % 16;
                            if (q[neighbor_row * 16 + neighbor_col]) begin
                                count++;
                            end
                        end
                    end
                end

                // Apply game rules
                if (count == 3 || (count == 2 && q[row * 16 + col])) begin
                    next_state[row * 16 + col] = 1;
                end else begin
                    next_state[row * 16 + col] = 0;
                end
            end
        end
    end

endmodule