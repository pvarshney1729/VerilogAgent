module mux_2to1_8bit (
    input logic clk,
    input logic rst_n,
    input logic sel,
    input logic [7:0] in0,
    input logic [7:0] in1,
    output logic [7:0] out
);

    always @(*) begin
        if (sel)
            out = in1;
        else
            out = in0;
    end

endmodule