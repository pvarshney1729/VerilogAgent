[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    output logic [31:0] q
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h00000001;
        end else begin
            logic new_bit;
            new_bit = (q[31] ^ q[21] ^ q[1] ^ q[0]);
            q <= {q[30:0], new_bit};
        end
    end
endmodule
[DONE]