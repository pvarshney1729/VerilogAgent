module TopModule (
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out
);
    logic [31:0] last_in;
    logic [31:0] out_reg;

    always @(posedge clk) begin
        if (reset) begin
            out_reg <= 32'b0;
        end else begin
            out_reg <= (last_in & ~in) | out_reg;
        end
        last_in <= in;
    end

    assign out = out_reg;

endmodule