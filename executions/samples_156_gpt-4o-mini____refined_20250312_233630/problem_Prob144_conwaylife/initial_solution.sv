```
[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] current_state, next_state;

    always @(posedge clk) begin
        if (load) begin
            current_state <= data;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state; // Default to current state

        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                int alive_neighbors = 0;

                // Count alive neighbors with wrapping
                for (int di = -1; di <= 1; di++) begin
                    for (int dj = -1; dj <= 1; dj++) begin
                        if (di == 0 && dj == 0) continue; // Skip the cell itself
                        int ni = (i + di + 16) % 16; // Wrap around
                        int nj = (j + dj + 16) % 16; // Wrap around
                        alive_neighbors += current_state[ni * 16 + nj];
                    end
                end

                // Determine next state based on the number of alive neighbors
                if (current_state[i * 16 + j] == 1'b1) begin
                    if (alive_neighbors < 2 || alive_neighbors > 3) begin
                        next_state[i * 16 + j] = 1'b0;
                    end else begin
                        next_state[i * 16 + j] = current_state[i * 16 + j]; // Keep current state
                    end
                end else begin
                    if (alive_neighbors == 3) begin
                        next_state[i * 16 + j] = 1'b1;
                    end
                end
            end
        end
    end

    assign q = current_state;

endmodule
[DONE]
```