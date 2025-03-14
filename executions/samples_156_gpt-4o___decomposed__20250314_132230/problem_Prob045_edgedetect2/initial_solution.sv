module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] in_prev;

    always_ff @(posedge clk) begin
        anyedge <= in ^ in_prev;
        in_prev <= in;
    end

endmodule