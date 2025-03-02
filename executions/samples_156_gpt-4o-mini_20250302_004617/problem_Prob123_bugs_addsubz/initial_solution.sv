module adder_subtractor (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic sel, // 0 for addition, 1 for subtraction
    input logic clk,
    input logic rst,
    output logic [7:0] result,
    output logic zero_flag,
    output logic overflow
);

logic [8:0] sum; // 9 bits to detect overflow

always @(*) begin
    sum = (sel) ? {1'b0, a} - {1'b0, b} : {1'b0, a} + {1'b0, b};
end

always @(posedge clk) begin
    if (rst) begin
        result <= 8'b0;
        overflow <= 1'b0;
    end else begin
        result <= sum[7:0];
        overflow <= sum[8] ^ sum[7]; // Overflow detection
    end
end

assign zero_flag = (result == 8'b0);

endmodule