module TopModule(
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    // Internal register to hold the current state of the grid
    logic [255:0] next_q;

    // Function to calculate the number of alive neighbors for a given cell
    function automatic logic [3:0] count_neighbors(
        input logic [15:0] row [0:15],
        input int r, c
    );
        count_neighbors = row[(r + 15) % 16][(c + 15) % 16] + row[(r + 15) % 16][c] + row[(r + 15) % 16][(c + 1) % 16] +
                          row[r][(c + 15) % 16] + /* Skip the center cell itself */ row[r][(c + 1) % 16] +
                          row[(r + 1) % 16][(c + 15) % 16] + row[(r + 1) % 16][c] + row[(r + 1) % 16][(c + 1) % 16];
    endfunction

    // Sequential logic to update the grid state
    always_ff @(posedge clk) begin
        if (load) begin
            // Load the initial state from data
            q <= data;
        end else begin
            // Calculate the next state of the grid
            logic [15:0] grid [0:15];
            for (int i = 0; i < 16; i++) begin
                grid[i] = q[(i + 1) * 16 - 1:i * 16];
            end

            for (int r = 0; r < 16; r++) begin
                for (int c = 0; c < 16; c++) begin
                    int count = count_neighbors(grid, r, c);
                    logic current_state = grid[r][c];
                    logic next_state;
                    case (count)
                        2: next_state = current_state; // State does not change
                        3: next_state = 1; // Becomes alive
                        default: next_state = 0; // Becomes dead
                    endcase
                    next_q[r * 16 + c] = next_state;
                end
            end
            q <= next_q;
        end
    end

endmodule