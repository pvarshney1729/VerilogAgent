module mux2to1_8bit (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic sel,
    input logic clk,
    input logic rst_n,
    output logic [7:0] y
);

always @(*) begin
    if (!rst_n) begin
        y = 8'b00000000;
    end else begin
        y = sel ? b : a;
    end
end

endmodule