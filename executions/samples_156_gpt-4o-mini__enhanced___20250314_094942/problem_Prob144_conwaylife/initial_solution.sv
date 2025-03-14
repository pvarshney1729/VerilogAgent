module TopModule (
    input logic clk,                 
    input logic load,                
    input logic [255:0] data,        
    output logic [255:0] q            
);

localparam GRID_SIZE = 16; 
localparam TOTAL_CELLS = GRID_SIZE * GRID_SIZE; 

logic [255:0] next_q; // Next state of the grid

always @(*) begin
    next_q = q; // Default to current state
    // Update the state of the game based on the neighbor counts
    for (int row = 0; row < GRID_SIZE; row++) begin
        for (int col = 0; col < GRID_SIZE; col++) begin
            int alive_neighbors = 0;
            // Count alive neighbors with wrap-around
            for (int i = -1; i <= 1; i++) begin
                for (int j = -1; j <= 1; j++) begin
                    if (i == 0 && j == 0) continue; // Skip the cell itself
                    int neighbor_row = (row + i + GRID_SIZE) % GRID_SIZE;
                    int neighbor_col = (col + j + GRID_SIZE) % GRID_SIZE;
                    alive_neighbors += q[neighbor_row * GRID_SIZE + neighbor_col];
                end
            end
            
            // Apply the rules of the game
            int current_index = row * GRID_SIZE + col;
            if (alive_neighbors == 3) begin
                next_q[current_index] = 1'b1; // Becomes alive
            end else if (alive_neighbors == 2) begin
                next_q[current_index] = q[current_index]; // Stays the same
            end else begin
                next_q[current_index] = 1'b0; // Becomes dead
            end
        end
    end
end

always @(posedge clk) begin
    if (load) begin
        q <= data; // Load initial state from `data` into `q`
    end else begin
        q <= next_q; // Update state to the next state
    end
end

endmodule