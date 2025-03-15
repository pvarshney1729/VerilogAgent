module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] current_state, next_state;

    // Synchronous load
    always @(posedge clk) begin
        if (load) begin
            current_state <= data;
        end else begin
            current_state <= next_state;
        end
    end

    // Neighbour count and next state logic
    always @(*) begin
        next_state = 256'b0; // Initialize next state to all dead cells
        for (int i = 0; i < 256; i++) begin
            int count = 0;
            // Calculate the number of alive neighbours
            for (int dx = -1; dx <= 1; dx++) begin
                for (int dy = -1; dy <= 1; dy++) begin
                    if (dx == 0 && dy == 0) continue; // Skip the cell itself
                    int x = (i % 16 + dx + 16) % 16; // Wrap around x
                    int y = (i / 16 + dy + 16) % 16; // Wrap around y
                    count += current_state[y * 16 + x];
                end
            end
            
            // Determine the next state based on the count of neighbours
            if (current_state[i]) begin
                if (count == 2 || count == 3) begin
                    next_state[i] = 1'b1; // Stay alive
                end
            end else begin
                if (count == 3) begin
                    next_state[i] = 1'b1; // Become alive
                end
            end
        end
    end

    assign q = current_state; // Output the current state

endmodule