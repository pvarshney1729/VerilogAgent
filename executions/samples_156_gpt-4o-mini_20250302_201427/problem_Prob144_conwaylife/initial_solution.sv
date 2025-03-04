module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

    always @(*) begin
        next_q = 256'b0; // Initialize next_q to all dead cells
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                int live_neighbors = 0;
                for (int di = -1; di <= 1; di++) begin
                    for (int dj = -1; dj <= 1; dj++) begin
                        if (di == 0 && dj == 0) continue; // Skip the cell itself
                        int ni = (i + di + 16) % 16; // Toroidal wrap
                        int nj = (j + dj + 16) % 16; // Toroidal wrap
                        live_neighbors += q[ni * 16 + nj];
                    end
                end
                int index = i * 16 + j;
                if (live_neighbors == 3) begin
                    next_q[index] = 1'b1; // Cell becomes alive
                end else if (live_neighbors == 2) begin
                    next_q[index] = q[index]; // Cell remains unchanged
                end else begin
                    next_q[index] = 1'b0; // Cell becomes dead
                end
            end
        end
    end

    initial begin
        q = 256'b0; // Initialize q to all dead cells
    end

endmodule