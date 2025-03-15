module TopModule (
    input  logic clk,
    input  logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] reg_in;

    always @(posedge clk) begin
        reg_in <= in;
    end

    always @(*) begin
        pedge = (reg_in & ~in) >> 1;
    end

endmodule