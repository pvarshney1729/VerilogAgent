module TopModule(
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] next_state;

    always @(*) begin
        // Compute the next state for each cell
        for (int i = 0; i < 512; i++) begin
            logic left = (i == 511) ? 1'b0 : q[i+1];
            logic center = q[i];
            logic right = (i == 0) ? 1'b0 : q[i-1];

            // Apply Rule 110
            next_state[i] = (left & center & ~right) |
                            (left & ~center & right) |
                            (~left & center & right) |
                            (~left & center & ~right);
        end
    end

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end

endmodule