module TopModule(
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[0] ^ q[30], q[31:1]};
        end
    end

endmodule