module TopModule (
    input logic a,
    input logic b,
    output logic q
);

always @(*) begin
    if (a == 1'b1 && b == 1'b1) 
        q = 1'b1;
    else if (a == 1'b0 && b == 1'b1) 
        q = 1'b0;
    else 
        q = 1'b0;
end

endmodule