module TopModule (
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[30:0], (q[0] ^ q[31] ^ q[21] ^ q[1] ^ q[0])};
        end
    end

endmodule