module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

    logic xor_result;

    always @(*) begin
        xor_result = in ^ out;
    end

    always @(posedge clk) begin
        out <= xor_result;
    end

endmodule