module TopModule (
    input wire a,
    input wire b,
    output wire out_assign,
    output wire out_alwaysblock
);

// Assign statement for combinational logic
assign out_assign = a & b;

// Always block for combinational logic
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule