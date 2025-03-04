module TopModule (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] next_q;

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 512'b0;
        end else if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

    always_comb begin
        for (int i = 0; i < 512; i++) begin
            logic left, center, right;
            left = (i == 511) ? 1'b0 : q[i+1];
            center = q[i];
            right = (i == 0) ? 1'b0 : q[i-1];

            next_q[i] = (left & ~center & ~right) |
                        (left & center & ~right) |
                        (~left & center & right) |
                        (~left & center & ~right);
        end
    end

endmodule