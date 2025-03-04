module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

logic [7:0] input_prev;

always_ff @(posedge clk) begin
    if (!rst_n) begin
        anyedge <= 8'b0;
        input_prev <= 8'b0;
    end else begin
        anyedge <= (in ^ input_prev);
        input_prev <= in;
    end
end

endmodule