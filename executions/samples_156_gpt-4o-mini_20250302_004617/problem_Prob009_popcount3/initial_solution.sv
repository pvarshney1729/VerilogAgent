module TopModule (
    input logic [2:0] in,
    input logic clk,
    input logic reset,
    output logic [1:0] count
);

always @(posedge clk) begin
    if (reset) begin
        count <= 2'b00;
    end else begin
        count <= in[0] + in[1] + in[2];
    end
end

endmodule