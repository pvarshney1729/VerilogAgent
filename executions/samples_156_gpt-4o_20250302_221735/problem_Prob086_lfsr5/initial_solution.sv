module TopModule(
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001;
        end else begin
            q <= {q[3], q[4] ^ q[0], q[1], q[2], q[3]};
        end
    end

endmodule