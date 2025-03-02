module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            anyedge <= 8'b0;
            prev_in <= 8'b0;
        end else begin
            anyedge <= in ^ prev_in;
            prev_in <= in;
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly