module sign_extension (
    input logic [15:0] in_data,
    input logic clk,
    input logic reset,
    output logic [31:0] out_data
);

always @(*) begin
    if (in_data[15] == 1'b1) begin
        out_data = {16'b1111111111111111, in_data}; // Sign extend
    end else begin
        out_data = {16'b0000000000000000, in_data}; // Zero extend
    end
end

always @(posedge clk) begin
    if (reset) begin
        out_data <= 32'b0; // Initialize to zero on reset
    end
end

endmodule