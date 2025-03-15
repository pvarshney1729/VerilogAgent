module TopModule (
    input logic clk,
    input logic reset,
    output logic out
);

    always @(*) begin
        out = 1'b0; // Combinational output always low
    end

endmodule