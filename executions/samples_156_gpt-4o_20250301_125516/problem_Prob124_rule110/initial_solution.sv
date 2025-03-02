[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] next_q;

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i++) begin
                if (i == 0) begin
                    next_q[i] = (q[i+1] & q[i]) | (q[i] & ~1'b0) | (~q[i+1] & 1'b0);
                end else if (i == 511) begin
                    next_q[i] = (1'b0 & q[i]) | (q[i] & ~q[i-1]) | (~1'b0 & q[i-1]);
                end else begin
                    next_q[i] = (q[i+1] & q[i]) | (q[i] & ~q[i-1]) | (~q[i+1] & q[i-1]);
                end
            end
            q <= next_q;
        end
    end

endmodule
[END]

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly