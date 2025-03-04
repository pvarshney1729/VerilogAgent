module TopModule (
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            logic new_bit;
            new_bit = q[0] ^ q[1] ^ q[2] ^ q[22] ^ q[31];
            q <= {new_bit, q[31:1]};
        end
    end

endmodule