module TopModule (
    input logic clk,
    input logic load,
    input logic rst,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_state;

    // Function to count alive neighbors
    function automatic logic [3:0] count_neighbors(
        input logic [15:0] row_above,
        input logic [15:0] current_row,
        input logic [15:0] row_below,
        input int index
    );
        logic [3:0] count;
        count = row_above[index] + row_above[(index + 1) % 16] + row_above[(index + 15) % 16] +
                current_row[(index + 1) % 16] + current_row[(index + 15) % 16] +
                row_below[index] + row_below[(index + 1) % 16] + row_below[(index + 15) % 16];
        return count;
    endfunction

    // Combinational logic to determine next state
    always @(*) begin
        for (int row = 0; row < 16; row++) begin
            for (int col = 0; col < 16; col++) begin
                logic [3:0] neighbors;
                neighbors = count_neighbors(
                    q[((row + 15) % 16) * 16 +: 16],
                    q[row * 16 +: 16],
                    q[((row + 1) % 16) * 16 +: 16],
                    col
                );

                if (neighbors == 3 || (neighbors == 2 && q[row * 16 + col])) begin
                    next_state[row * 16 + col] = 1;
                end else begin
                    next_state[row * 16 + col] = 0;
                end
            end
        end
    end

    // Sequential logic to update state
    always_ff @(posedge clk) begin
        if (rst) begin
            q <= 256'b0;
        end else if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end

endmodule