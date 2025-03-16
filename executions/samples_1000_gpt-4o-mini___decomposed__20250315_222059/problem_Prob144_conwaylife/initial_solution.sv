module TopModule (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg [255:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i, j, count;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    count = 0;
                    // Count neighbors with wrap-around
                    for (integer di = -1; di <= 1; di = di + 1) begin
                        for (integer dj = -1; dj <= 1; dj = dj + 1) begin
                            if (di == 0 && dj == 0) continue; // Skip the cell itself
                            count = count + q[((i + di + 16) % 16) * 16 + ((j + dj + 16) % 16)];
                        end
                    end
                    // Determine next state based on neighbor count
                    case (count)
                        0, 1: next_q[i * 16 + j] = 0; // Cell becomes 0
                        2: next_q[i * 16 + j] = q[i * 16 + j]; // State unchanged
                        3: next_q[i * 16 + j] = 1; // Cell becomes 1
                        default: next_q[i * 16 + j] = 0; // Cell becomes 0
                    endcase
                end
            end
            q <= next_q; // Update current state
        end
    end

endmodule