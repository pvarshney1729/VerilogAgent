module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);

logic [4:0] sum_internal;

always @(*) begin
    sum_internal = {1'b0, x} + {1'b0, y};
end

assign sum = sum_internal;

endmodule